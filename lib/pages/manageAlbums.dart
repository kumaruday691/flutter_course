import 'package:flutter/material.dart';

import './listAlbums.dart';
import './editAlbum.dart';

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
              leading: Icon(Icons.album),
              title: Text('All Albums'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/albums');
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
            EditAlbumPage(),
            ListAlbumPage(),
          ],
        ),
      ),
    );
  }
}
