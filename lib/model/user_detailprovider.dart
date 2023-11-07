import 'dart:developer';

import 'package:flutter/cupertino.dart';
// import 'package:mpm_frontend/model/user_detail_model.dart';
import 'package:provider_frontend/model/user_detail_model.dart';

import '../service/user_detail_service.dart';

class UserDetailsProvider extends ChangeNotifier{
User _user = User(
  mobileNumber: '',
  name: '',
  email: '',
  JsId: '',
  token: '',
);

User get userdetail =>_user;

bool isloading = false;
void setUserDetails ( context) async {
  isloading = true;
  notifyListeners();
  _user =  await JsgetUser().getuser(context: context);
  isloading = false;
  notifyListeners();
}

}