import 'package:flutter/material.dart';
import 'package:inside_api/models.dart';
import 'package:shaar_hayichud/widgets/media-list/media-item.dart';

class MediaList extends StatelessWidget {
  final Widget leadingWidget;
  final List<Media> media;
  final int sectionId;

  MediaList({this.media, this.leadingWidget, @required this.sectionId});

  @override
  Widget build(BuildContext context) {
    if (media?.isEmpty ?? true) {
      return Center(child: Text('No lessons found'));
    }

    // If there is a leading widget, index is 1 too many.
    final indexOffset = leadingWidget == null ? 0 : 1;

    return ListView.separated(
        itemCount: this.media.length + indexOffset,
        itemBuilder: (context, i) {
          if (i == 0 && leadingWidget != null) {
            return leadingWidget;
          }

          i -= indexOffset;

          return MediaItem(
            media: this.media[i],
            sectionId: this.sectionId,
            fallbackTitle: "Lesson ${i + 1}",
          );
        },
        separatorBuilder: (context, i) => Divider());
  }
}
