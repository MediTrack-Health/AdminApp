import 'package:meditrack_admin/src/core/utils/logger.dart';
import 'package:meditrack_admin/src/features/auth/presentation/model/login_model.dart';

import '../../../../core/dio/api_end_points.dart';
import '../../../../core/dio/api_services.dart';
import '../../../../core/dio/success_model.dart';

class LoginRepo {
  final ApiCall _apiCall = ApiCall();

  Future<SuccessModel> sendOtp(number) async {
    print('Naresh response ${ApiEndPoints.sendOtp} & mobile $number');

    var response = await _apiCall.postRequest('${ApiEndPoints.sendOtp}?mobile=$number',);
    print('Naresh response $response');

    if(response.statusCode==200){
      return SuccessModel.fromJson(response.data);
    } else{
      return throw Exception('Error');
    }
  }
  Future<LoginResponseModel> verifyOtp(data) async {
    logger.d("Naresh data $data ApiEndPoints ${ApiEndPoints.verifyOtp}");

    var response = await _apiCall.postRequest(ApiEndPoints.verifyOtp,data: data);
    logger.d("Naresh response $response");
    if(response.statusCode==200){
      return LoginResponseModel.fromJson(response.data);
    }else{
      return throw Exception('Error');
    }
  }
  // Future<LoginResponseModel> logIn(data) async {
  //   logger.d("Naresh data $data ApiEndPoints ${ApiEndPoints.hospitalLogin}");
  //
  //   try{;
  //     var response = await _apiCall.postRequest(ApiEndPoints.hospitalLogin,data: data);
  //     logger.d("Naresh logIn response $response");
  //     logger.d("Naresh logIn response statusCode ${response.statusCode}");
  //     if(response.statusCode==200){
  //       return LoginResponseModel.fromJson(response.data);
  //     }else{
  //       return throw Exception('Error');
  //     }
  //   } catch (exception) {
  //     logger.d("Naresh exception $exception");
  //     return throw Exception('Error');
  //
  //   }
  //
  // }

  // Future<LoginResponseModel> logIn(data) async {
  //   logger.d("Naresh data $data ApiEndPoints ${ApiEndPoints.hospitalLogin}");
  //
  //   try {
  //     var response = await _apiCall.postRequest(ApiEndPoints.hospitalLogin, data: data);
  //
  //     // Log the raw response
  //     logger.d("Naresh logIn raw response: ${response.toString()}");
  //
  //     // Check if response.data is null
  //     if (response.data == null) {
  //       logger.d("Naresh logIn response data is null");
  //       throw Exception("API returned null response");
  //     }
  //
  //     // Check if response.data is a Map<String, dynamic>
  //     if (response.data is! Map<String, dynamic>) {
  //       logger.d("Naresh logIn response data is not a Map<String, dynamic>");
  //       throw Exception("Unexpected response format");
  //     }
  //
  //     logger.d("Naresh logIn response data: ${response.data}");
  //     if (response.statusCode == 200) {
  //       return LoginResponseModel.fromJson(response.data);
  //     } else {
  //       throw Exception('Error: ${response.data}');
  //     }
  //   } catch (exception) {
  //     logger.d("Naresh exception $exception");
  //     throw Exception('Error during login');
  //   }
  // }

  Future<LoginResponseModel> logIn(data) async {
    logger.d("Naresh data $data ApiEndPoints ${ApiEndPoints.hospitalLogin}");

    try {
      var response = await _apiCall.postRequest(ApiEndPoints.hospitalLogin, data: data);

      // Log the raw response
      logger.d("Naresh logIn raw response: ${response.toString()}");

      // Check if response.data is null
      if (response.data == null) {
        logger.d("Naresh logIn response data is null");
        throw Exception("API returned null response");
      }

      // Check if response.data is a Map<String, dynamic>
      if (response.data is! Map<String, dynamic>) {
        logger.d("Naresh logIn response data is not a Map<String, dynamic>");
        throw Exception("Unexpected response format");
      }

      logger.d("Naresh logIn response data: ${response.data}");
      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        throw Exception('Error: ${response.data}');
      }
    } catch (exception) {
      logger.d("Naresh exception: $exception");
      throw Exception('Error during login');
    }
  }

}
