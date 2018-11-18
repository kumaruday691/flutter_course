import 'package:flutter/material.dart';

import './pages/albumDetail.dart';
import './domain/album.dart';

class Albums extends StatelessWidget {
  // Constructor
  Albums(this.albums) {}

  // Properties
  final List<Album>  albums; // value of the property will not change after setting

  // Helper Methods
  Widget _buildAlbumItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(albums[index].imageUrl),
          Text(albums[index].title),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator.pushNamed<bool>(context, '/album/' + index.toString())
              )
            ],
          )
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
