
class Signup {
  String email;
  String name;
  String mobileNumber;

  Signup({
    required this.email,
    required this.name,
    required this.mobileNumber,
    required context,


  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber
    };
  }

}

class OTPverify {

  String ? otp;
  String? mobileNumber;


  OTPverify({
    required this.otp,
    required this.mobileNumber,
    required context,


  });

  Map<String, dynamic> toMap() {
    return {
      'otp': otp,
      'mobileNumber': mobileNumber,

    };
  }

}

class Signin {
  String? mobileNumber;
  Signin({
    required this.mobileNumber,
    required context,
  });

  Map<String, dynamic> toMap() {
    return {
      'mobileNumber': mobileNumber,
    };
  }

}

class Resend {
  String email;
  String name;
  String mobileNumber;
  // String phoneNumber;

  Resend({
    required this.email,
    required this.name,
    required this.mobileNumber,
    // required this.phoneNumber,

    required context,


  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      // 'phoneNumber': phoneNumber

    };
  }




}

class Logout {
  String? jpId;

  Logout({
    required this.jpId,
    required context,
  });

  Map<String, dynamic> toMap() {
    return {
      'jpId': jpId,
    };
  }
}



