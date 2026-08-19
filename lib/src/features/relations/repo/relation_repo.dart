import 'package:meditrack_admin/src/core/utils/logger.dart';

import '../../../core/dio/api_end_points.dart';
import '../../../core/dio/api_services.dart';
import '../relation_details/relation_model.dart';

class RelationRepository {
  final ApiCall _apiCall = ApiCall();

  Future<List<RelationDetail>> fetchRelationDetails(data) async {
    logger.d('Naresh fetchRelationDetails called $data');
    try {
      var response = await _apiCall.getRequest(ApiEndPoints.getUserProfile, queryParameters: data);
      logger.d('Naresh fetchRelationDetails Response from API: ${response.data}');
      if (response.statusCode == 200) {
        final relationModel = RelationModel.fromJson(response.data);
        return relationModel.relations;
      } else {
        throw Exception('Failed to fetch relation details');
      }
    } catch(e) {
      logger.e('Error fetching relation details: $e');
      throw Exception('Failed to fetch relation details');
    }
  }

}
