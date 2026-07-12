class Urls {
  //static const String _baseUrl = "https://test3.fireai.agency";
  // static const String _baseUrl = "http://23.26.207.33";
  static const String _baseUrl = "https://apps.biblejourney.pro";
  // static const String _baseUrl = "http://10.0.2.2:8000";
  // static const String baseUrl = "https://test3.fireai.agency";
  // static const String baseUrl = "http://23.26.207.33";
  static const String baseUrl = "https://apps.biblejourney.pro";
  //static const String baseUrl = "http://10.0.2.2:8000";
  static const String signUpUrl = '${_baseUrl}/api/auth/signup/';
  static const String signInUrl = '${_baseUrl}/api/auth/login/';
  static const String logOutUrl = '${_baseUrl}/api/auth/logout/';
  static const String changePasswordUrl = '${_baseUrl}/api/change/password/';
  static const String disableAccountUrl = '${_baseUrl}/api/account/disable/';
  static const String forgotPasswordUrl = '${_baseUrl}/api/forgot/password/';
  static const String otpVerifyUrl = '${_baseUrl}/api/auth/otp/verify/';
  static const String resetPasswordUrl = '${_baseUrl}/api/reset/password/';
  static const String categoryQuestionUrl = '${_baseUrl}/api/user/categorize/';
  static const String profileUrl = '${_baseUrl}/api/profile/';
  static const String editProfileUrl = '${_baseUrl}/api/profile/';
  static const String journeyCardUrl = '${_baseUrl}/journey/all_journy/';
  //static const String dailyJourneyDetailsUrl = '${_baseUrl}/progress/current-journey/days/';
  static String dailyJourneyDetailsUrl(journeyId) => "${_baseUrl}/progress/journey/$journeyId";
  static const String dailyJourneyUrl = '${_baseUrl}/progress/today/';
  static String journeyContentUrl(journeyId,dayId) => '${_baseUrl}/progress/steps/$journeyId/$dayId';
  static const String dailyPrayerUrl = '${_baseUrl}/progress/today/prayer';
  static const String stepCompletedUrl = '${_baseUrl}/progress/stepcopmplete/';
  //     static const String subscriptionUrl = '${_baseUrl}/api/pay/';
  static const String deleteAccountUrl = '${_baseUrl}/api/account/delete/';

}