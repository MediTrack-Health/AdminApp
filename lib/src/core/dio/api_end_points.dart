class ApiEndPoints {
  static String baseUrl = 'http://middleware-meditrack-dev.us-east-1.elasticbeanstalk.com:8004/v1/apis/';
  static String bloodGroupAndGenderApi = 'master-data/profile';
  static String registerApiEndPoint = 'authenticate/register';
  static String verifyOtp = 'authenticate/verify-otp';
  static String sendOtp = 'authenticate/send-otp';
  static String reportTypes = 'master-data/report-types';
  static String getRecords = 'medical-records/get-record-by-profile/';
  static String getProfiles = 'profile/get-profiles';
  static String getUserProfile = 'profile/get-profiles-by-user';
  static String deleteProfile = 'profile/delete-profile';
  static String addProfile = 'profile/add-profile';
  static String updateProfile = 'profile/update-profile';
  static String addRecord = 'medical-records/add-record';
  static String getRecordById = 'medical-records/get-record-by-id/';
  static String getCategories = 'master-data/categories';
  static String hospitalSignup = 'authenticate/hospital/signup';
  static String hospitalLogin = 'authenticate/hospital/login';
}
