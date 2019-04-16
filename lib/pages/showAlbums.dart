import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/logOutList.dart';
import '../widgets/albums.dart';
import '../scopedModels/unitOfWork.dart';

class ShowAlbumsPage extends StatefulWidget {

  final UnitOfWorkModel model;

  ShowAlbumsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ShowAlbumsPageState();
  }
}

class _ShowAlbumsPageState extends State<ShowAlbumsPage> {

  @override
  void initState() {
    widget.model.fetchAlbums(onlyForUser: true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Navigate'),
          ),
          ListTile(
            leading: Icon(Icons.mode_edit),
            title: Text('Manage Albums'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          Divider(),
          LogOutListTile(),
        ],
      )),
      appBar: AppBar(
        title: Text('Albums'),
        actions: <Widget>[
         ScopedModelDescendant<UnitOfWorkModel>(builder: (context, child, model){
            return IconButton(
            icon: Icon(model.isfavoriteSelected ?Icons.favorite: Icons.favorite_border),
            onPressed: () {
              model.toggleOverallFavFilter();
            },
          );
         },) 
        ],
      ),
      body: _buildAlbumsList(),
    );
  }
}

Widget _buildAlbumsList() {
  return ScopedModelDescendant(builder: (BuildContext context, Widget child, UnitOfWorkModel model) {
    Widget content = Center(child:Text("No albums found!"));
    if(model.displayedAlbums.length > 0 && !model.isLoading) {
        content = Albums();
    }
    else if(model.isLoading) {
      content = Center(child:CircularProgressIndicator());
    }

    return RefreshIndicator(onRefresh: model.fetchAlbums, // needs future, so your function needs to be future
      child:content
      );
  },);
}