import 'package:flutter_course/domain/album.dart';
import 'package:flutter_course/domain/user.dart';
import 'package:scoped_model/scoped_model.dart';

mixin ConnectedAlbumsModel on Model {
  
  List<Album> albums = [];
  User authenticatedUser;
  int selAlbumIndex;


  void addAlbum(String title, String description, String image, double price) {
    final Album newAlbum = Album(
      title: title,
      description: description,
      imageUrl: image,
      price: price,
      userEmail: authenticatedUser.email,
      userId: authenticatedUser.id
    );

    albums.add(newAlbum);
    notifyListeners();
  }

}