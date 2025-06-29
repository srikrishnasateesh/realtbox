class ApiConstants {
  static const String baseUrl = baseUrlDev; //"https://api.propertybox.co.in/"; //"https://api.realtbox.in/";
  static const String baseUrlDev = "https://api.dev.propertybox.co.in/";//"https://api.dev.realtbox.in/";
  static const String baseUrlQA = "https://api.qa.propertybox.co.in/";//"https://api.qa.realtbox.in/";
  static const String versionCheck = "v1/management/mobile-app-version-check";
  static const String requestOtp = "v1/oauth/generate-login-otp";
  static const String requestToken = "v1/oauth/token-using-otp";
  static const String refreshToken = "v1/oauth/refresh-token";
  static const String self = "v1/oauth/self";
  static const String property = "v1/property";
  static const String propertyLastViewd = "v1/property/lastviewed";
  static const String propertyDetails = "v1/property";
  static const String enquiry = "v1/property-Enq/enquiry";
  static const String enquiryList = "v1/property-enq";
  static const String userEnquiryList = "v1/property-Enq/enquiry-list/list";
  static const String categoryList = "v1/category/list";
  static const String amenityList = "v1/amenity";
  static const String deleteAccount = "v1/oauth/delete";
  static const String birdView = "v1/property/birdview";
  static const String favProperty = "v1/property/favproperty";
}
