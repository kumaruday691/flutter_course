import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './editAlbum.dart';
import '../scopedModels/unitOfWork.dart';

class ListAlbumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UnitOfWorkModel>(builder: (context, child, model) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(model.allAlbums[index].title),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                model.selectAlbum(index);
                model.deleteAlbum();
              } else if (direction == DismissDirection.startToEnd) {
                takeToEditScreen(context, index);
              }
            },
            child: Column(
              children: <Widget>[
                ListTile(
                    leading: CircleAvatar(
                        backgroundImage:
                            AssetImage(model.allAlbums[index].imageUrl)),
                    title: Text(model.allAlbums[index].title),
                    subtitle: Text('\$${model.allAlbums[index].price}'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        model.selectAlbum(index);
                        takeToEditScreen(context, index);
                      },
                    )),
                Divider(),
              ],
            ),
          );
        },
        itemCount: model.allAlbums.length,
      );
    });
  }

  void takeToEditScreen(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return EditAlbumPage();
    }));
  }
}
