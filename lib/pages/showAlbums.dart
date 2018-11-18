import 'package:flutter/material.dart';

import '../domain/album.dart';
import '../albums_manager.dart';
import './manageAlbums.dart';

class ShowAlbumsPage extends StatelessWidget {

  final List<Album> albums;

  ShowAlbumsPage(this.albums);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Navigate'),
          ),
          ListTile(
            title: Text('Manage Albums'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      )),
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: AlbumsManager(albums),
    );
  }
}
