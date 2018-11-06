import 'package:flutter/material.dart';

import '../domain/album.dart';

class AlbumDetailPage extends StatelessWidget {
  // Constructor
  AlbumDetailPage(this.album);

  //Properties
  final Album album;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(album.title),
            ),
            body: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(album.imageUrl),
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(album.description)),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text('Delete'),
                )
              ],
            ))));
  }
}
