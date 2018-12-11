import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/albums.dart';
import '../scopedModels/albums.dart';

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
         ScopedModelDescendant<AlbumsModel>(builder: (context, child, model){
            return IconButton(
            icon: Icon(model.isfavoriteSelected ?Icons.favorite: Icons.favorite_border),
            onPressed: () {
              model.toggleOverallFavFilter();
            },
          );
         },) 
        ],
      ),
      body: Albums(),
    );
  }
}
