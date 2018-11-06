import 'package:flutter/material.dart';

class AlbumControl extends StatelessWidget{

  //Constructor
  AlbumControl({this.onPressFunc});

  //Properties
  final Function onPressFunc;

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return RaisedButton(textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              onPressFunc('reputation');
            },
            child: Text('Add Album'),
          );
    }
}