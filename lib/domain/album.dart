import 'package:flutter/material.dart';

class Album {

  //Constructor
  Album(
    {
      this.title, 
      this.imageUrl, 
      this.description, 
      this.price, 
      this.isFavorite = false,
      this.userEmail,
      this.userId
      }
    );

  //Properties
  String title;
  String imageUrl;
  String description;
  double price;
  bool isFavorite;
  final String userEmail;
  final String userId;

}