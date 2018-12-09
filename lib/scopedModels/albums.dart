import 'package:scoped_model/scoped_model.dart';
import '../domain/album.dart';

class AlbumsModel extends Model {
  List<Album> _albums = [];
  int _selectedAlbumIndex;

  List<Album> get albums {
    return List.from(_albums);
  }

  Album get selectedAlbum {
    if(_selectedAlbumIndex == null)
    {
      return null;
    }
    
    return _albums[_selectedAlbumIndex];
  }

  int get selectedIndex{
    return _selectedAlbumIndex;
  }

  void addAlbum(Album album) {
    _albums.add(album);
    _selectedAlbumIndex = null;
  }

  void updateAlbum(Album album) {
    _albums[_selectedAlbumIndex] = album;
    _selectedAlbumIndex = null;
  }

  void deleteAlbum() {
    _albums.removeAt(_selectedAlbumIndex);
    _selectedAlbumIndex = null;
  }

  void selectAlbum(int index) {
    _selectedAlbumIndex = index;
  }

}
