import 'package:scoped_model/scoped_model.dart';
import '../domain/album.dart';

class AlbumsModel extends Model {
  List<Album> _albums = [];
  int _selectedAlbumIndex;
  bool _showFavs = false;

  List<Album> get albums {
    return List.from(_albums);
  }

  bool get isfavoriteSelected {
    return _showFavs;
  }

  Album get selectedAlbum {
    if (_selectedAlbumIndex == null) {
      return null;
    }

    return _albums[_selectedAlbumIndex];
  }

  List<Album> showFilteredByFavs() {
    List<Album> temp;
    if (_showFavs) {
      temp = _albums.where((Album a) => a.isFavorite).toList();
      notifyListeners();
    } else {
      temp = List.from(_albums);
      notifyListeners();
    }
    return temp;
  }

  void toggleAlbumFavoriteStatus() {
    final bool isCurrentlyFavorite = _albums[_selectedAlbumIndex].isFavorite;
    _albums[_selectedAlbumIndex].isFavorite = !isCurrentlyFavorite;
    _selectedAlbumIndex = null;
    notifyListeners();
  }

  void toggleOverallFavFilter() {
    _showFavs = !_showFavs;
    notifyListeners();
  }

  int get selectedIndex {
    return _selectedAlbumIndex;
  }

  void addAlbum(Album album) {
    _albums.add(album);
    _selectedAlbumIndex = null;
    notifyListeners();
  }

  void updateAlbum(Album album) {
    _albums[_selectedAlbumIndex] = album;
    _selectedAlbumIndex = null;
    notifyListeners();
  }

  void deleteAlbum() {
    _albums.removeAt(_selectedAlbumIndex);
    _selectedAlbumIndex = null;
    notifyListeners();
  }

  void selectAlbum(int index) {
    _selectedAlbumIndex = index;
  }
}
