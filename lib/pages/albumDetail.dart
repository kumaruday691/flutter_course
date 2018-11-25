import 'package:flutter/material.dart';
import 'package:flutter_course/widgets/priceTag.dart';

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
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete_forever, size: 35,),
                  color: Colors.white,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return _showAlertDialogWhilstDelete(context);
                        });
                  },
                )
              ],
            ),
            body: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(album.imageUrl),
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Text(album.title),
                        Text(album.description),
                        PriceTag(album.price.toString()),
                        ],
                    )),
              ],
            ))));
  }
}
