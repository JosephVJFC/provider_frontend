import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
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
    required  XFile ? jobImage,
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
    String fileName = jobImage!.path.split('/').last;
    print(fileName);

    FormData formData = FormData.fromMap({
      'postedBy':postedBy,
      'jobType':jobType,
      'jobTitle':jobTitle,
      'jobDescription':jobDescription,
      'jobAddress':jobAddress,
      'jobImage':await MultipartFile.fromFile(jobImage.path,),
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

        // showCustomSnackBar(
        //   context: context,
        //   text: message.toString(),
        // );

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

class ApiService {
  Future<List<String>> fetchdistrictnames() async {
    final String apiUrl = '$JbaseUrl/api/alldistrict';
    print(apiUrl);
List<String>districtList =[];
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        apiUrl,
      );
      if (response.statusCode == 200) {
        if (response.data['status'] == "1") {


          var data = response.data['response']['locationdata'];
          // log(response.body);
          for ( var itemlist in data) {
            String districtName = itemlist['districtName'];
            districtList.add(districtName);
          }
          return districtList;



        }else {
          throw Exception('NoData available');
      }
      } else {
        throw Exception(
            'Failed to load data from the API. Status Code: ${response
                .statusCode}');
      }
    } catch (e) {
      log('Error fetching data: $e');
      throw Exception('An error occurred while fetching data from the API.');
    }
  }
}