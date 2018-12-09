import 'package:flutter/material.dart';

import '../domain/album.dart';
import './editAlbum.dart';

class ListAlbumPage extends StatelessWidget{
      final List<Album> albums;
      final Function updateAlbum;

      ListAlbumPage(this.albums, this.updateAlbum);
  @override
    Widget build(BuildContext context) {
      return ListView.builder(
        itemBuilder: (context, index){
          return ListTile(leading: Image.asset(albums[index].imageUrl),
           title: Text(albums[index].title),
           trailing: IconButton(icon: Icon(Icons.edit),
           onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context){
               return EditAlbumPage(editAlbum: albums[index],updateAlbum: updateAlbum,albumIndex: index,);
             }));
           },),
          );
        },
        itemCount: albums.length,
      );
    }
}