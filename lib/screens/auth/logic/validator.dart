class Validator {
  static String? validateFirstName({required String value}) {
    if (value.isEmpty) {
      return 'First name cannot be empty';
    } else if (value.length < 3) {
      return 'At least 3 letters required';
    }
    return null;
  }

  static bool isFirstNameValid(String firstName) {
    if (firstName.isEmpty) {
      return false;
    }
    if (firstName.length < 3) {
      return false;
    }
    return true;
  }

  static String? validateOtherName({required String value}) {
    if (value.isEmpty) {
      return 'Other name cannot be empty';
    } else if (value.length < 3) {
      return 'At least 3 letters required';
    }
    return null;
  }

  static bool isOtherNameValid(String otherName) {
    if (otherName.isEmpty) {
      return false;
    }
    if (otherName.length < 3) {
      return false;
    }
    return true;
  }

  static String? validateEmail({required String value}) {
    if (value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!value.contains('@') || !value.contains('.')) {
      return 'Invalid email format';
    }
    return null;
  }

  static bool isEmailValid(String email) {
    if (email.isEmpty) {
      return false;
    }
    if (!email.contains('@') || !email.contains('.')) {
      return false;
    }
    return true;
  }

  static String? validatePassword({required String value}) {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (!containsSpecialCharacter(value: value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static bool isPasswordValid(String password) {
    if (password.isEmpty) {
      return false;
    }
    if (password.length < 8) {
      return false;
    }
    if (!containsSpecialCharacter(value: password)) {
      return false;
    }
    return true;
  }

  static String? validatePhoneNumber({required String value}) {
    if (value.isEmpty) {
      return 'Phone number cannot be empty';
    } else if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
      // Adjust the regular expression according to your phone number format
      return 'Invalid phone number format';
    }

    return null;
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return false;
    }
    return RegExp(r'^[0-9]{11}$').hasMatch(phoneNumber);
  }

  static String? validateBio({required String value}) {
    if (value.isEmpty) {
      return 'Bio cannot be empty';
    } else if (value.length > 150) {
      return 'Bio must be 150 characters or less';
    }

    return null;
  }

  static String? validateConfirmPassword(
      {required String? password, required String? confirmPassword}) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password cannot be empty';
    } else if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static bool isConfirmPasswordValid(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return false;
    }
    if (password != confirmPassword) {
      return false;
    }
    return true;
  }

  static bool containsSpecialCharacter({required String value}) {
    // Customize this method to define what you consider as special characters
    final specialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return specialCharacters.hasMatch(value);
  }
}
