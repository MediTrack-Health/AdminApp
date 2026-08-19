import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meditrack_admin/src/widgets/snack_bar.dart';

import '../../widgets/local_storage.dart';
import '../utils/logger.dart';
import 'dio_class.dart';
import 'error_model.dart';

class ApiCall {
  final Dio _dio = DioClient().dio;

  Future<dynamic> getRequest(String endpoint, {queryParameters}) async {
   var auth = await box.read(StorageVariable.jwtToken);
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParameters, options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (auth != null) ...{
          'Authorization': "Bearer $auth",
        },
      },));
      return response;
    }  on DioException catch (e) {
      ErrorModel errorModel;
      final jsonData = json.decode(e.response.toString());
      errorModel = ErrorModel.fromJson(jsonData);
      return CustomSnackBar.toast(errorModel.message);
    }
  }

  Future<dynamic> signUpPostRequest(String endpoint, {Map<String, dynamic>? data}) async {
    logger.d("Naresh post request data $data");

    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
      );

      logger.d("Naresh raw response: ${response.toString()}");
      return response;
    } on DioException catch (e) {
      logger.e("Naresh DioException: $e, Response: ${e.response?.data}");
      throw Exception("DioException occurred");
    } catch (e) {
      logger.e("Naresh Exception: $e");
      throw Exception("An unexpected error occurred");
    }
  }

  Future<dynamic> postRequest(String endpoint, {Map<String, dynamic>? data}) async {

    logger.d("Naresh post request data $data ");

    try {
      final response = await _dio.post(endpoint, data: data,options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },));

      // Ensure response data is not null
      if (response.data == null) {
        logger.d("Naresh response is null");
        throw Exception("API returned null response");
      }
      logger.d("Naresh response $response");

      return response;
    } on DioException catch (e) {
      logger.e("Naresh DioException: $e, Response: ${e.response?.data}");
      throw Exception("DioException occurred");
    } catch (e) {
      logger.e("Naresh Exception: $e");
      throw Exception("An unexpected error occurred");
    }
  }

  Future<dynamic> postRequest1(String endpoint, dynamic data) async {
    var auth = await box.read(StorageVariable.jwtToken);
    logger.d("Naresh auth $auth ");

    try {
      final response = await _dio.post(endpoint, data: data,options: Options( headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (auth != null) ...{
          'Authorization': "Bearer $auth",
        },
      },));
      logger.d("Naresh addRecord response $endpoint --- $response");

      return response;
    } on DioException catch (e) {
      ErrorModel errorModel;
      final jsonData = json.decode(e.response.toString());
      errorModel = ErrorModel.fromJson(jsonData);
      logger.d("Naresh ${errorModel.message}");
      return CustomSnackBar.toast("Something went wrong, Please try again");
    } on Exception catch (e) {
      logger.d("Naresh Exception $e");
      return CustomSnackBar.toast("Something went wrong, Please try again");
    }
  }

  Future<dynamic> putRequest(String endpoint, Map<String, dynamic> data) async {
    var auth = await box.read(StorageVariable.jwtToken);
    try {
      final response = await _dio.put(endpoint, data: data,options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (auth != null) ...{
          'Authorization': "Bearer $auth",
        },
      },));
      return response;
    } on DioException catch (e) {
      ErrorModel errorModel;
      final jsonData = json.decode(e.response.toString());
      errorModel = ErrorModel.fromJson(jsonData);
      logger.d("Naresh DioException error $e");
      logger.d("Naresh DioException message ${errorModel.message}");
      return CustomSnackBar.toast(errorModel.message);
    } on Exception catch (e) {
      logger.d("Naresh Exception error $e");
      return CustomSnackBar.toast("Something went wrong, Please try again");
    }
  }

  Future<dynamic> putRequest1(String endpoint,dynamic data) async {
    var auth = await box.read(StorageVariable.jwtToken);
    try {
      final response = await _dio.put(endpoint, data: data,options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (auth != null) ...{
          'Authorization': "Bearer $auth",
        },
      },));
      return response;
    } on DioException catch (e) {
      ErrorModel errorModel;
      final jsonData = json.decode(e.response.toString());
      logger.d("Naresh putRequest1 DioException error $e");
      errorModel = ErrorModel.fromJson(jsonData);
      logger.d("Naresh putRequest1 DioException message ${errorModel.message}");

      return CustomSnackBar.toast(errorModel.message);
    } on Exception catch (e) {
      logger.d("Naresh Exception error $e");
      return CustomSnackBar.toast("Something went wrong, Please try again");
    }
  }

  Future<dynamic> deleteRequest(String endpoint) async {
    var auth = await box.read(StorageVariable.jwtToken);
    try {
      final response = await _dio.delete(endpoint,options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (auth != null) ...{
          'Authorization': "Bearer $auth",
        },
      },));
      return response;
    } on DioException catch (e) {
      ErrorModel errorModel;
      final jsonData = json.decode(e.response.toString());
      errorModel = ErrorModel.fromJson(jsonData);
      return CustomSnackBar.toast(errorModel.message);
    }
  }
}
