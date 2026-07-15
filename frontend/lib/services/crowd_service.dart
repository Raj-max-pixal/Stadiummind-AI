import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';
import '../models/crowd_model.dart';

class CrowdService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: ApiConstants.connectTimeout,
    receiveTimeout: ApiConstants.receiveTimeout,
  ));

  Future<CrowdModel> getRealtimeCrowd() async {
    try {
      final response = await _dio.get(
        '${ApiConstants.crowdPath}/realtime',
      );
      return CrowdModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Crowd data error: $e');
    }
  }
}

final crowdService = CrowdService();
