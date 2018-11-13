import 'package:flutter/material.dart';

import './albums.dart';
import './album_control.dart';
import './domain/album.dart';

class AlbumsManager extends StatelessWidget {
 
  final List<Album> albums;
  final Function addAlbum;
  final Function deleteAlbum;

  AlbumsManager(this.albums, this.addAlbum, this.deleteAlbum);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Albums(albums, onDeleteFunc: this.deleteAlbum)),
        Container(
          alignment: Alignment.bottomRight,
          
          margin: EdgeInsets.all(10.0),
          child: AlbumControl(onPressFunc: addAlbum),
        ),
      ],
    );
  }
}
