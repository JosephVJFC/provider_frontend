// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:provider_frontend/constants/custom_profile_setting.dart';

import '../model/user_detail_model.dart';
import '../model/user_detailprovider.dart';
import '../service/signup_service.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);
  static String route = '/profile';
  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  // int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  Jslogout  logout =Jslogout();
  String ? jpId;

  jslogout() async {
    logout.jslogout(
      jpId: jpId,
      context: context,
    );

  }
  void getuserDetails() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserDetailsProvider>(context, listen: false)
          .setUserDetails(context);
    });
  }
  @override
  void initState() {
    getuserDetails();
    super.initState();
  }


 Future <void>_showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog( // <-- SEE HERE
          title: const Text('Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to Logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                jslogout();

              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Consumer<UserDetailsProvider>(
        builder: (context, value, child) {
      User userdetails = value.userdetail;
      if (value.isloading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 30),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.black87,
                      onPressed: () {
                        // Handle arrow back button press here
                      },
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Profile',
                            style: GoogleFonts.commissioner(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' Setting',
                            style: GoogleFonts.commissioner(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: const Color.fromRGBO(157, 118, 193, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 56),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CircleAvatar(
                    maxRadius: 43,
                    backgroundImage: AssetImage("lib/images/naren.jpg"),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: <Widget>[
                      Text(
                        userdetails.name,
                        style: GoogleFonts.commissioner(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        userdetails.email,
                        style: GoogleFonts.commissioner(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: GoogleFonts.commissioner(fontSize: 11),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(120, 30),
                          backgroundColor:
                          const Color.fromRGBO(157, 118, 193, 1),
                        ),
                        onPressed: () {

                        },
                        child: Text(
                          'Edit Profile',
                          style: GoogleFonts.commissioner(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Color.fromRGBO(157, 118, 193, 1),
                      ),
                    ),
                  ],
                ),
              ),
              CustomSetting(
                  text: 'Security',
                  icon: Icons.lock_outline,
                  onPressed: () async {}),
              CustomSetting(
                  text: 'Notification',
                  icon: Icons.notifications_outlined,
                  onPressed: () async {}),
              CustomSetting(
                  text: 'My Uploaded jobs',
                  icon: Icons.subscriptions_outlined,
                  onPressed: () async {}),
              CustomSetting(
                  text: ' payment',
                  icon: Icons.description_outlined,
                  onPressed: () {}),
              CustomSetting(
                  text: 'Transaction',
                  icon: Icons.warning_amber_outlined,
                  onPressed: () async {}),
              CustomSetting(
                  text: 'Language',
                  icon: Icons.translate,
                  onPressed: () async {}),
              CustomSetting(
                  text: 'Terms and Policies',
                  icon: Icons.info_outline,
                  onPressed: () async {}),
              CustomSetting(
                  text: 'Logout',
                  icon: Icons.logout_outlined,
                  onPressed: _showAlertDialog,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(157, 118, 193, 1),
        height: 50,
      ),
    );
        });
  }
}