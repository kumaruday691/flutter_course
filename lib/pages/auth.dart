import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      return _AuthPageState();
    }
}

class _AuthPageState extends State<AuthPage>{

  String _email;
  String _password;
  bool _saveLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body:Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
      children: <Widget>[
       TextField(
          decoration: InputDecoration(labelText: "e-mail Id", prefixIcon: Icon(Icons.person)),
          keyboardType: TextInputType.emailAddress,
          onChanged: (String value) {
            setState(() {
              _email = value;
            });
          },
        ),
        TextField(
          decoration: InputDecoration(labelText: "Password", prefixIcon: Icon(Icons.security)),
          obscureText: true,
          onChanged: (String value) {
            setState(() {
              _password = value;
            });
          },
        ), 
        SwitchListTile(value: _saveLogin, onChanged: (bool value) {
            setState(() {
                          _saveLogin = !_saveLogin;
                        });
        },
        title: Text("Save Login for next time"),),
        SizedBox(height: 10.0,),
        RaisedButton(
          color: Theme.of(context).accentColor,
          textColor: Colors.purple,
          child: Text("Login"),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/albums');
          },

        )
      ],
    ),)
    );
  }
}
