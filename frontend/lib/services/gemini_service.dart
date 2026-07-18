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
      final data = response.data;
      if (data is Map<String, dynamic> && data['response'] != null) {
        return data['response'].toString();
      }
      throw Exception('Invalid assistant response from backend.');
    } on DioException catch (e) {
      throw Exception(_formatDioError(e, 'AI Assistant'));
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
    } on DioException catch (e) {
      throw Exception(_formatDioError(e, 'Crowd prediction'));
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
    } on DioException catch (e) {
      throw Exception(_formatDioError(e, 'Gate recommendations'));
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
    } on DioException catch (e) {
      throw Exception(_formatDioError(e, 'Translation'));
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
    } on DioException catch (e) {
      throw Exception(_formatDioError(e, 'Executive briefing'));
    } catch (e) {
      throw Exception('Executive briefing error: $e');
    }
  }

  String _formatDioError(DioException error, String feature) {
    final response = error.response;
    if (response != null) {
      final data = response.data;
      if (data is Map && data['detail'] != null) {
        return '$feature failed: ${data['detail']}';
      }
      return '$feature failed with HTTP ${response.statusCode}.';
    }

    const backendUrl = ApiConstants.baseUrl;
    if (backendUrl.contains('localhost') || backendUrl.contains('127.0.0.1')) {
      return '$feature cannot reach the backend at $backendUrl. '
          'For the published website, rebuild with --dart-define=BACKEND_URL=https://your-backend-url and --dart-define=BACKEND_WS_URL=wss://your-backend-url.';
    }

    return '$feature cannot reach the backend at $backendUrl. '
        'Check that the backend is running, CORS allows this website, and the URL uses HTTPS.';
  }
}

final geminiService = GeminiService();
