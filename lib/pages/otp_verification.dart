import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

import 'package:pinput/pinput.dart';

import '../service/signup_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mpm_frontend/constants/utilities.dart';
import 'package:provider_frontend/constants/utilities.dart';

class OtpVerify extends StatefulWidget {
  // route to another page
  static String route = '/jsuser/otpverify';

  OtpVerify({Key? key});

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool _isPressed = false;

  OtpTimerButtonController purpleController = OtpTimerButtonController();


  Jsotpverify otpvfy = Jsotpverify();

  Jsresend otpresend = Jsresend();

  String? mobileNumber;
  String? email;
  String? name;


  void _buttonDisable(){
    setState(() {
      _isPressed = true;
    });
  }


  void getNumber() async {
    setState(() {
      _isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobileNumber = prefs.getString("mobileNumber");
    name = prefs.getString("name");
    email = prefs.getString("email");

    setState(() {
      _isloading = false;
    });
  }

  insertotp() async {
    otpvfy.verifyotp(
      otp: pinController.text,
      mobileNumber: mobileNumber,
      context: context,
    );
  }

  resendotp() async {
    otpresend.resend(
      mobileNumber: mobileNumber,
      name: name,
      email: email,
      context: context,
    );
  }

  @override

  void initState() {
    super.initState();
    getNumber();
  }
  bool _isloading = false;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(157, 118, 193, 1);
    const fillColor = Color.fromRGBO(255, 255, 255, 1);
    const borderColor = Color.fromRGBO(157, 118, 193, 1);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(0, 0, 0, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
       
      ),
    );

    // final mediaQuery = MediaQuery.of(context);

    return Builder(builder: (context) {
      if (_isloading == true) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: Scaffold(
                body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 70),
                        SvgPicture.asset(
                          'assets/images/otp.svg', // Replace with the path to your SVG file
                          width: 200, // Set the width of the SVG
                          height: 200, // Set the height of the SVG
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Enter the verification',
                              style: GoogleFonts.commissioner(
                                  fontSize: 24, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              ' Code',
                              style: GoogleFonts.commissioner(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(157, 118, 193, 1),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Enter 6 digit code sent to you at',
                              style: GoogleFonts.commissioner(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("+91 $mobileNumber",
                                style: GoogleFonts.commissioner(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Directionality(
                              // Specify direction if desired
                              textDirection: TextDirection.ltr,
                              child: Pinput(
                                length: 6,
                                controller: pinController,
                                focusNode: focusNode,
                                androidSmsAutofillMethod:
                                    AndroidSmsAutofillMethod.smsUserConsentApi,
                                listenForMultipleSmsOnAndroid: true,
                                defaultPinTheme: defaultPinTheme,
                                separatorBuilder: (index) =>
                                    const SizedBox(width: 8),
                                validator: (value) {
                                  return value == null || value.isEmpty
                                      ? "Please enter OTP"
                                      : null;
                                },
                                // onClipboardFound: (value) {
                                //   debugPrint('onClipboardFound: $value');
                                //   pinController.setText(value);
                                // },
                                hapticFeedbackType: HapticFeedbackType.lightImpact,
                                onCompleted: (pin) {
                                  debugPrint('onCompleted: $pin');
                                },
                                onChanged: (value) {
                                  debugPrint('onChanged: $value');
                                },
                                cursor: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 9),
                                      width: 22,
                                      height: 1,
                                      color: focusedBorderColor,
                                    ),
                                  ],
                                ),
                                focusedPinTheme: defaultPinTheme.copyWith(
                                  decoration: defaultPinTheme.decoration!.copyWith(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: focusedBorderColor),
                                  ),
                                ),
                                submittedPinTheme: defaultPinTheme.copyWith(
                                  decoration: defaultPinTheme.decoration!.copyWith(
                                    color: fillColor,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: focusedBorderColor),
                                  ),
                                ),
                                errorPinTheme: defaultPinTheme.copyBorderWith(
                                  border: Border.all(color: Colors.redAccent),
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  _isPressed == false ? _buttonDisable():null;
                                  focusNode.unfocus();
                                  final validate = formKey.currentState!.validate();
                                  if (validate) {
                                    insertotp();
                                    // setState(() {
                                    //   pinController.text="";
                                    // });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(157, 118, 193, 1),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  'Sign in',
                                  style: GoogleFonts.commissioner(
                                    fontSize: 15,
                                     fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  // style: TextStyle(
                                  //   fontSize: 18,
                                  //   fontWeight: FontWeight.bold,
                                  //   color: Colors.white,
                                  // ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          //   OtpTimerButton(
                          // // controller: controller,
                          //     loadingIndicator: const CircularProgressIndicator(
                          //       strokeWidth: 2,
                          //       color: Colors.red,
                          //     ),
                          //     loadingIndicatorColor: Colors.red,
                          //     onPressed: () {
                          //       redController.loading();
                          //       Future.delayed(Duration(seconds: 2), () {
                          //         redController.startTimer();
                          //       });
                          //     },
                          //
                          //     text: Text('Resend ',
                          //         style: GoogleFonts.commissioner(
                          //           fontSize: 17,
                          //           fontWeight: FontWeight.bold,
                          //         )),
                          //     buttonType: ButtonType.text_button,
                          //     backgroundColor: Color.fromRGBO(157, 118, 193, 1),
                          //     duration:60,
                          //   ),
                            OtpTimerButton(
                              controller: purpleController,
                              onPressed: () {
                                resendotp();
                                showCustomSnackBar(
                                  context: context,
                                  text:('Otp has been sent successfully'),
                                );
                                purpleController.loading();
                                Future.delayed(Duration(seconds: 1), () {
                                  purpleController.startTimer();
                                });
                              },
                              text: Text('Resend ',
                                        style: GoogleFonts.commissioner(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    buttonType: ButtonType.text_button,
                                    backgroundColor: Color.fromRGBO(157, 118, 193, 1),
                                    duration:10,
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
        );

      }
    });
  }
}

// class PinputOTP extends StatefulWidget {
//   const PinputOTP({Key? key}) : super(key: key);
//
//   @override
//   State<PinputOTP> createState() => _PinputOTPState();
// }
//
// class _PinputOTPState extends State<PinputOTP> {
//   final pinController = TextEditingController();
//   final focusNode = FocusNode();
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   void dispose() {
//     pinController.dispose();
//     focusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
//     const fillColor = Color.fromRGBO(243, 246, 249, 0);
//     const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
//
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: const TextStyle(
//         fontSize: 22,
//         color: Color.fromRGBO(30, 60, 87, 1),
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(19),
//         border: Border.all(color: borderColor),
//       ),
//     );
//
//     /// Optionally you can use form to validate the Pinput
//     return Form(
//       key: formKey,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Directionality(
//             // Specify direction if desired
//             textDirection: TextDirection.ltr,
//             child: Pinput(
//
//               controller: pinController,
//               focusNode: focusNode,
//               androidSmsAutofillMethod:
//               AndroidSmsAutofillMethod.smsUserConsentApi,
//               listenForMultipleSmsOnAndroid: true,
//               defaultPinTheme: defaultPinTheme,
//               separatorBuilder: (index) => const SizedBox(width: 8),
//               validator: (value) {
//                 return value == '2222' ? null : 'Pin is incorrect';
//               },
//               // onClipboardFound: (value) {
//               //   debugPrint('onClipboardFound: $value');
//               //   pinController.setText(value);
//               // },
//               hapticFeedbackType: HapticFeedbackType.lightImpact,
//               onCompleted: (pin) {
//                 debugPrint('onCompleted: $pin');
//               },
//               onChanged: (value) {
//                 debugPrint('onChanged: $value');
//               },
//               cursor: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 9),
//                     width: 22,
//                     height: 1,
//                     color: focusedBorderColor,
//                   ),
//                 ],
//               ),
//               focusedPinTheme: defaultPinTheme.copyWith(
//                 decoration: defaultPinTheme.decoration!.copyWith(
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: focusedBorderColor),
//                 ),
//               ),
//               submittedPinTheme: defaultPinTheme.copyWith(
//                 decoration: defaultPinTheme.decoration!.copyWith(
//                   color: fillColor,
//                   borderRadius: BorderRadius.circular(19),
//                   border: Border.all(color: focusedBorderColor),
//                 ),
//               ),
//               errorPinTheme: defaultPinTheme.copyBorderWith(
//                 border: Border.all(color: Colors.redAccent),
//               ),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               focusNode.unfocus();
//               formKey.currentState!.validate();
//             },
//             child: const Text('Validate'),
//           ),
//         ],
//       ),
//     );
//   }
// }

