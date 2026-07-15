import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';

class TranslationService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: ApiConstants.connectTimeout,
    receiveTimeout: ApiConstants.receiveTimeout,
  ));

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

  Future<Map<String, dynamic>> translateVoice({
    required String audioData,
    required String sourceLanguage,
    required String targetLanguage,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.translationPath}/voice',
        data: {
          'audio_data': audioData,
          'source_language': sourceLanguage,
          'target_language': targetLanguage,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Voice translation error: $e');
    }
  }
}

final translationService = TranslationService();
