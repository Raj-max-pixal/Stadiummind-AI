import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/gemini_service.dart';

class AssistantState {
  final String? response;
  final bool isLoading;
  final String? errorMessage;

  AssistantState({
    this.response,
    this.isLoading = false,
    this.errorMessage,
  });

  AssistantState copyWith({
    String? response,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AssistantState(
      response: response ?? this.response,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AssistantNotifier extends StateNotifier<AssistantState> {
  final GeminiService _geminiService;

  AssistantNotifier(this._geminiService) : super(AssistantState());

  Future<void> ask({
    required String query,
    String userRole = 'fan',
    Map<String, dynamic>? context,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await _geminiService.askAssistant(
        query: query,
        userRole: userRole,
        context: context,
      );
      state = state.copyWith(response: response, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void clearResponse() {
    state = state.copyWith(response: null, errorMessage: null);
  }
}

final assistantServiceProvider = Provider<GeminiService>((ref) {
  return geminiService;
});

final assistantProvider = StateNotifierProvider<AssistantNotifier, AssistantState>((ref) {
  return AssistantNotifier(ref.watch(assistantServiceProvider));
});
