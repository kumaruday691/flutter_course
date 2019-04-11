import 'package:flutter_course/scopedModels/connectedAlbumsModel.dart';
import 'package:scoped_model/scoped_model.dart';

import '../domain/user.dart';

mixin UsersModel on ConnectedAlbumsModel {


  void login(String email, String password){
    authenticatedUser = User(id: 'uk', email: email, password: password);
  }

}