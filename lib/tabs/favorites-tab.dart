import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaar_hayichud/tabs/widgets/simple-media-list-widgets.dart';
import 'package:shaar_hayichud/util/chosen-classes/chosen-class-service.dart';

class FavoritesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaListTab(
        emptyMessage:
            'No favorites set. You can set favorites from the player.',
        data: BlocProvider.getDependency<ChosenClassService>()
            .getSorted(favorite: true));
  }
}
