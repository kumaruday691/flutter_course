import 'package:flutter_course/scopedModels/connectedAlbumsModel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'dart:convert';
import 'dart:async';
import '../domain/user.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin UsersModel on ConnectedAlbumsModel {

  Timer _authTimer;
  PublishSubject<bool> subject = PublishSubject();

  void autoAuthenticate() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final String expiryTimeString = prefs.getString('expiryTime');

    if(token != null){
      final DateTime  now = DateTime.now();
      final parsedExpirtyTime = DateTime.parse(expiryTimeString);

      if(parsedExpirtyTime.isBefore(now)){
        authenticatedUser = null;
        notifyListeners();
        return;
      }

      final String userEmail = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');
      final int tokenLifeSpan = parsedExpirtyTime.difference(now).inSeconds;
      authenticatedUser = User(id: userId, email: userEmail, token: token);
      this.subject.add(true);
      this.setAuthTimeOut(tokenLifeSpan);
      notifyListeners();
    }
  } 

  void setAuthTimeOut(int time) {
    _authTimer = Timer(Duration(seconds: time), () {
      this.logOut();
    });
  }

  void logOut() async{
    authenticatedUser = null;
    _authTimer.cancel();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
    this.subject.add(false);
  }

  Future<Map<String, dynamic>> login(String email, String password) async{

    isLoading = true;
    notifyListeners();

    final Map<String, dynamic> authData = {
      "email":email,
      "password":password,
      "returnSecureToken":true
    };

    final http.Response response = await http.post(
      "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyBUY0ZvtDbjc-FUs-ATnvNKrXxDMyw8LbU",
      body:json.encode(authData), 
      headers: {'Content-Type':'application/json'}
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = "Could not verify password";
    if(responseData.containsKey('idToken')){
      hasError = false;
      message = 'Login Sucess';
      authenticatedUser = User(id: responseData['localId'], email: email, token: responseData['idToken']);
      this.setAuthTimeOut(int.parse(responseData['expiresIn']));
      this.setInternalStorage(responseData);
      this.subject.add(true);
    }
    else if(responseData.containsKey('error')){
      hasError = true;
      message = responseData['error']['message'];
    }

    isLoading = false;
    notifyListeners();
    print(json.decode(response.body));
    return {'success':!hasError, 'message':message};
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async{
    isLoading = true;
    notifyListeners();

    final Map<String, dynamic> authData = {
      "email":email,
      "password":password,
      "returnSecureToken":true
    };

    final http.Response response = await http.post(
      "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyBUY0ZvtDbjc-FUs-ATnvNKrXxDMyw8LbU",
      body:json.encode(authData), 
      headers: {'Content-Type':'application/json'}
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = "Could not finish signup";
    if(responseData.containsKey('idToken')){
      hasError = false;
      message = 'Signup Sucess';
      authenticatedUser = User(id: responseData['localId'], email: email, token: responseData['idToken']);
      this.setAuthTimeOut(int.parse(responseData['expiresIn']));
      this.setInternalStorage(responseData);
      this.subject.add(true);
    }
    else if(responseData.containsKey('error')){
      hasError = true;
      message = responseData['error']['message'];
    }

    isLoading = false;
    notifyListeners();
    print(json.decode(response.body));
    return {'success':!hasError, 'message':message};
  }

  void setInternalStorage(Map<String, dynamic> responseData) async{
    final DateTime now = DateTime.now();
    final DateTime expiryTime = now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
    final SharedPreferences prefs =  await SharedPreferences.getInstance();
    prefs.setString('token', responseData['idToken']);
    prefs.setString('userEmail', responseData['email']);
    prefs.setString('userId', responseData['localId']);
    prefs.setString('expiryTime', expiryTime.toIso8601String());
  }

}