import 'package:dio/dio.dart';
import '../core/constants/api_constants.dart';
import '../models/emergency_model.dart';

class EmergencyService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: ApiConstants.connectTimeout,
    receiveTimeout: ApiConstants.receiveTimeout,
  ));

  Future<EmergencyIncident> reportEmergency({
    required String type,
    required String location,
    required String description,
    required String reporterId,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.emergencyPath}/report',
        data: {
          'type': type,
          'location': location,
          'description': description,
          'reporter_id': reporterId,
        },
      );
      return EmergencyIncident.fromJson(response.data);
    } catch (e) {
      throw Exception('Emergency report error: $e');
    }
  }

  Future<List<EmergencyIncident>> getActiveEmergencies() async {
    try {
      final response = await _dio.get(
        '${ApiConstants.emergencyPath}/active',
      );
      return (response.data as List)
          .map((e) => EmergencyIncident.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Get emergencies error: $e');
    }
  }

  Future<List<Volunteer>> getVolunteers() async {
    try {
      final response = await _dio.get(
        '${ApiConstants.emergencyPath}/volunteers',
      );
      return (response.data as List)
          .map((v) => Volunteer.fromJson(v))
          .toList();
    } catch (e) {
      throw Exception('Get volunteers error: $e');
    }
  }

  Future<void> respondToEmergency({
    required String incidentId,
    required String responderId,
    required String action,
  }) async {
    try {
      await _dio.post(
        '${ApiConstants.emergencyPath}/respond',
        data: {
          'incident_id': incidentId,
          'responder_id': responderId,
          'action': action,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      throw Exception('Emergency response error: $e');
    }
  }
}

final emergencyService = EmergencyService();
