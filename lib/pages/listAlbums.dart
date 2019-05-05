import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './editAlbum.dart';
import '../scopedModels/unitOfWork.dart';

class ListAlbumPage extends StatefulWidget {

  final UnitOfWorkModel model;

  ListAlbumPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ListAlbumPageState();
  }
}

class _ListAlbumPageState extends State<ListAlbumPage> {

  @override
  void initState() {
    widget.model.fetchAlbums(onlyForUser: true).then((bool isSuccess) {
                              if(!isSuccess){
                                showDialog(context: context, builder: (BuildContext context){
                                  return AlertDialog(title: Text('Could not complete request'),
                                  content: Text('Try later'),
                                  actions: <Widget>[
                                    FlatButton(child:Text("Okay"),
                                    onPressed: () => Navigator.of(context).pop(),)
                                  ],);
                                });
                                return;
                              }});
    super.initState();
  }

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
                model.selectAlbum(model.allAlbums[index].id);
                model.deleteAlbum();
              } else if (direction == DismissDirection.startToEnd) {
                takeToEditScreen(context, index, model);
              }
            },
            child: Column(
              children: <Widget>[
                ListTile(
                    leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(model.allAlbums[index].imageUrl)),
                    title: Text(model.allAlbums[index].title),
                    subtitle: Text('\$${model.allAlbums[index].price}'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        model.selectAlbum(model.allAlbums[index].id);
                        takeToEditScreen(context, index, model);
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

  void takeToEditScreen(BuildContext context, int index, UnitOfWorkModel model) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return EditAlbumPage();
    })).then((_){
      model.selectAlbum(null);
    });
  }
}
