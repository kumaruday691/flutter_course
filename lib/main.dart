import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './pages/manageAlbums.dart';

import './domain/album.dart';
import './pages/auth.dart';
import './pages/showAlbums.dart';
import './pages/albumDetail.dart';
import './scopedModels/unitOfWork.dart';

void main() {
  runApp(MyApp());
}

// void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  final UnitOfWorkModel model = UnitOfWorkModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    model.autoAuthenticate();
    model.subject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    } );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UnitOfWorkModel>(
      model:model,
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.indigo,
            accentColor: Colors.tealAccent),
        //home: AuthPage(),
        routes: {
          '/': (context) =>  !_isAuthenticated ? 
          AuthPage():
          ShowAlbumsPage(model),
          '/admin': (context) => !_isAuthenticated ? 
          AuthPage(): ManageAlbumsPage(model),
        },
        onGenerateRoute: (RouteSettings settings) {
          if(!_isAuthenticated){
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => AuthPage(),
            );
          }
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'album') {
            final String id = pathElements[2];
            final Album album = model.allAlbums.firstWhere((Album al) {
              return  al.id == id;
            });

            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => !_isAuthenticated ? 
          AuthPage(): AlbumDetailPage(album),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (context) => !_isAuthenticated ? 
          AuthPage():ShowAlbumsPage(model));
        },
      ),
    );
  }
}
