import 'package:flutter/material.dart';

import '../domain/album.dart';

class CreateAlbumPage extends StatefulWidget {

  final Function addAlbum;
  final Function deleteAlbum;

  CreateAlbumPage(this.addAlbum, this.deleteAlbum);

  @override
  State<StatefulWidget> createState() {
    return _CreateAlbumPageState();
  }
}

class _CreateAlbumPageState extends State<CreateAlbumPage> {
  String _titleValue = "";
  String _description = "";
  double _price = 0;


  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth =  deviceWidth> 550 ? 500 : deviceWidth * 0.95; 
    final double targetpadding = deviceWidth - targetWidth;

    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
      padding: EdgeInsets.symmetric(horizontal: targetpadding/2),
      children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: "Album Title", prefixIcon: Icon(Icons.title)),
          onChanged: (String value) {
            setState(() {
              _titleValue = value;
            });
          },
        ),
        TextField(
          decoration: InputDecoration(labelText: "Album Description", prefixIcon: Icon(Icons.description)),
          maxLines: 4,
          onChanged: (String value) {
            setState(() {
              _description = value;
            });
          },
        ),
        TextField(
          decoration: InputDecoration(labelText: "Album Price", prefixIcon: Icon(Icons.monetization_on)),
          keyboardType: TextInputType.number,
          onChanged: (String value) {
            setState(() {
              _price = double.parse(value);
            });
          },
        ),
        SizedBox(height: 10.0,),
        RaisedButton(
          color: Theme.of(context).accentColor,
          textColor: Colors.purple,
          child: Text("Add"),
          onPressed: () {
            final  newAlbum =  Album(description: _description, title: _titleValue, price: _price, imageUrl: 'assets/744857.jpg');
            widget.addAlbum(newAlbum);
            Navigator.pushReplacementNamed(context, '/albums');
          },

        )
      ],
    ),);
  }
}
