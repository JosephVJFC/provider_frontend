import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_frontend/model/user_detailprovider.dart';
import 'package:provider/provider.dart';
import 'package:provider_frontend/pages/postdetailpage.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../model/home_model.dart';
import '../model/user_detail_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../service/home_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static String route = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //loading category data

  List<Category> datalist = [];
  bool _iscatogoryloading = false;
  Future<void> fetchData() async {
    setState(() {
      _iscatogoryloading = true;
    });
    final apiCall = GetCategory();

    final allCategory = await apiCall.getcategory(
      context: context,
    );
    setState(() {
      datalist = allCategory;
    });
    setState(() {
      _iscatogoryloading = false;
    });
  }


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
    fetchData();
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
                          child: IconButton(
                            icon: const Icon(
                              Icons.person,
                              color: Color.fromRGBO(157, 118, 193, 1),
                            ),
                            iconSize: 30,
                            onPressed: () {
                              Navigator.pushNamed(context, '/profile');
                            },
                          )),
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
                        'People/Worker',
                        style: GoogleFonts.commissioner(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        ' Required for',
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

                  const SizedBox(height: 55),

                  Expanded(
                      child: Skeletonizer(
                        enabled: _iscatogoryloading,
                        child: Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: 3 / 3,
                              ),
                            shrinkWrap: true,
                          itemCount: datalist.length,
                          itemBuilder: (context, index) {
                          final jobpostData = datalist[index];
                          final cateiconImage = jobpostData.cateiconImage;
                          final categoryName = jobpostData.categoryName;
                          final categoryId = jobpostData.categoryId;
                                return Card(
                                  // padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(157, 118, 193, 1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),

                                    padding: EdgeInsets.only(top: 30.0),

                                      child: InkWell(
                                          onTap: (){
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(builder: (context) => Postdetailpage(id:categoryId ,name: categoryName,)));
                                          },
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  cateiconImage,
                                                  width:40 , // Set the width of the SVG
                                                  height: 40, // Set the height of the SVG
                                                ),

                                            Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                             child: Text(

                                                categoryName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.commissioner(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            )
                                              ],
                                            ),
                                        ),
                                  ),
                                );
                              },
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
                bottomNavigationBar: CurvedNavigationBar(
                color: const Color.fromRGBO(157, 118, 193, 1),
                height: 48,
                backgroundColor: Colors.white,
                items: const [

                  Text('More'),
                  // Icon(
                  //   Icons.add,
                  // ),
                ]),
          )));
    });
  }
}
