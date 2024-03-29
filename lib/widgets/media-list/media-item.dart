import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:inside_api/models.dart';
import 'package:shaar_hayichud/routes/player-route/index.dart';
import 'package:shaar_hayichud/util/text-null-if-empty.dart';
import 'package:shaar_hayichud/widgets/media-list/play-button.dart';

class MediaItem extends StatelessWidget {
  final Media media;
  final int sectionId;
  final String fallbackTitle;

  MediaItem({this.media, this.fallbackTitle, @required this.sectionId}) {
    media.parentId = sectionId;
  }

  @override
  Widget build(BuildContext context) {
    String title = media.title;
    Text subtitle;

    subtitle = textIfNotEmpty(media.description, maxLines: 1);

    if (title?.isEmpty ?? true) {
      title = fallbackTitle;
    }

    final style = AudioService.currentMediaItem?.id == media?.source
        ? Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(fontWeight: FontWeight.bold)
        : null;

    final onPressed = () => Navigator.of(context)
        .pushNamed(PlayerRoute.routeName, arguments: media);

    return GestureDetector(
      onTap: onPressed,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 4),
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: style,
        ),
        subtitle: subtitle,
        trailing: PlayButton(
          media: media,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
