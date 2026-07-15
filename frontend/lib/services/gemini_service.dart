import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';

class GeminiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: ApiConstants.connectTimeout,
    receiveTimeout: ApiConstants.receiveTimeout,
  ));

  Future<String> askAssistant({
    required String query,
    String userRole = 'fan',
    Map<String, dynamic>? context,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.assistantPath}/ask',
        data: {
          'query': query,
          'user_role': userRole,
          'context': context,
        },
      );
      return response.data['response'];
    } catch (e) {
      throw Exception('Assistant error: $e');
    }
  }

  Future<Map<String, dynamic>> getCrowdPrediction({
    required String gateId,
    int timeHorizonMinutes = 15,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.crowdPath}/predictions',
        data: {
          'gate_id': gateId,
          'time_horizon_minutes': timeHorizonMinutes,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Prediction error: $e');
    }
  }

  Future<Map<String, dynamic>> getGateRecommendations() async {
    try {
      final response = await _dio.get(
        '${ApiConstants.crowdPath}/recommendations',
      );
      return response.data;
    } catch (e) {
      throw Exception('Recommendations error: $e');
    }
  }

  Future<String> translateText({
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.translationPath}/text',
        data: {
          'text': text,
          'source_language': sourceLanguage,
          'target_language': targetLanguage,
        },
      );
      return response.data['translated_text'];
    } catch (e) {
      throw Exception('Translation error: $e');
    }
  }

  Future<String> getExecutiveBriefing() async {
    try {
      final response = await _dio.get(
        '${ApiConstants.adminPath}/executive-briefing',
      );
      return response.data['briefing'];
    } catch (e) {
      throw Exception('Executive briefing error: $e');
    }
  }
}

final geminiService = GeminiService();
