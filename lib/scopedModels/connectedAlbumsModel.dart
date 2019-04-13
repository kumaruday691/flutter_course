import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:flutter_course/domain/album.dart';
import 'package:flutter_course/domain/user.dart';
import 'package:scoped_model/scoped_model.dart';

mixin ConnectedAlbumsModel on Model {
  
  List<Album> albums = [];
  User authenticatedUser;
  String selAlbumId;
  bool isLoading = false;


  
}