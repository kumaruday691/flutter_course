import 'package:flutter/material.dart';
import 'package:flutter_course/domain/locationData.dart';

class Album {

  //Constructor
  Album(
    {
      this.id,
      this.title, 
      this.imageUrl, 
      this.description, 
      this.price, 
      this.isFavorite = false,
      this.userEmail,
      this.userId,
      this.location
      }
    );

  //Properties
  String id;
  String title;
  String imageUrl;
  String description;
  LocationData location;
  double price;
  bool isFavorite;
  final String userEmail;
  final String userId;

}