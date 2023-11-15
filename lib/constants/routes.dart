import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/profilesetting.dart';



Map<String, Widget Function(BuildContext)> routes = {


  Home.route : (context) =>  const Home(),
  ProfileSetting.route : (context) =>  const ProfileSetting(),

};



