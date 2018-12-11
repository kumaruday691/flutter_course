import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../domain/album.dart';
import './priceTag.dart';
import '../scopedModels/albums.dart';

class AlbumCard extends StatelessWidget {
  final Album currentAlbum;
  final int currentIndex;

  AlbumCard(this.currentAlbum, this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(currentAlbum.imageUrl),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  currentAlbum.title,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              PriceTag(currentAlbum.price.toString())
            ],
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey, width: 1.0),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Text(currentAlbum.description)),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.info,
                    color: Colors.indigo,
                  ),
                  onPressed: () => Navigator.pushNamed<bool>(
                      context, '/album/' + currentIndex.toString())),
              ScopedModelDescendant<AlbumsModel>(builder: (context, child, model){
                return IconButton(
                  icon: Icon( model.albums[currentIndex].isFavorite ?
                    Icons.favorite : Icons.favorite_border ,
                    color: Colors.pink,
                  ),
                  onPressed: () {
                      model.selectAlbum(currentIndex);
                      model.toggleAlbumFavoriteStatus();
                  });
              },) 
            ],
          )
        ],
      ),
    );
  }
}
