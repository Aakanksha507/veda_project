class InputValidation {
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone Number is Required";
    }
    // if (!RegExp(r"^\d+$").hasMatch(value.trim())){
    //   return "Only Numerica Value are Allowded";
    // }
    if (value.length < 10) {
      return "Phone number must be at least 10 digits";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is Required";
    }
    if (value.length < 6) {
      return " Password must be at least 6";
    }
    return null;
  }

  static String? validateUserName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "UserName is Required";
    }
    if (value.length < 3) {
      return "Username must be at least 3";
    }
    return null;
  }

  static String? validateBankName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "BankName is Required";
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value.trim())) {
      return "Only alphabetic characters are allowed";
    }
    return null;
  }

  static String? validateBranchName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "BranchName is Required";
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value.trim())) {
      return "Only alphabetic characters are allowed";
    }
    return null;
  }

  static String? validateTransactionName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Branch Name is Required";
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value.trim())) {
      return "Only alphabetic characters are allowed";
    }
    return null;
  }

  static String? validateCardNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "CardNumber is Required";
    }
    return null;
  }
}
