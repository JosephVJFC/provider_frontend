// ignore_for_file: unused_local_variable, equal_elements_in_set

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:mpmprovider/preview.dart';
import 'package:intl/intl.dart';
import 'package:provider_frontend/pages/preview.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../model/home_model.dart';
import '../service/home_service.dart';

class Postdetailpage extends StatefulWidget {
  final String? id;
  final String? name;
  const Postdetailpage({Key? key, this.name, this.id}) : super(key: key);

  @override
  State<Postdetailpage> createState() => _PostdetailpageState();
}

class _PostdetailpageState extends State<Postdetailpage> {
  TextEditingController jobtitlecontroller = TextEditingController();
  TextEditingController jobdescontroller = TextEditingController();
  TextEditingController hourscontroller = TextEditingController();
  TextEditingController dayscontroller = TextEditingController();
  TextEditingController jobcostcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  final TextEditingController fixedcontroller = TextEditingController();
  final TextEditingController bataControllers = TextEditingController();

  List<TextEditingController> additionalTextControllers = [];

  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _fromTimeController = TextEditingController();
  final TextEditingController _toTimeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;

  String selectedJobType = 'Hourly';
  String selectedLocation = 'Thiruvanmiyur';

  int maxCharacters = 400;

  File? _selectedImage;
/////////////////////PUSH
  @override
  void initState() {
    super.initState();
    jobdescontroller.addListener(_updateCharacterCount);
  }

  @override
  void dispose() {
    jobdescontroller.removeListener(_updateCharacterCount);
    jobdescontroller.dispose();
    super.dispose();
  }

  void _updateCharacterCount() {
    setState(() {});
  }
/////////////////////PUSH
  Future<void> _showFromTimePicker() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        String formattedTime = selectedTime.format(context);
        _fromTimeController.text = formattedTime;
      });
    }
  }

  Future<void> _showToTimePicker() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        String formattedTime = selectedTime.format(context);
        _toTimeController.text = formattedTime;
      });
    }
  }


///////////////////////PUSH
  Future<void> _selectFromDate() async {
    DateTime now = DateTime.now();
    DateTime firstDate = DateTime(now.year, now.month, now.day);
    DateTime lastDate =
        firstDate.add(const Duration(days: 30 * 3)); // Add 3 months

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
        _fromDateController.text = formattedDate;
      });
    }
  }

  Future<void> _selectToDate() async {
    DateTime now = DateTime.now();
    DateTime firstDate = DateTime(now.year, now.month, now.day);
    DateTime lastDate =
        firstDate.add(const Duration(days: 30 * 3)); // Add 3 months

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      if (_selectedDate == null ||
          picked.isAfter(_selectedDate!) ||
          picked.isAtSameMomentAs(_selectedDate!)) {
        setState(() {
          _selectedDate = picked;
          String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
          _toDateController.text = formattedDate;
        });
      } else {
        // Display a message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'The "to date" must be after or equal to the "from date".'),
          ),
        );
      }
    }
  }
/////////////////////////////////push
  PostJobdetails postjob = PostJobdetails();

  postjobrecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jpId = prefs.getString("jpId");

    postjob.postjob(
        postedBy: jpId,
        jobType: selectedJobType,
        jobTitle: jobtitlecontroller.text,
        jobDescription: jobdescontroller.text,
        jobAddress: addresscontroller.text,
        jobImage: _selectedImage,
        jobContact: phonecontroller.text,
        location: locationcontroller.text,
        jobFromtime: _fromTimeController.text,
        jobTotime: _toTimeController.text,
        jobFromdate: _fromDateController.text,
        jobTodate: _toDateController.text,
        jobcateId: widget.id,
        jobBata: bataControllers.text,
        jobCost: jobcostcontroller.text,
        jobFixedcost: fixedcontroller.text,
        jobworkingHours: hourscontroller.text,
        jobworkingDays: dayscontroller.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dispose additional controllers
    // for (var controller in additionalTextControllers) {
    //   controller.dispose();
    // }

    // Dynamically generate text fields based on selectedJobType
    List<Widget> additionalTextFields = [];

    if (selectedJobType == 'Fixed Cost' ||
        selectedJobType == 'Fixed Cost + Bata') {
      additionalTextFields.add(
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          keyboardType: TextInputType.number,
          controller: fixedcontroller,
          decoration: InputDecoration(
            hintText: 'Enter Amount',
            hintStyle: GoogleFonts.commissioner(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(217, 217, 217, 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
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
          Column(
            children: [
              const SizedBox(height: 25),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                // controller: additionalTextControllers.length <= 1
                //     ? bataControllers
                //     : additionalTextControllers[1],
                controller: bataControllers,
                decoration: InputDecoration(
                  hintText: 'Enter Batta Amount',
                  hintStyle: GoogleFonts.commissioner(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(217, 217, 217, 1),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0,
                  ),
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
            ],
          ),
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 10),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        controller: jobtitlecontroller,
                        decoration: InputDecoration(
                          hintText: 'Job title*',
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
                      /////////////////////PUSH
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        controller: jobdescontroller,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${jobdescontroller.text.length}/$maxCharacters',
                            style: GoogleFonts.commissioner(
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              color:
                                  jobdescontroller.text.length > maxCharacters
                                      ? Colors.red
                                      : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      /////////////////////PUSH
                      const SizedBox(height: 18),
                      TextFormField(
                        readOnly: true,
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
                      if (selectedJobType == 'Hourly' ||
                          selectedJobType == 'Days') ...{
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                          controller: selectedJobType == 'Hourly'
                              ? hourscontroller
                              : dayscontroller,
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
                              selectedJobType == 'Hourly'
                                  ? 'eg.1hr'
                                  : 'eg.1 day',
                              style: GoogleFonts.commissioner(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(157, 118, 193, 1),
                              ),
                            ),
                          ],
                        ),
                      },

                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                              readOnly: true,
                              controller: _fromDateController,
                              decoration: InputDecoration(
                                hintText: 'From Date',
                                hintStyle: GoogleFonts.commissioner(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(217, 217, 217, 1),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                // filled: true,
                                // fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(157, 118, 193, 1),
                                    width: 2.5,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(157, 118, 193, 1),
                                    width: 2,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    size: 18,
                                  ),
                                  color: Colors.black,
                                  onPressed: _selectFromDate,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                              readOnly: true,
                              controller: _toDateController,
                              decoration: InputDecoration(
                                hintText: 'To Date',
                                hintStyle: GoogleFonts.commissioner(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(217, 217, 217, 1),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                // filled: true,
                                // fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(157, 118, 193, 1),
                                    width: 2.5,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(157, 118, 193, 1),
                                    width: 2,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    size: 18,
                                  ),
                                  color: Colors.black,
                                  onPressed: _selectToDate,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                              readOnly: true,
                              controller: _fromTimeController,
                              decoration: InputDecoration(
                                hintText: 'From Time',
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(217, 217, 217, 1),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 10.0,
                                ),
                                // filled: true,
                                // fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(157, 118, 193, 1),
                                    width: 2.5,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(157, 118, 193, 1),
                                    width: 2,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.timer,
                                    size: 18,
                                  ),
                                  color: Colors.black,
                                  onPressed: _showFromTimePicker,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                              readOnly: true,
                              controller: _toTimeController,
                              decoration: InputDecoration(
                                hintText: 'To Time',
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(217, 217, 217, 1),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 10.0,
                                ),
                                // filled: true,
                                // fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(157, 118, 193, 1),
                                    width: 2.5,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(157, 118, 193, 1),
                                    width: 2,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.lock_clock_rounded,
                                    size: 20,
                                  ),
                                  color: Colors.black,
                                  onPressed: _showToTimePicker,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      ///////////////////////////////////////

                      if (selectedJobType != 'Fixed Cost' &&
                          selectedJobType != 'Fixed Cost + Bata') ...{
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
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
                        const SizedBox(
                          height: 25,
                        ),
                      },

                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[0-9]{0,10}$')),
                        ],
                        controller: phonecontroller,
                        decoration: InputDecoration(
                          hintText: 'Contact number',
                          hintStyle: GoogleFonts.commissioner(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(217, 217, 217, 1),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 10.0,
                          ),
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

                      const SizedBox(height: 25),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        controller: addresscontroller,
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
                        readOnly: true,
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
                          suffixIcon: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedLocation,
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
                                    selectedLocation = newValue;
                                  });
                                }
                              },
                              items: <String>[
                                'Thiruvanmiyur',
                                'Velachery',
                                'Guindy',
                                'Pallikarani',
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
                    ],
                  ),
                ),
                const SizedBox(height: 60),

                // ///////////////////////////////////////////////////////////////////////////

                Column(
                  children: [
                    DottedBorder(
                      color: const Color.fromRGBO(157, 118, 193, 1),
                      strokeWidth: 1,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [10, 10],
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _showImagePickerOption();
                            },
                            child: SizedBox(
                              width: 340,
                              height: 160,
                              child: _selectedImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        _selectedImage!,
                                        width: 80, // Adjust the width as needed
                                        height:
                                            70, // Adjust the height as needed
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.image_outlined,
                                          color:
                                              Color.fromRGBO(157, 118, 193, 1),
                                          size: 35,
                                        ),
                                        Text(
                                          'Upload photos',
                                          style: GoogleFonts.commissioner(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            color: const Color.fromRGBO(
                                                157, 118, 193, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: _selectedImage != null
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedImage = null;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ],
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Preview(
                                jobTitle: jobtitlecontroller.text,
                                jobType: selectedJobType,
                                number: phonecontroller.text,
                                address: addresscontroller.text,
                                location: locationcontroller.text,
                                description: jobdescontroller.text,
                              ),
                            ),
                          );
                        }
                      },
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
      ),
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(157, 118, 193, 1),
        height: 50,
      ),
    );
  }

  Future<void> _showImagePickerOption() async {
    await showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 40,
                            color: Color.fromRGBO(157, 118, 193, 1),
                          ),
                          Text("Gallery")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImage(ImageSource.camera);
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: Color.fromRGBO(157, 118, 193, 1),
                          ),
                          Text("Camera")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
