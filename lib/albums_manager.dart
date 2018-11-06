import 'package:flutter/material.dart';

import './albums.dart';

class AlbumsManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlbumsManagerState();
  }
}

class _AlbumsManagerState extends State<AlbumsManager> {
  List<String> _albums = ['Red'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: RaisedButton(
            onPressed: () {
              setState(() {
                _albums.add('Reputation');
              });
            },
            child: Text('Add Album'),
          ),
        ),
        Albums(_albums),
      ],
    );
  }
}
