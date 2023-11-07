// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_frontend/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_frontend/constants/validation.dart';
import 'package:provider_frontend/pages/login.dart';
// import 'package:provider_frontend/pages/otp_verification.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../service/signup_service.dart';

void main() {}

class JpRegister extends StatefulWidget {
  const JpRegister({super.key});
  static String route = '/jsuser/signup';

  @override
  State<JpRegister> createState() => _JpRegisterState();
}

class _JpRegisterState extends State<JpRegister> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController mobileNumbercontroller = TextEditingController();

  Jssignup register = Jssignup();

  // Future<bool> _onWillPop() async {
  //   return (await showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: new Text('Are you sure?'),
  //       content: new Text('Do you want to exit an App'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
  //           child: new Text('No'),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(true), // <-- SEE HERE
  //           child: new Text('Yes'),
  //         ),
  //       ],
  //     ),
  //   )) ??
  //       false;
  // }

  insertrecord() async {
    register.signup(
        name: namecontroller.text,
        email: emailcontroller.text,
        mobileNumber: mobileNumbercontroller.text,
        context: context);
  }

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    mobileNumbercontroller.dispose();
    emailcontroller.dispose();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            // final mediaQuery = MediaQuery.of(context);
            // final size = MediaQuery.of(context).size;
            return SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey1,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),

                        SvgPicture.asset(
                          'lib/assets/images/register.svg',
                          // Replace with the path to your SVG file
                          width: 160, // Set the width of the SVG
                          height: 160, // Set the height of the SVG
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Lets',
                              style: GoogleFonts.commissioner(
                                  fontSize: 24, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              ' Register',
                              style: GoogleFonts.commissioner(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(157, 118, 193, 1),
                              ),
                            ),
                            Text(
                              ' Account',
                              style: GoogleFonts.commissioner(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5), // Add some spacing

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hello user,Start your part \n time journey now !',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.commissioner(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 10),
                          child: Container(
                            // height: 60,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator:
                                  ValidationforTextformField().validateUsername,
                              controller: namecontroller,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                // labelText: 'User Name',
                                hintText: 'Enter Your Name',
                                hintStyle: GoogleFonts.commissioner(),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 11),
                          child: Container(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator:
                                  ValidationforTextformField().validateEmail,
                              controller: emailcontroller,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                // labelText: 'User Name',
                                hintText: 'Enter Your Email ',
                                hintStyle: GoogleFonts.commissioner(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 11),
                            child: Container(
                              child: IntlPhoneField(
                                // decoration: InputDecoration(
                                //   labelText: 'Phone Number',
                                //   // border: OutlineInputBorder(
                                //   //   borderSide: BorderSide(),
                                //   // ),
                                // ),
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: mobileNumbercontroller,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  // labelText: 'User Name',
                                  hintText: 'Enter Mobile Number',
                                  hintStyle: GoogleFonts.commissioner(),
                                ),
                                initialCountryCode: 'IN',
                                // onChanged: (phone) {
                                //   print(phone.completeNumber);
                                // },
                              ),

                              // child:TextFormField(
                              //   keyboardType:TextInputType.number ,
                              //    autovalidateMode:AutovalidateMode.onUserInteraction,
                              //    validator: ValidationforTextformField().validateMobileNumber,
                              //   controller: mobileNumbercontroller,
                              //
                              //   decoration: InputDecoration(
                              //       prefix: const Padding(
                              //       padding: EdgeInsets.symmetric(horizontal: 16),
                              //       child: Text("+ 91"),
                              //       //  readOnly: true,
                              //     ),
                              //
                              //     border: const OutlineInputBorder(
                              //
                              //     ),
                              //     // labelText: 'User Name',
                              //     hintText: 'Enter Mobile Number',
                              //     hintStyle: GoogleFonts.commissioner(),
                              //   ),
                              // ),
                            )),

                        const SizedBox(height: 5),

                        ElevatedButton(
                          onPressed: () {
                            if (_formKey1.currentState!.validate()) {
                              //   print('Full Phone Number: $fullPhone');
                              insertrecord();
                              // setState(() {
                              //  namecontroller.text="";
                              //  emailcontroller.text="";
                              //  mobileNumbercontroller.text="";
                              // });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: purple,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Adjust this as needed
                          children: <Widget>[
                            const Text(
                              'Already have an account ?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(157, 118, 193, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
