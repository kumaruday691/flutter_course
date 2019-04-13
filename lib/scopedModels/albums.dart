import 'dart:async';

import 'package:flutter_course/scopedModels/connectedAlbumsModel.dart';
import '../domain/album.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

mixin AlbumsModel on ConnectedAlbumsModel {
  bool _showFavs = false;

  List<Album> get allAlbums {
    return List.from(albums);
  }

  List<Album> get displayedAlbums {
    if(_showFavs) {
      return albums.where((Album album) => album.isFavorite).toList();
    }
    else{
      return albums;
    }
  }

  bool get isfavoriteSelected {
    return _showFavs;
  }

  Album get selectedAlbum {
    if (selAlbumId == null) {
      return null;
    }

    return albums.firstWhere((Album album) {
      return album.id == selectedId;
    });
  }

  List<Album> showFilteredByFavs() {
    List<Album> temp;
    if (_showFavs) {
      temp = albums.where((Album a) => a.isFavorite).toList();
      notifyListeners();
    } else {
      temp = List.from(albums);
      notifyListeners();
    }
    return temp;
  }

  void toggleAlbumFavoriteStatus() {
    
    final int selectedAlbumInd = albums.indexWhere((Album album) {
      return album.id == selectedId;
    });

    final bool isCurrentlyFavorite = albums[selectedAlbumInd].isFavorite;
    albums[selectedAlbumInd].isFavorite = !isCurrentlyFavorite;
    final Album updatedAlbum = Album(
      title: selectedAlbum.title,
      description: selectedAlbum.description,
      imageUrl: selectedAlbum.imageUrl,
      price: selectedAlbum.price,
      userEmail: authenticatedUser.email,
      userId: authenticatedUser.id
    );
    albums[selectedAlbumInd]= updatedAlbum;
    notifyListeners();
  }

  void toggleOverallFavFilter() {
    _showFavs = !_showFavs;
    notifyListeners();
  }

  String get selectedId {
    return selAlbumId;
  }

  int get selectedIndex {
    return albums.indexWhere((Album album) {
      return album.id == selectedId;
    });
  }

  Future<bool> addAlbum(String title, String description, String image, double price) async {

    isLoading = true;
    notifyListeners();
    final Map<String, dynamic> albumData = {
      "title":title,
      'description':description,
      'imageUrl':"https://static.zerochan.net/Uchiha.Itachi.full.1933976.jpg", 
      'price':price,
      'userEmail':authenticatedUser.email,
      'userId':authenticatedUser.id
    }; 
    try{
      final http.Response response = await http.post("https://flutteralbums.firebaseio.com/albums.json", 
      body: json.encode(albumData));

      if(response.statusCode !=200 && response.statusCode != 201) {
        isLoading = false;
        notifyListeners();
        return false;
      }

        isLoading = false;
        final Map<String, dynamic> responseData = json.decode(response.body);

        final Album newAlbum = Album(
        id: responseData['name'],
        title: title,
        description: description,
        imageUrl: image,
        price: price,
        userEmail: authenticatedUser.email,
        userId: authenticatedUser.id
      );

      albums.add(newAlbum);
      notifyListeners();
      return true;
    }
    catch(error){
       isLoading = false;
       notifyListeners();
      return false;
    }
    
  }



 Future<bool> updateAlbum(String title, String description, String image, double price) {

   isLoading = true;
   notifyListeners();
   final Map<String, dynamic> updatedData = {
      "title":title,
      'description':description,
      'imageUrl':"https://static.zerochan.net/Uchiha.Itachi.full.1933976.jpg", 
      'price':price,
      'userEmail':authenticatedUser.email,
      'userId':authenticatedUser.id
   };

   return http.put("https://flutteralbums.firebaseio.com/albums/${selectedAlbum.id}.json",
   body: json.encode(updatedData))
   .then((http.Response response) {
     isLoading = false;
     final Album updatedAlbum = Album(
      id:selectedAlbum.id,
      title: title,
      description: description,
      imageUrl: image,
      price: price,
      userEmail: selectedAlbum.userEmail,
      userId: selectedAlbum.userId
    );

    final int selectedAlbumInd = albums.indexWhere((Album album) {
      return album.id == selectedId;
    });

    albums[selectedAlbumInd] = updatedAlbum;
    notifyListeners();
    return true;
   }).catchError((onError) {
       isLoading = false;
        notifyListeners();
        return false;
    });
    
  }
 
  Future<bool> fetchAlbums() {
    isLoading = true;
    return http.get("https://flutteralbums.firebaseio.com/albums.json").
    then((http.Response response) {

      final List<Album> fetchedAlbums = [];

      final Map<String, dynamic> getData = json.decode(response.body);

      if(getData == null) {
        isLoading = false;
        notifyListeners();
        return false;
      }

      getData.forEach((String id, dynamic currentAlbum) {
        final Album album = Album(
          id: id,
          title: currentAlbum['title'],
          description: currentAlbum['description'],
          imageUrl: currentAlbum['imageUrl'],
          price: currentAlbum['price'],
          userEmail: currentAlbum['userEmail'],
          userId: currentAlbum['userId']
        );

        fetchedAlbums.add(album);
      });

      isLoading = false;
      albums = fetchedAlbums;
      notifyListeners();
      selAlbumId = null;
      return true;
    }).catchError((onError) {
       isLoading = false;
        notifyListeners();
        return false;
    });
  }

  void deleteAlbum() {
    isLoading = true;
    final deletableId = selectedAlbum.id;
    final int selectedAlbumInd = albums.indexWhere((Album album) {
      return album.id == selectedId;
    });
    albums.removeAt(selectedAlbumInd);
    selAlbumId =  null;
    notifyListeners();

    http.delete("https://flutteralbums.firebaseio.com/albums/${deletableId}.json")
    .then((http.Response response){
      isLoading = false;
    notifyListeners();
    }).catchError((onError) {
       isLoading = false;
        notifyListeners();
        
    });
    
  }

  void selectAlbum(String id) {
    selAlbumId = id;
    if(id!=null)
    {
      notifyListeners();
    }
  }
}
