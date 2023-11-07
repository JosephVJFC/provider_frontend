import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:mpm_frontend/constants/bnavigation.dart';
import 'package:provider_frontend/model/user_detailprovider.dart';
import 'package:provider/provider.dart';
import '../model/user_detail_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Provider_Home extends StatefulWidget {
  const Provider_Home({super.key});

  @override
  State<Provider_Home> createState() => _Provider_HomeState();
}

class _Provider_HomeState extends State<Provider_Home> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // <-- SEE HERE
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
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

  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<UserDetailsProvider>(builder: (context, value, child) {
      User userdetails = value.userdetail;
      return WillPopScope(
          onWillPop: _onWillPop,
          child: SafeArea(
              child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text//

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greeting(),
                            style: GoogleFonts.commissioner(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          Text(userdetails.name,
                              style: GoogleFonts.commissioner(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              )),
                        ],
                      ),

                      // Notification//
                      Container(
                        decoration: BoxDecoration(
                            // color: Colors.red,
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 196, 195, 195)),
                            borderRadius: BorderRadius.circular(50)),
                        padding: EdgeInsets.all(12),
                        child: const Icon(
                          Icons.person,
                          color: Color.fromRGBO(157, 118, 193, 1),
                          size: 26,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Search box //
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color.fromARGB(255, 196, 195, 195),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 196, 195, 195),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Search a Jobs',
                            style: GoogleFonts.commissioner(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 196, 195, 195),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // End of search box//

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'What are you',
                        style: GoogleFonts.commissioner(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        ' offering',
                        style: GoogleFonts.commissioner(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(157, 118, 193, 1),
                        ),
                      ),
                      Text(
                        '?',
                        style: GoogleFonts.commissioner(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // for (var i = 1; i < 4; i++)
                          // SizedBox(height: 1),
                          Column(
                            children: [
                              // Row 1//
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                  child:Image.asset("assets/images/provider/gardening_6878388 2.png",
                                  height: 10,
                                  ),
                                    width: 80,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      // borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              157, 118, 193, 0.3),
                                          blurRadius: 0.2,
                                          offset:
                                              Offset(1, 2), // Shadow position
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                   child:Image.asset("assets/images/provider/healthcare_3825386 (1) 2.png",),
                                    width: 80,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      // borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              157, 118, 193, 0.3),
                                          blurRadius: 0.2,
                                          offset:
                                              Offset(1, 2), // Shadow position
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              // End Row 1//

                              const SizedBox(
                                height: 20,
                              ),

                              // Row 2 //
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child:Image.asset("assets/images/provider/cooking_2975608 2.png",),
                                    width: 80,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      // borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              157, 118, 193, 0.3),
                                          blurRadius: 0.2,
                                          offset:
                                              Offset(1, 2), // Shadow position
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child:Image.asset("assets/images/provider/steering-wheel_7648986 2.png",),
                                    width: 80,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      // borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              157, 118, 193, 0.3),
                                          blurRadius: 0.2,
                                          offset:
                                              Offset(1, 2), // Shadow position
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              // End Row 2//
                              const SizedBox(
                                height: 20,
                              ),

                              // Row 3 //
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                   child:Image.asset("assets/images/provider/bag_2430422 2.png",),
                                    width: 80,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      // borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              157, 118, 193, 0.3),
                                          blurRadius: 0.2,
                                          offset:
                                              Offset(1, 2), // Shadow position
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child:Image.asset("assets/images/provider/broom_716996 2.png",),
                                    width: 80,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      // borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              157, 118, 193, 0.3),
                                          blurRadius: 0.2,
                                          offset:
                                              Offset(1, 2), // Shadow position
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              // End Row 3//
                              const SizedBox(
                                height: 20,
                              ),

                              // Row 4 //
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child:Image.asset("assets/images/provider/man_7755397 2.png",),
                                    width: 80,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      // borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              157, 118, 193, 0.3),
                                          blurRadius: 0.2,
                                          offset:
                                              Offset(1, 2), // Shadow position
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                   child: Image.asset("assets/images/provider/Group 37067.png",),
                                    width: 80,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      // borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              157, 118, 193, 0.3),
                                          blurRadius: 0.2,
                                          offset:
                                              Offset(1, 2), // Shadow position
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // End Row 4//
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(height: 10,),
                ],
              ),
            ),
            bottomNavigationBar: CurvedNavigationBar(
                color: Color.fromRGBO(157, 118, 193, 1),
                height: 48,
                backgroundColor: Colors.white,
                items: const [
                  Icon(Icons.add,),
                ]),
          )));
    });
  }
}
