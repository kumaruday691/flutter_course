import 'package:flutter_course/scopedModels/utility.dart';
import 'package:scoped_model/scoped_model.dart';

import './albums.dart';
import './connectedAlbumsModel.dart';
import './users.dart';

class UnitOfWorkModel extends Model with ConnectedAlbumsModel, UsersModel, UtilityModel, AlbumsModel{

}