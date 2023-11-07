class ValidationforTextformField {
//  to validate email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    // Check if the "@" symbol is present in the email
    if (!value.contains('@')) {
      return 'Email address must contain "@" symbol';
    }

    // Use a regular expression to validate the email format
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

// to validate mobilenumber
  String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      // return 'Please enter $hintext';
    }

    // Use a regular expression to validate the mobile number format
    if (!RegExp(r'^\d{10}$').hasMatch(value!)) {
      return 'Please enter a valid 10-digit mobile number';
    }

    return null;
  }


// to validate password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    //  password meets your criteria
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    //one uppercase letter
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    //  one lowercase letter
    if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    //  one digit (0-9)
    if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }

    //  one special character
    if (!RegExp(r'(?=.*[!@#$%^&*()_+{}[\]:;<>,.?~\\-])').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }



// to validate OTP
  String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter OTP';
    }

    // Check if the value contains only numbers
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'OTP must contain only numbers';
    }

    // Check if the OTP is exactly 6 digits long
    if (value.length != 6) {
      return 'OTP must be exactly 6 digits long';
    }

    return null;
  }

// validate confrm password

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }




// validate user name
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    if (value.length < 3) {
      return 'Username must be at least 3 characters long';
    }
   
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }

    // Check for unique username (you may need to query your database)
    // if (isUsernameTaken(value)) {
    //   return 'Username is already taken';
    // }




    return null;
  }


}



