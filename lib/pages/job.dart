import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Completed extends StatefulWidget {
  const Completed({Key? key}) : super(key: key);

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  // Function to create a text span with specified properties
  TextSpan buildTextSpan(
      String text, double fontSize, FontWeight fontWeight, Color color) {
    return TextSpan(
      text: text,
      style: GoogleFonts.commissioner(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height:
                      screenHeight * 0.35, // Adjust the multiplier as needed
                  width: screenWidth * 0.70, // Adjust the multiplier as needed
                  child: SvgPicture.asset(
                    'lib/images/completed.svg',
                    semanticsLabel: 'My SVG Image',
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      buildTextSpan('Congratulations\n\n', 18, FontWeight.w700,
                          const Color.fromRGBO(157, 118, 193, 1)),
                      buildTextSpan('Your job request is ', 14, FontWeight.w600,
                          Colors.black),
                      buildTextSpan('Under review\n', 13, FontWeight.w600,
                          const Color.fromRGBO(157, 118, 193, 1)),
                      buildTextSpan(' It will go Live shortly..!', 13,
                          FontWeight.w600, Colors.black),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
