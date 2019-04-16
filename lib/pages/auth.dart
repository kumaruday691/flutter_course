import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scopedModels/unitOfWork.dart';


enum AuthMode {
  Signup,
  Login
}

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

  final TextEditingController _emailTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

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

   Widget _buildPasswordConfirmationTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Confirm password",
          prefixIcon: Icon(Icons.security),
          filled: true,
          fillColor: Colors.white),
      obscureText: true,
      keyboardType: TextInputType.text,
      validator: (String value){
        if(_emailTextController.text != value) {
          return "Passwords do not match";
        }
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
      controller: _emailTextController,
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

  void submitForm(Function login, Function signup) async {

    Map<String, dynamic> signUpResponse ={};
    if(_authMode == AuthMode.Login){
      signUpResponse = await login(_email, _password);
    }
    else if(_authMode == AuthMode.Signup){
      signUpResponse = await signup(_email, _password);
    }
    if(signUpResponse['success']) {
        Navigator.pushReplacementNamed(context, '/');
      }
    else{
        showDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(title: Text('An Error occured'), 
          content: Text(signUpResponse['message']), actions: <Widget>[
            FlatButton(child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },)
          ],);
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768 ? 500 : deviceWidth * 0.95;

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Container(
        decoration: BoxDecoration(image: _buildBackgroundImage()),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Column(
                children: <Widget>[
                  _buildEmailTextField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildPasswordTextField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  _authMode == AuthMode.Signup? _buildPasswordConfirmationTextField():Container(),
                  _buildSwitchTile(),
                  SizedBox(
                    height: 10.0,
                  ),
                  FlatButton(child: Text("Switch to ${_authMode == AuthMode.Login ? 'Signup': 'Login'}"),
                  onPressed: () {
                    setState(() {
                    _authMode = _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
                    });
                  },),
                  SizedBox(
                    height: 10.0,
                  ),
                  ScopedModelDescendant<UnitOfWorkModel>(
                    builder: (context, child, model) {
                      return model.isLoading? CircularProgressIndicator(): RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Colors.purple,
                        child: Text("Login"),
                        onPressed: () => submitForm(model.login, model.signUp),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
