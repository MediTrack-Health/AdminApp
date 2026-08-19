import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meditrack_admin/src/core/cache/local_storage.dart';
import 'package:meditrack_admin/src/core/dio/api_end_points.dart';
import 'package:meditrack_admin/src/widgets/snack_bar.dart';

import '../../widgets/local_storage.dart';
import '../utils/logger.dart';
import 'error_model.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
  late Dio dio;
  String? authToken;
  DioClient._internal() {
    authToken = box.read(StorageVariable.jwtToken);
    print('suuuu $authToken');
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (authToken != null) ...{
            'Authorization': "Bearer $authToken",
          },
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          logger.d('➡️ Request called: ${options.method} ${options.uri}  ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logger.d('✅ Response called: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioError error, handler) {
           ErrorModel errorModel;
          final jsonData = json.decode(error.response.toString());
          errorModel = ErrorModel.fromJson(jsonData);
          print('❌ Error:${errorModel.message}');
          return handler.next(error);
        },
      ),
    );
  }
}
