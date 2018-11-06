import 'package:flutter/material.dart';

import '../albums_manager.dart';

class ShowAlbumsPage extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: Text('Albums'),
        ),
        body: AlbumsManager(),
      );
    }
}