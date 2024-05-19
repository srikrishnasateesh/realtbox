class ValidationUtils {
  bool validateMobile(String value) {
    String pattern = r'(^[6-9]\d{9}$)';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool isValidOtp(String otp) {
    return otp.length == 6;
  }

  bool isValidUserName(String name) {
    return name.isNotEmpty && name.length > 1;
  }
}
