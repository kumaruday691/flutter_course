import 'package:flutter_course/scopedModels/connectedAlbumsModel.dart';
import 'package:scoped_model/scoped_model.dart';
import '../domain/album.dart';

mixin AlbumsModel on ConnectedAlbumsModel {
  bool _showFavs = false;

  List<Album> get allAlbums {
    return List.from(albums);
  }

  bool get isfavoriteSelected {
    return _showFavs;
  }

  Album get selectedAlbum {
    if (selAlbumIndex == null) {
      return null;
    }

    return albums[selAlbumIndex];
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
    final bool isCurrentlyFavorite = albums[selAlbumIndex].isFavorite;
    albums[selAlbumIndex].isFavorite = !isCurrentlyFavorite;
    final Album updatedAlbum = Album(
      title: selectedAlbum.title,
      description: selectedAlbum.description,
      imageUrl: selectedAlbum.imageUrl,
      price: selectedAlbum.price,
      userEmail: authenticatedUser.email,
      userId: authenticatedUser.id
    );
    albums[selectedIndex]= updatedAlbum;
    notifyListeners();
  }

  void toggleOverallFavFilter() {
    _showFavs = !_showFavs;
    notifyListeners();
  }

  int get selectedIndex {
    return selAlbumIndex;
  }

 void updateAlbum(String title, String description, String image, double price) {
    final Album updatedAlbum = Album(
      title: title,
      description: description,
      imageUrl: image,
      price: price,
      userEmail: selectedAlbum.userEmail,
      userId: selectedAlbum.userId
    );

    albums[selAlbumIndex] = updatedAlbum;
    notifyListeners();
  }
 

  void deleteAlbum() {
    albums.removeAt(selAlbumIndex);
    notifyListeners();
  }

  void selectAlbum(int index) {
    selAlbumIndex = index;
    if(index!=null)
    {
      notifyListeners();
    }
  }
}
