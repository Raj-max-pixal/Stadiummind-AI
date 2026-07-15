import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/translation_service.dart';

class TranslationState {
  final String? translatedText;
  final String? transcript;
  final bool isLoading;
  final String? errorMessage;

  TranslationState({
    this.translatedText,
    this.transcript,
    this.isLoading = false,
    this.errorMessage,
  });

  TranslationState copyWith({
    String? translatedText,
    String? transcript,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TranslationState(
      translatedText: translatedText ?? this.translatedText,
      transcript: transcript ?? this.transcript,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class TranslationNotifier extends StateNotifier<TranslationState> {
  final TranslationService _translationService;

  TranslationNotifier(this._translationService) : super(TranslationState());

  Future<void> translateText({
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final translated = await _translationService.translateText(
        text: text,
        sourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
      );
      state = state.copyWith(
        translatedText: translated,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> translateVoice({
    required String audioData,
    required String sourceLanguage,
    required String targetLanguage,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final result = await _translationService.translateVoice(
        audioData: audioData,
        sourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
      );
      state = state.copyWith(
        transcript: result['transcript'],
        translatedText: result['translated_text'],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void clear() {
    state = TranslationState();
  }
}

final translationServiceProvider = Provider<TranslationService>((ref) {
  return translationService;
});

final translationProvider = StateNotifierProvider<TranslationNotifier, TranslationState>((ref) {
  return TranslationNotifier(ref.watch(translationServiceProvider));
});
