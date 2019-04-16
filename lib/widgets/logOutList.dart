import 'package:flutter/material.dart';
import 'package:flutter_course/scopedModels/unitOfWork.dart';

import 'package:scoped_model/scoped_model.dart';

class LogOutListTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, UnitOfWorkModel model) {
      return ListTile(leading:Icon(Icons.exit_to_app),
      title: Text('LogOut'),
      onTap: () {
        model.logOut();
      },
      );
    });
  }

}