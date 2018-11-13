import 'package:flutter/material.dart';

import './showAlbums.dart';
import './listAlbums.dart';
import './createAlbum.dart';

class ManageAlbumsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
            child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Navigate'),
            ),
            ListTile(
              title: Text('All Albums'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            )
          ],
        )),
        appBar: AppBar(
          title: Text('Manage Albums'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Albums',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My Albums',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CreateAlbumPage(),
            ListAlbumPage(),
          ],
        ),
      ),
    );
  }
}
