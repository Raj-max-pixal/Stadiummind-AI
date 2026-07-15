import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/emergency_model.dart';
import '../services/emergency_service.dart';

class EmergencyState {
  final List<EmergencyIncident> activeEmergencies;
  final List<Volunteer> volunteers;
  final bool isLoading;
  final String? errorMessage;

  EmergencyState({
    this.activeEmergencies = const [],
    this.volunteers = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  EmergencyState copyWith({
    List<EmergencyIncident>? activeEmergencies,
    List<Volunteer>? volunteers,
    bool? isLoading,
    String? errorMessage,
  }) {
    return EmergencyState(
      activeEmergencies: activeEmergencies ?? this.activeEmergencies,
      volunteers: volunteers ?? this.volunteers,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class EmergencyNotifier extends StateNotifier<EmergencyState> {
  final EmergencyService _emergencyService;

  EmergencyNotifier(this._emergencyService) : super(EmergencyState()) {
    loadData();
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      final emergencies = await _emergencyService.getActiveEmergencies();
      final volunteers = await _emergencyService.getVolunteers();
      state = state.copyWith(
        activeEmergencies: emergencies,
        volunteers: volunteers,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> reportEmergency({
    required String type,
    required String location,
    required String description,
    required String reporterId,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final incident = await _emergencyService.reportEmergency(
        type: type,
        location: location,
        description: description,
        reporterId: reporterId,
      );
      state = state.copyWith(
        activeEmergencies: [...state.activeEmergencies, incident],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> respondToEmergency({
    required String incidentId,
    required String responderId,
    required String action,
  }) async {
    try {
      await _emergencyService.respondToEmergency(
        incidentId: incidentId,
        responderId: responderId,
        action: action,
      );
      
      // Update local state
      final updatedEmergencies = state.activeEmergencies.map((e) {
        if (e.id == incidentId) {
          if (action == 'resolve') {
            return e.copyWith(status: 'resolved');
          }
        }
        return e;
      }).toList();
      
      state = state.copyWith(activeEmergencies: updatedEmergencies);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> refresh() async {
    await loadData();
  }
}

final emergencyServiceProvider = Provider<EmergencyService>((ref) {
  return emergencyService;
});

final emergencyProvider = StateNotifierProvider<EmergencyNotifier, EmergencyState>((ref) {
  return EmergencyNotifier(ref.watch(emergencyServiceProvider));
});
