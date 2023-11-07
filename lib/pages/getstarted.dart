import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_frontend/constants/colors.dart';
import 'package:provider_frontend/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider_frontend/pages/home.dart';

// import '../constants/bnavigation.dart';
// import 'home.dart';

class GetStarted extends StatelessWidget {
  // route to another page
  static String route = '/';
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'lib/assets/images/get_started.svg', // Replace with the path to your SVG file
                width: 300, // Set the width of the SVG
                height: 300, // Set the height of the SVG
              ),
              // Lottie.asset('assets/pig bank.json'),
              Text(
                'My Pocket Money',
                style: GoogleFonts.commissioner(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(157, 118, 193, 1)),
              ),
              const SizedBox(height: 16),

              Text(
                '"Your Time. Your Terms. Start earning',
                style: GoogleFonts.commissioner(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Text(
                'on your schedule"',
                style: GoogleFonts.commissioner(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                // onPressed:(){
                //   Navigator.  push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) =>  Login(),
                //     ),
                //   );
                // },

                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  final Jstoken = prefs.getString("Jstoken");

                  if (Jstoken != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Provider_Home(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login()
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: purple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: GoogleFonts.commissioner(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
