import 'dart:convert';

import 'package:meditrack_admin/src/core/dio/delete_model.dart';
import 'package:meditrack_admin/src/core/dio/success_model.dart';
import 'package:meditrack_admin/src/core/utils/logger.dart';

import '../../../core/dio/api_end_points.dart';
import '../../../core/dio/api_services.dart';
import '../../../widgets/local_storage.dart';
import '../model/report_type_model.dart';
import '../model/report_type_with_sub_categories.dart';

class RecordRepo {
  final ApiCall _apiCall = ApiCall();

  Future<ReportTypeModel> getReportTypes() async {
    var response = await _apiCall.getRequest(ApiEndPoints.reportTypes);
    if(response.statusCode==200){
      return ReportTypeModel.fromJson(response.data);
    }else{
      return throw Exception('Error');
    }
  }

  Future<List<ReportTypeWithSubCategories>> getCategories() async {
    try {
      var response = await _apiCall.getRequest(ApiEndPoints.getCategories);
      if (response.statusCode == 200) {
        // Parse the response data into a list of ReportTypeWithSubCategories
        return List<ReportTypeWithSubCategories>.from(
          response.data.map((item) => ReportTypeWithSubCategories.fromJson(item)),
        );
      } else {
        throw Exception('Failed to fetch categories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  void printCurlCommand(String url, Map<String, dynamic> data, Map<String, String> headers) {
    final curlCommand = StringBuffer();
    curlCommand.write("curl -X POST '$url' \\\n");

    // Add headers
    headers.forEach((key, value) {
      curlCommand.write("  -H '$key: $value' \\\n");
    });

    // Add data
    curlCommand.write("  -d '${jsonEncode(data)}'");

    logger.d("Naresh curl ${curlCommand.toString()}");
  }

  Future<DeleteModel> addRecord(data) async {
    logger.d('AddRecord Payload: $data');
    // var auth = await box.read(StorageVariable.jwtToken);
    //
    // final headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer $auth',
    // };
    // printCurlCommand(ApiEndPoints.addRecord, data, headers);

    var response = await _apiCall.postRequest1(ApiEndPoints.addRecord, data);
    logger.d("AddRecord Response: ${response.data}");

    if (response.statusCode == 200) {
      return DeleteModel.fromJson(response.data);
    } else {
      throw Exception('Error: ${response.data}');
    }
  }
}
