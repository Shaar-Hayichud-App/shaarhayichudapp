import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaar_hayichud/tabs/widgets/simple-media-list-widgets.dart';
import 'package:shaar_hayichud/util/chosen-classes/chosen-class-service.dart';

class RecentsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaListTab(
      emptyMessage: 'No recent classes. What would you like to learn?',
        data: BlocProvider.getDependency<ChosenClassService>()
            .getSorted(recent: true));
  }
}
