import 'package:flutter/material.dart';

import '../domain/album.dart';

class AlbumDetailPage extends StatelessWidget {
  // Constructor
  AlbumDetailPage(this.album);

  //Properties
  final Album album;

  Widget _showAlertDialogWhilstDelete(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure?'),
      content: Text('This action cannot be undone'),
      actions: <Widget>[
        FlatButton(
          child: Text('YES'),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context, true);
          },
        ),
        FlatButton(
          child: Text('NO'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ],
    );
  }

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
                    showDialog(
                        context: context,
                        builder: (context) {
                          return _showAlertDialogWhilstDelete(context);
                        });
                  },
                  child: Text('Delete'),
                )
              ],
            ))));
  }
}
