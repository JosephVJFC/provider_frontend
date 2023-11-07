import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:provider_frontend/constants/validation.dart';
// import 'package:mpm_frontend/pages/js_register.dart';
import 'package:provider_frontend/pages/jp_register.dart';
// import 'package:provider_frontend/pages/otp_verification.dart';

import '../service/signup_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key});
  static String route = '/jsuser/signin';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mobileNumbercontroller = TextEditingController();
  Jssignin signin = Jssignin();

  jssignin() async {
    signin.jssignin(
      mobileNumber: mobileNumbercontroller.text,
      context: context,
    );
  }

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    mobileNumbercontroller.dispose();
  }

  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    //  var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: Builder(builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey1,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      SvgPicture.asset(
                        'lib/assets/images/signin.svg',
                        // Replace with the path to your SVG file
                        width: 230, // Set the width of the SVG
                        height: 230, // Set the height of the SVG
                      ),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Lets',
                            style: GoogleFonts.commissioner(
                                fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ' Sign',
                            style: GoogleFonts.commissioner(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(157, 118, 193, 1),
                            ),
                          ),
                          Text(
                            ' You in',
                            style: GoogleFonts.commissioner(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome Back ,',
                            style: GoogleFonts.commissioner(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'you have been misssed',
                            style: GoogleFonts.commissioner(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),

                                child: IntlPhoneField(
                                  controller: mobileNumbercontroller,
                                  keyboardType: TextInputType.number,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,

                                  // decoration: InputDecoration(
                                  //   labelText: 'Phone Number',
                                  //   // border: OutlineInputBorder(
                                  //   //   borderSide: BorderSide(),
                                  //   // ),
                                  // ),

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

                                // child: TextFormField(
                                //   controller: mobileNumbercontroller,
                                //   keyboardType: TextInputType.number,
                                //   autovalidateMode:
                                //   AutovalidateMode.onUserInteraction,
                                //   validator: ValidationforTextformField()
                                //       .validateMobileNumber,
                                //   // controller: nameController,
                                //   decoration: InputDecoration(
                                //     prefix: const Padding(
                                //       padding: EdgeInsets.symmetric(
                                //           horizontal: 16),
                                //       child: Text("+ 91"),
                                //     ),
                                //     border: const OutlineInputBorder(),
                                //     // labelText: 'User Name',
                                //     hintText: 'Enter Your Mobile',
                                //     hintStyle: GoogleFonts.commissioner(),
                                //   ),
                                // ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    jssignin();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(157, 118, 193, 1),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 100, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Get OTP',
                                    style: GoogleFonts.commissioner(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white
                                        // fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Adjust this as needed
                                children: <Widget>[
                                  Text(
                                    'Don’t have an account ?',
                                    style: GoogleFonts.commissioner(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const JpRegister(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: GoogleFonts.commissioner(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: const Color.fromRGBO(
                                            157, 118, 193, 1),
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class JsRegister {
  const JsRegister();
}
