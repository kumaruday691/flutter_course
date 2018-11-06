import 'package:flutter/material.dart';

class Albums extends StatelessWidget {

  // Constructor
  Albums(this.albums);

  // Properties
  final List<String> albums; // value of the property will not change after setting

  // override build Method
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Column(
          children: albums
              .map((element) => Card(
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/744857.jpg'),
                        Text(element),
                      ],
                    ),
                  ))
              .toList(),
        );
    }
}