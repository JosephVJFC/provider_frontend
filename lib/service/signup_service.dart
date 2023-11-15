import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider_frontend/constants/globalvariable.dart';
// import 'package:mpm_frontend/model/user_detailprovider.dart';
import 'package:provider_frontend/model/user_detailprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../constants/bnavigation.dart';
import 'package:provider_frontend/pages/home.dart';
// import '../constants/global_variables.dart';
import 'package:provider_frontend/constants/globalvariable.dart';
// import 'package:mpm_frontend/constants/utilities.dart';
import 'package:provider_frontend/constants/utilities.dart';
// import 'package:mpm_frontend/pages/otp_verification.dart';
import 'package:provider_frontend/pages/otp_verification.dart';
import '../constants/headers.dart';
import '../model/user_detail_model.dart';
import '../pages/getstarted.dart';

class Jssignup {
  Future<void> signup({
    required String name,
    required String email,
    required String mobileNumber,
    required context,
  }) async {
    // Define the URL of your API endpoint
    final String apiUrl = '$JbaseUrl/api/jp/signup';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // Create a FormData object
    FormData formData = FormData.fromMap({
      'email': email,
      'mobileNumber': mobileNumber,
      'name': name,
    });

    print(apiUrl );
    print( mobileNumber );
    Dio dio = Dio();
    Response response = await dio.post(
      apiUrl,
      data: formData,
      options: Options(
              headers:JsApplicationHeader,
            ),


    );
    if (response.statusCode == 200) {
      // Handle a successful response

      if (response.data['status'] == "1") {
        print('API response: ${response.data}');
        var message = response.data['response'];
        var message_two = message['user'];
        var mobileNumber = message_two['mobileNumber'];
        var email = message_two['email'];
        var name = message_two['userName'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("mobileNumber", "$mobileNumber");
        await prefs.setString("email", "$email");
        await prefs.setString("name", "$name");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerify(),
          ),
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
  }
}

class Jsotpverify {
  Future<void> verifyotp({
    required String otp,
    required String? mobileNumber,
    required context,
  }) async {
    // Define the URL of your API endpoint
    final String apiUrl = '$JbaseUrl/api/jp/otpverify';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobileNumber = prefs.getString("mobileNumber");

    // Create a FormData object

    print(mobileNumber);
    FormData formData = FormData.fromMap({
      'otp': otp,
      'mobileNumber': mobileNumber,
    });

    print(apiUrl);
    print( mobileNumber);

    Dio dio = Dio();
    Response response = await dio.post(
      apiUrl,
      data: formData,
      options: Options(
        headers:JsApplicationHeader,
      ),
    );

    if (response.statusCode == 200) {
      // Handle a successful response

      if (response.data['status'] == "1") {
        print('API response: ${response.data}');
        var message = response.data['response'];
        var message_two = message['user'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String user = message_two['jpId'];
        String Jptoken = message_two['token'];
        await prefs.setString("jpId", "$user");
        await prefs.setString("Jptoken", "$Jptoken");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home()
          ),
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
  }
}

class Jssignin {
  Future<void> jssignin({
    required String? mobileNumber,
    required context,
  }) async {
    // Define the URL of your API endpoint
    final String apiUrl = '$JbaseUrl/api/jp/signin';

    // Create a FormData object

    FormData formData = FormData.fromMap({
      'mobileNumber': mobileNumber,
    });

    print(apiUrl);

    Dio dio = Dio();
    Response response = await dio.post(
      apiUrl,
      data: formData,
      options: Options(
        headers:JsApplicationHeader,
      ),
    );

    if (response.statusCode == 200) {
      // Handle a successful response

      if (response.data['status'] == "1") {
        print('API response: ${response.data}');
        var message = response.data['response'];
        var message_two = message['user'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var user = message_two['userId'];
        var mobileNumber = message_two['mobileNumber'];
        await prefs.setString("jpId", "$user");
        await prefs.setString("mobileNumber", "$mobileNumber");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerify(),
          ),
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
  }
}

class Jsresend {
  Future<void> resend({
    required String? mobileNumber,
    required String? email,
    required String? name,
    required context,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobileNumber = prefs.getString("mobileNumber");
    email = prefs.getString("email");
    name = prefs.getString("name");

    if (mobileNumber != "" && email != "" && name != "") {
      FormData formData = FormData.fromMap({
        'mobileNumber': mobileNumber,
        'email': email,
        'name': name,
      });
      // Define the URL of your API endpoint
      final String apiUrl = '$JbaseUrl/api/jp/resendotp';
      print(apiUrl);
      Dio dio = Dio();
      Response response = await dio.post(
        apiUrl,
        data: formData,
        options: Options(
          headers:JsApplicationHeader,
        ),
      );

      if (response.statusCode == 200) {
        await prefs.remove("email");
        await prefs.remove("name");

        if (response.data['status'] == "1") {
          print('API response: ${response.data}');
          var message = response.data['response'];
          var message_two = message['user'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var user = message_two['userId'];
          await prefs.setString("userId", "$user");
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
    } else {
      FormData formData = FormData.fromMap({
        'mobileNumber': mobileNumber,
      });

      final String apiUrl = '$JbaseUrl/api/resendotp';
      print(apiUrl);

      Dio dio = Dio();
      Response response = await dio.post(
        apiUrl,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Handle a successful response
        if (response.data['status'] == "1") {
          print('API response: ${response.data}');
          var message = response.data['response'];
          var message_two = message['user'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var user = message_two['userId'];
          await prefs.setString("userId", "$user");
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
    }
  }
}

class Jslogout{


  Future<void> jslogout({

    required String ? jpId,
    required context,
  }) async {

    // Define the URL of your API endpoint
    final String apiUrl = '$JbaseUrl/api/jp/logout';
    // Create a FormData object
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? jpId = prefs.getString("jpId");
    FormData formData = FormData.fromMap({
      'jpId':jpId,
    });
    print(apiUrl);
    Dio dio = Dio();
    Response response = await dio.post(
      apiUrl,
      data: formData,
      options: Options(
        headers:JsApplicationHeader,
      ),
    );
    if (response.statusCode == 200  ) {
      // Handle a successful response
      if(response.data['status']== "1") {
        print('API response: ${response.data}');
        String message=response.data['response'];

        await prefs.clear();

        showCustomSnackBar(
          context: context,
          text:message.toString(),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GetStarted(),
          ),
        );

      }else{
        showCustomSnackBar(
          context: context,
          text:response.data['response'].toString(),
        );
      }
    } else {
      // Handle errors here
      print('API request failed with status code ${response.statusCode}');
    }
  }

}
