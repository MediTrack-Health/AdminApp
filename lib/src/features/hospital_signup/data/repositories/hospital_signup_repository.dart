import 'package:meditrack_admin/src/core/utils/logger.dart';

import '../../../../core/dio/api_services.dart';
import '../../../../core/dio/api_end_points.dart';
import '../models/hospital_signup_request.dart';

class HospitalSignupRepository {
  final ApiCall _apiCall = ApiCall();

  Future<Map<String, dynamic>> signupHospital(HospitalSignupRequest request) async {
    logger.d('Naresh Hospital Signup request: ${request.toJson()}');

    final response = await _apiCall.signUpPostRequest(
      ApiEndPoints.hospitalSignup,
      data: request.toJson(),
    );

    logger.d('Naresh Hospital Signup Response: ${response.data}');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to sign up hospital');
    }
  }
}