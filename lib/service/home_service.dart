import 'dart:developer';

import 'package:dio/dio.dart';
import '../constants/globalvariable.dart';
import '../constants/headers.dart';
import '../constants/utilities.dart';
import '../model/home_model.dart';

class GetCategory {
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
  Future<List<Category>> postjob({
    required context,
  }) async {
    List<Category> dataList = [];
    // Define the URL of your API endpoint
    final String apiUrl = '$JbaseUrl/api/jp/jobpost';

    Dio dio = Dio();
    Response response = await dio.post(
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