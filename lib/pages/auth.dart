import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _email;
  String _password;
  bool _saveLogin = false;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        image: AssetImage('assets/bg.jpg'),
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.white.withOpacity(0.3), BlendMode.dstATop));
  }

  Widget _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(
          labelText: "e-mail Id",
          prefixIcon: Icon(Icons.person),
          filled: true,
          fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      decoration: InputDecoration(
          labelText: "Password",
          prefixIcon: Icon(Icons.security),
          filled: true,
          fillColor: Colors.white),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          _password = value;
        });
      },
    );
  }

  Widget _buildSwitchTile() {
    return SwitchListTile(
      value: _saveLogin,
      onChanged: (bool value) {
        setState(() {
          _saveLogin = !_saveLogin;
        });
      },
      title: Text("Save Login for next time"),
    );
  }

  void submitForm() {
    Navigator.pushReplacementNamed(context, '/albums');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Container(
        decoration: BoxDecoration(image: _buildBackgroundImage()),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildEmailTextField(),
                _buildPasswordTextField(),
                _buildSwitchTile(),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Colors.purple,
                  child: Text("Login"),
                  onPressed: submitForm,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
