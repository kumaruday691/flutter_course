import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/albumCard.dart';
import '../domain/album.dart';
import '../scopedModels/albums.dart';

class Albums extends StatelessWidget {

  // Helper Methods
  Widget _renderItemIfApplicable(List<Album> albums) {
    // guard clause
    if (albums.length == 0) {
      return Center(
        child: Text("No Albums added. You can add by using button above"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) => AlbumCard(albums[index], index),
        itemCount: albums.length,
      );
    }
  }

  // override build Method
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AlbumsModel>(builder: (context, widget, model) {
      return _renderItemIfApplicable(model.showFilteredByFavs()); 
    },); 
  }
}
