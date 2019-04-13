import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_course/domain/album.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_course/widgets/priceTag.dart';

import '../scopedModels/unitOfWork.dart';

class AlbumDetailPage extends StatelessWidget {

  final Album album;

  AlbumDetailPage(this.album);

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
                FadeInImage(image: NetworkImage(album.imageUrl), 
          height: 300.0,
          fit:BoxFit.cover,
          placeholder: AssetImage("assets/744857.jpg"),),
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Text(album.title),
                        Text(album.description),
                        PriceTag(album.price.toString()),
                        Text(album.userEmail)
                        ],
                    )),
              ],
            ))));
      
  }
}
