import 'package:flutter/material.dart';

import './albums.dart';
import './album_control.dart';
import './domain/album.dart';

class AlbumsManager extends StatefulWidget {
  // Constructor
  AlbumsManager({this.initialAlbum});

  //Properties
  final Album initialAlbum;

  @override
  State<StatefulWidget> createState() {
    return _AlbumsManagerState();
  }
}

class _AlbumsManagerState extends State<AlbumsManager> {
  List<Album> _albums = [];

  // parent State methods
  @override
  void initState() {
    // guard clause
    if (widget.initialAlbum != null) {
      _albums.add(widget.initialAlbum);
    }

    super.initState();
  }

  void _addAlbum(Album album) {
    setState(() {
      _albums.add(album);
    });
  }

  void _deleteAlbum(int index) {
    setState(() {
      _albums.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: AlbumControl(onPressFunc: _addAlbum),
        ),
        Expanded(child: Albums(_albums, onDeleteFunc: this._deleteAlbum)),
      ],
    );
  }
}
