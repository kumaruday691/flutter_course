import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './pages/manageAlbums.dart';

import './domain/album.dart';
import './pages/auth.dart';
import './pages/showAlbums.dart';
import './pages/albumDetail.dart';
import './scopedModels/albums.dart';

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
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AlbumsModel>(
      model:AlbumsModel(),
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.indigo,
            accentColor: Colors.tealAccent),
        //home: AuthPage(),
        routes: {
          '/': (context) => AuthPage(),
          '/albums': (context) => ShowAlbumsPage(),
          '/admin': (context) => ManageAlbumsPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'album') {
            final int index = int.parse(pathElements[2]);

            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => AlbumDetailPage(index),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (context) => ShowAlbumsPage());
        },
      ),
    );
  }
}
