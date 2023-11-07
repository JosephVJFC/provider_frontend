import 'dart:developer';

import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider_frontend/constants/globalvariable.dart';
import '../constants/utilities.dart';
import '../model/user_detail_model.dart';
// import '../model/user_detailprovider.dart';
// import '../pages/home.dart';

class JsgetUser {
  Future<User> getuser({
    required context,
  }) async {
    final String apiUrl = '$JbaseUrl/api/getuser';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("Jstoken");

    FormData formData = FormData.fromMap({
      'token': token,
    });

    print(apiUrl);

    Dio dio = Dio();
    Response response = await dio.post(
      apiUrl,
      data: formData,
    );

    if (response.statusCode == 200) {
      log("status cde 200 is comming here sos shdgjkh");

      // Handle a successful response
      if (response.data['status'] == "1") {
        print('API response: ${response.data}');
        var message = response.data['response'];
        var message_two = message['user'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String Jstoken = message_two['token'];
        String Jsname = message_two['jsName'];
        String Mobile = message_two['mobileNumber'];
        String email = message_two['email'];
        String Id = message_two['jsId'];

        await prefs.setString("jsId", "$Id");
        await prefs.setString("Jstoken", "$Jstoken");

        User _user = User(
          mobileNumber: Mobile,
          name: Jsname,
          email: email,
          JsId: Id,
          token: Jstoken,
        );

        // Provider.of<UserDetailsProvider>(context,listen: false).SetUser(_user );

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Home(),
        //   ),
        // );

        return _user;
      } else {
        showCustomSnackBar(
          context: context,
          text: response.data['response'].toString(),
        );
        return User(token: '', JsId: '', email: '', name: '', mobileNumber: '');
      }
    } else {
      // Handle errors here
      print('API request failed with status code ${response.statusCode}');
      return User(token: '', JsId: '', email: '', name: '', mobileNumber: '');
    }
  }
}
