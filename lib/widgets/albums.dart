import 'package:flutter/material.dart';

import '../widgets/albumCard.dart';
import '../domain/album.dart';

class Albums extends StatelessWidget {
  // Constructor
  Albums(this.albums) {}

  // Properties
  final List<Album>
      albums; // value of the property will not change after setting

  // Helper Methods
  Widget _renderItemIfApplicable() {
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
    return _renderItemIfApplicable();
  }
}
