import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb_menu/flutter_breadcrumb_menu.dart';
import 'package:inside_api/models.dart';
import 'package:shaar_hayichud/util/text-null-if-empty.dart';
import 'package:shaar_hayichud/widgets/media-list/index.dart';

/// Route to display all of the lessons for a given section.
class LessonRoute extends StatelessWidget {
  static const String routeName = "/library/lessons";

  final MediaSection lesson;

  final List<Bread> breads;

  LessonRoute({this.lesson, @required this.breads});

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8).copyWith(top: 8),
        child: MediaList(
          media: lesson.media,
          sectionId: lesson.parentId,
          leadingWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Breadcrumb(breads: breads),
              if (lesson.description?.isNotEmpty ?? false)
                textIfNotEmpty(lesson.description)
            ],
          ),
        ),
      );
}
