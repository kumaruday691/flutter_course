import 'package:flutter/material.dart';

import './pages/albumDetail.dart';
import './domain/album.dart';

class Albums extends StatelessWidget {
  // Constructor
  Albums(this.albums) {}

  // Properties
  final List<Album>
      albums; // value of the property will not change after setting

  // Helper Methods
  Widget _buildAlbumItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(albums[index].imageUrl),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                albums[index].title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 50,
              ),
              Container(
                margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.monetization_on, color: Colors.indigo,),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        albums[index].price.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                      ),
                    ],
                  )),
            ],
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey, width: 1.0),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Text(albums[index].description)),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  child: Text('Details'),
                  onPressed: () => Navigator.pushNamed<bool>(
                      context, '/album/' + index.toString()))
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
