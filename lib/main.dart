import 'package:flutter/material.dart';
import './pages/manageAlbums.dart';

import './domain/album.dart';
import './pages/auth.dart';
import './pages/showAlbums.dart';
import './pages/albumDetail.dart';

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
  List<Album> _albums = [];

  void _addAlbum(Album album) {
    setState(() {
      _albums.add(album);
    });
  }

  void _deleteAlbum(int index) {
    setState(() {
      _albums.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.indigo,
          accentColor: Colors.tealAccent),
      //home: AuthPage(),
      routes: {
        '/': (context) => AuthPage(),
        '/albums': (context) => ShowAlbumsPage(_albums),
        '/admin': (context) => ManageAlbumsPage(_addAlbum, _deleteAlbum),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'album') {
          final int index = int.parse(pathElements[2]);

          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => AlbumDetailPage(_albums[index]),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (context) =>
                ShowAlbumsPage(_albums));
      },
    );
  }
}
