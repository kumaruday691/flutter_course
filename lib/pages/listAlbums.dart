import 'package:flutter/material.dart';

import '../domain/album.dart';
import './editAlbum.dart';

class ListAlbumPage extends StatelessWidget {
  final List<Album> albums;
  final Function updateAlbum;
  final Function deleteAlbum;

  ListAlbumPage(this.albums, this.updateAlbum, this.deleteAlbum);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(albums[index].title),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              deleteAlbum(index);
            } else if (direction == DismissDirection.startToEnd) {
              takeToEditScreen(context, index);
            }
          },
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                    backgroundImage: AssetImage(albums[index].imageUrl)),
                title: Text(albums[index].title),
                subtitle: Text('\$${albums[index].price}'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    takeToEditScreen(context, index);
                  },
                ),
              ),
              Divider(),
            ],
          ),
        );
      },
      itemCount: albums.length,
    );
  }

  void takeToEditScreen(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return EditAlbumPage(
        editAlbum: albums[index],
        updateAlbum: updateAlbum,
        albumIndex: index,
      );
    }));
  }
}
