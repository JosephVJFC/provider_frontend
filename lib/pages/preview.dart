import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider_frontend/pages/job.dart';

class Preview extends StatefulWidget {
  final String jobTitle;
  final String jobType;
  final String number;
  final String address;
  final String location;
  final String description;
  const Preview(
      {Key? key,
      required this.jobTitle,
      required this.jobType,
      required this.number,
      required this.address,
      required this.location,
      required this.description})
      : super(key: key);

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  Widget buildInfoRow(String label, String value,
      {Color labelColor = Colors.black}) {
    if (label == 'Description') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30), // Gap between rows
          Text(
            label,
            style: GoogleFonts.commissioner(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: labelColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: GoogleFonts.commissioner(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30), // Gap between rows
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150,
              child: Text(
                label,
                style: GoogleFonts.commissioner(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: labelColor,
                ),
              ),
            ),
            Text(
              ': ',
              style: GoogleFonts.commissioner(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: labelColor,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  value,
                  style: GoogleFonts.commissioner(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 38.0),
            child: Text(
              label,
              style: GoogleFonts.commissioner(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: label.contains('Total Amount')
                    ? const Color.fromRGBO(157, 118, 193, 1)
                    : Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(width: 110.0),
        Expanded(
          flex: 1,
          child: Text(
            value,
            style: GoogleFonts.commissioner(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: label.contains('Total Amount')
                  ? const Color.fromRGBO(157, 118, 193, 1)
                  : Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(157, 118, 193, 1),
        title: const Center(
          child: Text(
            "Job Preview",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 18,
              fontFamily: 'Commissioner',
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 16), // Adjust height as needed
                Container(
                  height: 802,
                  width: 360,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(
                          157, 118, 193, 1), // Border color
                      width: 1, // Border width
                    ),
                    color: const Color.fromRGBO(251, 251, 251, 1),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 545,
                    width: 315,
                    child: Column(
                      children: [
                        buildInfoRow('ID', '#JP0001',
                            labelColor: const Color.fromRGBO(157, 118, 193, 1)),
                        buildInfoRow('Job title', widget.jobTitle,
                            labelColor: const Color.fromRGBO(157, 118, 193, 1)),
                        buildInfoRow('Job type', widget.jobType,
                            labelColor: const Color.fromRGBO(157, 118, 193, 1)),
                        buildInfoRow('Contact Number', widget.number,
                            labelColor: const Color.fromRGBO(157, 118, 193, 1)),
                        buildInfoRow('Address', widget.address,
                            labelColor: const Color.fromRGBO(157, 118, 193, 1)),
                        buildInfoRow('Location', widget.location,
                            labelColor: const Color.fromRGBO(157, 118, 193, 1)),
                        buildInfoRow(
                          'Description', widget.description,
                          // 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make atype specimen book. It has survived not only five centuries, but also the leap.',
                          labelColor: const Color.fromRGBO(157, 118, 193, 1),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 308,
                              height: 156,
                              child: Column(
                                children: [
                                  Container(
                                    height: 35,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(157, 118, 193, 0.6),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                      ),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        'Amount Details',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 29,
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        child: buildRow("Cost", "₹600"),
                                      ),
                                      Container(
                                        height: 29,
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        child: buildRow("GST", "₹21.42"),
                                      ),
                                      Container(
                                        height: 29,
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        child:
                                            buildRow("Platform Fee", "₹30.00"),
                                      ),
                                      Container(
                                        height: 29,
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        child:
                                            buildRow("Total Amount", "₹651.42"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                              vertical: 12.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor:
                                const Color.fromRGBO(157, 118, 193, 1),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Completed(),
                              ),
                            );
                          },
                          child: Text(
                            'Review & Submit',
                            style: GoogleFonts.commissioner(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
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
