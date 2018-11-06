import 'package:flutter/material.dart';

import './albums.dart';
import './album_control.dart';

class AlbumsManager extends StatefulWidget {
  // Constructor
  AlbumsManager({this.initialAlbum});

  //Properties
  final String initialAlbum;

  @override
  State<StatefulWidget> createState() {
    return _AlbumsManagerState();
  }
}

class _AlbumsManagerState extends State<AlbumsManager> {
  List<String> _albums = [];

  // parent State methods
  @override
  void initState() {
    // guard clause
    if (widget.initialAlbum != null) {
      _albums.add(widget.initialAlbum);
    }

    super.initState();
  }

  void _addAlbum(String album) {
    setState(() {
      _albums.add(album);
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
        Expanded(child: Albums(_albums)),
      ],
    );
  }
}
