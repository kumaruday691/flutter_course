import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../domain/album.dart';
import './priceTag.dart';
import '../scopedModels/unitOfWork.dart';
import 'addressTag.dart';

class AlbumCard extends StatelessWidget {
  final Album currentAlbum;
  final int currentIndex;

  AlbumCard(this.currentAlbum, this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(image: NetworkImage(currentAlbum.imageUrl), 
          height: 300.0,
          fit:BoxFit.cover,
          placeholder: AssetImage("assets/744857.jpg"),),
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
          AddressTag(currentAlbum.location.address),
          DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey, width: 1.0),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Text(currentAlbum.description)),
          ),
           ScopedModelDescendant<UnitOfWorkModel>(builder: (context, child, model){
                return ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.info,
                    color: Colors.indigo,
                  ),
                  onPressed: () => Navigator.pushNamed<bool>(
                      context, '/album/' + model.allAlbums[currentIndex].id)),
              IconButton(
                  icon: Icon( model.albums[currentIndex].isFavorite ?
                    Icons.favorite : Icons.favorite_border ,
                    color: Colors.pink,
                  ),
                  onPressed: () {
                      model.selectAlbum(model.allAlbums[currentIndex].id);
                      model.toggleAlbumFavoriteStatus();
                  })
            ]
          );
           },
      )]),
    );
  }
}
