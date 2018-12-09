import 'package:flutter/material.dart';

import '../domain/album.dart';
import '../widgets/albums.dart';

class ShowAlbumsPage extends StatelessWidget {

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
            leading: Icon(Icons.mode_edit),
            title: Text('Manage Albums'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      )),
      appBar: AppBar(
        title: Text('Albums'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          )
        ],
      ),
      body: Albums(),
    );
  }
}
