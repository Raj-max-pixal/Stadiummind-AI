import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/crowd_model.dart';
import '../services/crowd_service.dart';

class CrowdNotifier extends StateNotifier<CrowdModel?> {
  final CrowdService _crowdService;

  CrowdNotifier(this._crowdService) : super(null) {
    loadCrowdData();
  }

  Future<void> loadCrowdData() async {
    try {
      final data = await _crowdService.getRealtimeCrowd();
      state = data;
    } catch (e) {
      // Keep previous state or set error state
      print('Error loading crowd data: $e');
    }
  }

  Future<void> refresh() async {
    await loadCrowdData();
  }
}

final crowdServiceProvider = Provider<CrowdService>((ref) {
  return crowdService;
});

final crowdProvider = StateNotifierProvider<CrowdNotifier, CrowdModel?>((ref) {
  return CrowdNotifier(ref.watch(crowdServiceProvider));
});
