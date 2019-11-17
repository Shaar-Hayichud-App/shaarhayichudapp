import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:inside_chassidus/data/models/inside-data/media.dart';
import 'package:inside_chassidus/data/media-manager.dart';
import 'package:inside_chassidus/util/duration-helpers.dart';
import 'package:rxdart/rxdart.dart';

typedef Widget ProgressStreamBuilder(WithMediaState<Duration> state);

class ProgressBar extends StatelessWidget {
  final Media media;

  ProgressBar({this.media});

  @override
  Widget build(BuildContext context) {
    final mediaManager = BlocProvider.getBloc<MediaManager>();
    final progressStream =
        Observable(mediaManager.audioPlayer.onAudioPositionChanged)
            .shareValueSeeded(Duration.zero);

    final stream = CombineLatestStream([
      mediaManager.mediaState as Stream<dynamic>,
      progressStream as Stream<dynamic>
    ], (data) => WithMediaState<Duration>(state: data[0], data: data[1]))
        .asBroadcastStream();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _stateDurationStreamBuilder(stream,
            inactiveBuilder: (data) => Slider(onChanged: null, value: 0),
            builder: (data) => Slider(
                  value: data.data.inMilliseconds.toDouble(),
                  max: data.state.duration?.inMilliseconds?.toDouble(),
                  onChanged: (newProgress) => mediaManager.seek(
                      media, Duration(milliseconds: newProgress.round())),
                )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Show current time in class.
            _stateDurationStreamBuilder(stream,
                inactiveBuilder: (data) => _time(null),
                builder: (data) => _time(data.data)),
            // Show time remaining in class.
            _stateDurationStreamBuilder(stream,
                inactiveBuilder: (data) => _time(media.duration),
                builder: (data) => _time(data.state.duration - data.data))
          ],
        )
      ],
    );
  }

  /// Simplifies creating a [StreamBuilder] for [WithMediaState<Duration>]
  Widget _stateDurationStreamBuilder<T>(Stream<WithMediaState<Duration>> stream,
          {ProgressStreamBuilder builder,
          ProgressStreamBuilder inactiveBuilder}) =>
      StreamBuilder<WithMediaState<Duration>>(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.data.state.media.source != media.source ||
              !snapshot.data.state.isLoaded) {
            return inactiveBuilder(
                WithMediaState<Duration>(data: Duration.zero, state: null));
          }

          return builder(snapshot.data);
        },
      );

  /// Text representation of the given [Duration].
  Widget _time(Duration duration) => Text(toDurationString(duration));
}
