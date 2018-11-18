import 'package:flutter/material.dart';

import './albums.dart';
import './domain/album.dart';

class AlbumsManager extends StatelessWidget {
 
  final List<Album> albums;

  AlbumsManager(this.albums);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Albums(albums)),
      ],
    );
  }
}
