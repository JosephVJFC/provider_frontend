import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_frontend/pages/home.dart';

class Postdetailpage extends StatefulWidget {
  final  String? id;
  final  String? name;
  const Postdetailpage({Key? key, this.name, this.id}) : super(key: key);

  @override
  State<Postdetailpage> createState() => _PostdetailpageState();
}

class _PostdetailpageState extends State<Postdetailpage> {
  final TextEditingController _textController = TextEditingController();
  String selectedJobType = 'Hourly';

  int maxCharacters = 400; // Adjusted the character limit to 400

  // ignore: unused_field
  File? _selectedImage;
   File? _frontImage;

  // List to store controllers for dynamically generated text fields
  List<TextEditingController> additionalTextControllers = [];

  @override
  void initState() {
    super.initState();
    _textController.addListener(_updateCharacterCount);
  }

  @override
  void dispose() {
    _textController.removeListener(_updateCharacterCount);
    _textController.dispose();
    super.dispose();
  }




  // The setState triggers a rebuild when text changes
  void _updateCharacterCount() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final screenWidth = MediaQuery.of(context).size.width;

    // Dispose additional controllers
    for (var controller in additionalTextControllers) {
      controller.dispose();
    }

    // Dynamically generate text fields based on selectedJobType
    List<Widget> additionalTextFields = [];

    if (selectedJobType == 'Fixed Cost' ||
        selectedJobType == 'Fixed Cost + Bata') {
      additionalTextFields.add(
        TextFormField(
          controller: additionalTextControllers.isEmpty
              ? TextEditingController()
              : additionalTextControllers[0],
          decoration: InputDecoration(
            hintText: 'Enter Amount',
            hintStyle: GoogleFonts.commissioner(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(217, 217, 217, 1),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(157, 118, 193, 1),
                width: 2.5,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(157, 118, 193, 1),
                width: 2,
              ),
            ),
          ),
        ),
      );

      if (selectedJobType == 'Fixed Cost + Bata') {
        additionalTextFields.add(
          TextFormField(
            controller: additionalTextControllers.length <= 1
                ? TextEditingController()
                : additionalTextControllers[1],
            decoration: InputDecoration(
              hintText: 'Enter Batta Amount',
              hintStyle: GoogleFonts.commissioner(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(217, 217, 217, 1),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(157, 118, 193, 1),
                  width: 2.5,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(157, 118, 193, 1),
                  width: 2,
                ),
              ),
            ),
          ),
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                        Navigator.pop(context);
                    },
                    icon: const Icon(Icons.west_sharp, color: Colors.black),
                  ),
                  Text(
                    widget.name ?? "",
                    style: GoogleFonts.commissioner(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Job title',
                        hintStyle: GoogleFonts.commissioner(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(217, 217, 217, 1),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2.5),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: _textController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(maxCharacters),
                      ],
                      maxLines: null, // Allow multiple lines of text
                      decoration: InputDecoration(
                        hintText: 'Job Description*',
                        hintStyle: GoogleFonts.commissioner(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(217, 217, 217, 1),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2.5),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${_textController.text.length}/$maxCharacters',
                          style: GoogleFonts.commissioner(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: _textController.text.length > maxCharacters
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Job type',
                        hintStyle: GoogleFonts.commissioner(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(217, 217, 217, 1),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2.5),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2),
                        ),
                        suffixIcon: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedJobType,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Color.fromRGBO(157, 118, 193, 1),
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: GoogleFonts.commissioner(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedJobType = newValue;
                                });
                              }
                            },
                            items: <String>[
                              'Hourly',
                              'Days',
                              'Fixed Cost',
                              'Fixed Cost + Bata',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),

                    // Dynamic Text Fields
                    const SizedBox(height: 25),
                    ...additionalTextFields,

                    if (selectedJobType != 'Fixed Cost' &&
                        selectedJobType != 'Fixed Cost + Bata') ...{
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: selectedJobType == 'Hourly'
                              ? 'How Many Hours works'
                              : 'How Many Days works',
                          hintStyle: GoogleFonts.commissioner(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(217, 217, 217, 1),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2.5,
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            selectedJobType == 'Hourly' ? 'eg.1hr' : 'eg.1 day',
                            style: GoogleFonts.commissioner(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(157, 118, 193, 1),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Cost',
                          hintStyle: GoogleFonts.commissioner(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(217, 217, 217, 1),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2.5,
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    },

                    const SizedBox(height: 25),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Contact number',
                        hintStyle: GoogleFonts.commissioner(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(217, 217, 217, 1),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2.5),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Address',
                        hintStyle: GoogleFonts.commissioner(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(217, 217, 217, 1),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2.5),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Location',
                        hintStyle: GoogleFonts.commissioner(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(217, 217, 217, 1),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2.5),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(157, 118, 193, 1),
                              width: 2),
                        ),
                        suffixIcon: const Icon(
                          Icons.arrow_drop_down,
                          color: Color.fromRGBO(157, 118, 193, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Column(
                children: [
                  DottedBorder(
                  color: const Color.fromRGBO(157, 118, 193, 1),
                  strokeWidth: 1,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [10, 10],
                  child: SizedBox(
                    width: 330,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildImageUploadButton(Icons.image_outlined,
                            _frontImage, () => _pickFrontImage()),
                        // Text(
                        //   'Front Side',
                        //   style: GoogleFonts.commissioner(
                        //     fontWeight: FontWeight.w400,
                        //     fontSize: 10,
                        //     color: const Color.fromRGBO(157, 118, 193, 1),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10.0),
                        //   child: Text(
                        //     // 'Upload the front side of the document.\nSupport JPEG, PNG, and PDF',
                        //     textAlign: TextAlign.center,
                        //     style: GoogleFonts.commissioner(
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: 9,
                        //       color: const Color.fromRGBO(157, 118, 193, 1),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: const Color.fromRGBO(157, 118, 193, 1),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Upload',
                      style: GoogleFonts.commissioner(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
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
  }


Future<void> _pickFrontImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery,maxWidth: 400,maxHeight: 132);
        //  await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _frontImage = File(pickedImage.path);
      });
    }
  }

   Widget _buildImageUploadButton(
      IconData icon, File? image, VoidCallback onPressed) {
    return IconButton(
      icon: image != null ? Image.file(image) : Icon(icon),
      iconSize: 45,
      color: const Color.fromRGBO(157, 118, 193, 1),
      onPressed: onPressed,
    );
  }


  
  // Image Picker
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: source,
    );

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }
}

























  
