import 'package:flutter/material.dart';

import './domain/album.dart';

class AlbumControl extends StatelessWidget{

  //Constructor
  AlbumControl({this.onPressFunc});

  //Properties
  final Function onPressFunc;

  @override
    Widget build(BuildContext context) {
      return FloatingActionButton( 
            onPressed: () {
              onPressFunc(Album(title: 'Reputation', description: 'Doesnt need one', imageUrl: 'assets/744857.jpg'));
            },
            child: new Icon(Icons.add, color: Theme.of(context).primaryColor,),
          );
    }
}