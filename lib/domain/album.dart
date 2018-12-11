import 'package:flutter/material.dart';

class Album {

  //Constructor
  Album({this.title, this.imageUrl, this.description, this.price, this.isFavorite = false});

  //Properties
  String title;
  String imageUrl;
  String description;
  double price;
  bool isFavorite;

}