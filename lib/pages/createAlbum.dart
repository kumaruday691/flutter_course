import 'package:flutter/material.dart';

class CreateAlbumPage extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      return Center(
        child: RaisedButton (
          child: Text('Save'),
          onPressed: () {
            showModalBottomSheet(context: context, 
            builder: (context){
              return Center(
                child: Text("This page is coming soon.."),
              );
            });
          },
        ),
      );
    }
}