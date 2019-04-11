import 'package:flutter/material.dart';
import 'package:flutter_course/scopedModels/unitOfWork.dart';
import 'package:scoped_model/scoped_model.dart';

import '../domain/album.dart';

class EditAlbumPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditAlbumPageState();
  }
}

class _EditAlbumPageState extends State<EditAlbumPage> {
  final Album _formData = new Album(
      title: "", description: "", price: 0.0, imageUrl: 'assets/744857.jpg');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildPageContent(BuildContext context, Album editAlbum) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.95;
    final double targetpadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetpadding / 2),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Album Title", prefixIcon: Icon(Icons.title)),
                initialValue: editAlbum == null ? '' : editAlbum.title,
                validator: (String value) {
                  if (value.isEmpty || value.length < 5) {
                    return 'Title is required and should be atleast 5 character long';
                  }
                },
                onSaved: (String value) {
                  setState(() {
                    _formData.title = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Album Description",
                    prefixIcon: Icon(Icons.description)),
                initialValue: editAlbum == null ? '' : editAlbum.description,
                onSaved: (String value) {
                  setState(() {
                    _formData.description = value;
                  });
                },
                maxLines: 4,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Album Price",
                    prefixIcon: Icon(Icons.monetization_on)),
                initialValue:
                    editAlbum == null ? '' : editAlbum.price.toString(),
                validator: (String value) {
                  if (value.isEmpty ||
                      !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
                    return 'price is required and should be number';
                  }
                },
                onSaved: (String value) {
                  setState(() {
                    _formData.price = double.parse(value);
                  });
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10.0,
              ),
              ScopedModelDescendant<UnitOfWorkModel>(
                builder: (context, child, model) {
                  return RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Colors.purple,
                    child: Text("Save"),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      if (model.selectedIndex == null) {
                        model.addAlbum(_formData.title, _formData.description, _formData.imageUrl, _formData.price);
                      } else {
                        model.updateAlbum(
                          _formData.title,
                           _formData.description,
                            _formData.imageUrl,
                           _formData.price
                        );
                      }
                      Navigator.pushReplacementNamed(context, '/albums').then((_)=>model.selectAlbum(null));
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UnitOfWorkModel>(builder: (context, child, model) {
      final Widget pageContent =
          _buildPageContent(context, model.selectedAlbum);
      return model.selectedIndex == null
          ? pageContent
          : Scaffold(
              appBar: AppBar(
                title: Text('Edit Album'),
              ),
              body: pageContent,
            );
    });
  }
}
