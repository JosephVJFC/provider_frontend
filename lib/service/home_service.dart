import 'dart:developer';

import 'package:dio/dio.dart';
import '../constants/globalvariable.dart';
import '../constants/headers.dart';
import '../constants/utilities.dart';
import '../model/home_model.dart';

class GetCategory
{
  Future<List<Category>> getcategory({
    required context,
  }) async {
    List<Category> dataList = [];
    // Define the URL of your API endpoint
    final String apiUrl = '$JbaseUrl/api/getallcategory';
    print(apiUrl);


    Dio dio = Dio();
    Response response = await dio.get(
      apiUrl,
      options: Options(
        headers:JsApplicationHeader,
      ),
      // You can add data or headers as needed
      // data: formData,
    );

    if (response.statusCode == 200) {
      log(":::::::::::::::::::::::::::::::::::::::::::::::::::${response.statusCode}");

      print(response.data);
      // Handle a successful response
      if (response.data['status'] == "1") {
        print('API response: ${response.data}');
        var message = response.data['response'];
        var categoryDetails = message['categories'];
        var totalcategories = message['totalcounts'];
        for (var itemData in categoryDetails) {
          // Process each item and add it to the dataList
          String categoryName = itemData['categoryName'].toString();
          String categoryImage = itemData['categoryImage'].toString();
          String catDisplayOrder = itemData['catdisplayOrder'].toString();
          String catStatus = itemData['catStatus'].toString();
          String categoryId = itemData['categoryId'].toString();
          String cateiconImage = itemData['cateiconImage'].toString();

          // Create a Category object and add it to the dataList
          dataList.add(
            Category(
                categoryName: categoryName,
                categoryImage: categoryImage,
                catdisplayOrder: catDisplayOrder,
                catStatus: catStatus,
                categoryId: categoryId,
                Totalcount:totalcategories,
                cateiconImage: cateiconImage
            ),

          );
        }
      } else {
        showCustomSnackBar(
          context: context,
          text: response.data['response'].toString(),
        );
      }
    } else {
      // Handle errors here
      print('API request failed with status code ${response.statusCode}');
    }
    return dataList;
  }
}


class PostJobdetails {
  Future<void>  postjob({
    required  postedBy,
    required String jobType,
    required String jobTitle,
    required String jobDescription,
    required String jobAddress,
    required  jobImage,
    required String jobContact,
    required String location,
    required String jobFromtime,
    required String jobTotime,
    required String jobFromdate,
    required String jobTodate,
    required  jobcateId,
    required String jobBata,
    required String jobCost,
    required String jobFixedcost,
    required String jobworkingHours,
    required String jobworkingDays,
    required context,
  }) async {

    // Define the URL of your API endpoint
    final String apiUrl = '$JbaseUrl/api/jp/jobpost';


    FormData formData = FormData.fromMap({
      'postedBy':postedBy,
      'jobType':jobType,
      'jobTitle':jobTitle,
      'jobDescription':jobDescription,
      'jobAddress':jobAddress,
      'jobImage':jobImage,
      'jobContact':jobContact,
      'location':location,
      'jobFromtime':jobFromtime,
      'jobTotime':jobTotime,
      'jobFromdate':jobFromdate,
      'jobTodate':jobTodate,
      'jobcateId':jobcateId,
      'jobBata':jobBata,
      'jobCost':jobCost,
      'jobFixedcost':jobFixedcost,
      'jobworkingHours':jobworkingHours,
      'jobworkingDays':jobworkingDays
    });

    print(postedBy);
    print(jobType);
    print(jobTitle);
    print(jobDescription);
    print(jobAddress);
    print(jobImage);
    print(jobContact);
    print(location);
    print(jobFromtime);
    print(jobTotime);
    print(jobFromdate);
    print(jobTodate);
    print(jobBata);
    print(jobCost);
    print(jobcateId);
    print(jobFixedcost);
    print(jobworkingHours);
    print(jobworkingDays);

    Dio dio = Dio();
    Response response = await dio.post(
      apiUrl,
      data: formData,
      options: Options(
        headers:JsApplicationHeader,
      ),
      // You can add data or headers as needed

    );

    if (response.statusCode == 200) {

      print(response.data);
      // Handle a successful response
      if (response.data['status'] == "1") {
        print('API response: ${response.data}');
        var message = response.data['response'];
        // var itemData = message['categories'];
        // for (var itemData in categoryDetails) {
          // Process each item and add it to the dataList
          // String postedBy = itemData['postedBy'].toString();
          // String jobTitle = itemData['jobTitle'].toString();
          // String jobType = itemData['jobType'].toString();
          // String jobDescription = itemData['jobDescription'].toString();
          // String jobAddress = itemData['jobAddress'].toString();
          // String jobImage = itemData['jobImage'].toString();
          // String jobContact = itemData['jobContact'].toString();
          // String location = itemData['location'].toString();
          // String jobFromtime = itemData['jobFromtime'].toString();
          // String jobTotime = itemData['jobTotime'].toString();
          // String jobFromdate = itemData['jobFromdate'].toString();
          // String jobTodate = itemData['jobTodate'].toString();
          // String jobcateId = itemData['jobcateId'].toString();
          // String jobBata = itemData['jobBata'].toString();
          // String jobCost = itemData['jobCost'].toString();
          // String jobworkingHours = itemData['jobworkingHours'].toString();
          // String jobworkingDays = itemData['jobworkingDays'].toString();

          // // Create a Category object and add it to the dataList
          // postdetails.add(
          //   PostJob(
          //       postedBy:postedBy,
          //       jobType:jobType,
          //       jobTitle:jobTitle,
          //       jobDescription:jobDescription,
          //       jobAddress:jobAddress,
          //       jobImage:jobImage,
          //       jobContact:jobContact,
          //       location:location,
          //       jobFromtime:jobFromtime,
          //       jobTotime:jobTotime,
          //       jobFromdate:jobFromdate,
          //       jobTodate:jobTodate,
          //       jobcateId:jobcateId,
          //       jobBata:jobBata,
          //       jobCost:jobCost,
          //       jobworkingHours:jobworkingHours,
          //       jobworkingDays:jobworkingDays
          //
          //   ),
          //
          // );
        // }
        showCustomSnackBar(
          context: context,
          text: message.toString(),
        );

      } else {
        showCustomSnackBar(
          context: context,
          text: response.data['response'].toString(),
        );
      }
    } else {
      // Handle errors here
      print('API request failed with status code ${response.statusCode}');
    }
    // return postdetails;
  }
}