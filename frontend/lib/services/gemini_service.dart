import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';

class GeminiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: const Duration(seconds: 8),
    receiveTimeout: const Duration(seconds: 12),
  ));

  Future<String> askAssistant({
    required String query,
    String userRole = 'fan',
    Map<String, dynamic>? context,
  }) async {
    if (_isLocalBackendOnPublishedSite) {
      return _localAssistantResponse(query, userRole);
    }

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
    } on DioException {
      return _localAssistantResponse(query, userRole);
    } catch (e) {
      return _localAssistantResponse(query, userRole);
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

  bool get _isLocalBackendOnPublishedSite {
    const backendUrl = ApiConstants.baseUrl;
    return backendUrl.contains('localhost') || backendUrl.contains('127.0.0.1');
  }

  String _localAssistantResponse(String query, String userRole) {
    final normalized = query.toLowerCase();
    final rolePrefix = userRole == 'admin'
        ? 'Operations view: '
        : userRole == 'volunteer'
            ? 'Volunteer guidance: '
            : '';

    if (normalized.contains('restroom') ||
        normalized.contains('washroom') ||
        normalized.contains('toilet')) {
      return '${rolePrefix}The nearest restrooms are near Section 12 and Section 18. Section 12 has the shortest current wait and accessible facilities.';
    }

    if (normalized.contains('food') ||
        normalized.contains('water') ||
        normalized.contains('drink') ||
        normalized.contains('restaurant')) {
      return '${rolePrefix}Food Court B is the best option right now with the shortest wait. Water kiosks are open near Gates C and E.';
    }

    if (normalized.contains('gate') ||
        normalized.contains('queue') ||
        normalized.contains('entry')) {
      return '${rolePrefix}Gate C is currently recommended. Gate B is moderately congested, so redirecting arrivals to Gate C will reduce wait time.';
    }

    if (normalized.contains('match') ||
        normalized.contains('france') ||
        normalized.contains('england') ||
        normalized.contains('spain') ||
        normalized.contains('argentina') ||
        normalized.contains('time')) {
      return '${rolePrefix}France vs England is the primary live match. Spain vs Argentina is listed as the next featured match. Arrive at your seat at least 30 minutes before kickoff.';
    }

    if (normalized.contains('emergency') ||
        normalized.contains('medical') ||
        normalized.contains('hurt') ||
        normalized.contains('help')) {
      return '${rolePrefix}For emergencies, open the Emergency tab and submit the location immediately. Medical teams are staged near Gate A and Gate E.';
    }

    if (normalized.contains('parking') || normalized.contains('car')) {
      return '${rolePrefix}Lot P3 has the best availability. Use the shuttle from Stop 2 to Gate C for the fastest route.';
    }

    return '${rolePrefix}I can help with gates, queues, restrooms, food, parking, emergencies, and match information for France vs England and Spain vs Argentina.';
  }
}

final geminiService = GeminiService();
