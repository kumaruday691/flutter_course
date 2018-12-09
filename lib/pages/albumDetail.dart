import 'package:flutter/material.dart';
import 'package:flutter_course/domain/album.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_course/widgets/priceTag.dart';

import '../scopedModels/albums.dart';

class AlbumDetailPage extends StatelessWidget {

  final int albumIndex;

  // Constructor
  AlbumDetailPage(this.albumIndex);

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
        child:ScopedModelDescendant<AlbumsModel>(builder: (context, child, model) {
          final Album currentAlbum = model.albums[albumIndex];

          return  Scaffold(
            appBar: AppBar(
              title: Text(currentAlbum.title),
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
                Image.asset(currentAlbum.imageUrl),
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Text(currentAlbum.title),
                        Text(currentAlbum.description),
                        PriceTag(currentAlbum.price.toString()),
                        ],
                    )),
              ],
            )));
        },));
  }
}
