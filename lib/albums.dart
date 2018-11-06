import 'package:flutter/material.dart';

class Albums extends StatelessWidget {
  // Constructor
  Albums([this.albums = const []]) {}

  // Properties
  final List<String>
      albums; // value of the property will not change after setting

  // Helper Methods
  Widget _buildAlbumItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/744857.jpg'),
          Text(albums[index]),
        ],
      ),
    );
  }

  Widget _renderItemIfApplicable() {
    // guard clause
    if (albums.length == 0) {
      return Center(
        child: Text("No Albums added. You can add by using button above"),
      );
    } else {
      return ListView.builder(
        itemBuilder: _buildAlbumItem,
        itemCount: albums.length,
      );
    }
  }

  // override build Method
  @override
  Widget build(BuildContext context) {
    return _renderItemIfApplicable();
  }
}
