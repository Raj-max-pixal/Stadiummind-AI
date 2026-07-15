import 'package:freezed_annotation/freezed_annotation.dart';

part 'emergency_model.freezed.dart';
part 'emergency_model.g.dart';

@freezed
class EmergencyIncident with _$EmergencyIncident {
  const factory EmergencyIncident({
    required String id,
    required String type,
    required String priority,
    required String location,
    required String description,
    required DateTime reportedAt,
    String? aiSummary,
    String? aiRecommendation,
    String? assignedVolunteerId,
    String? assignedVolunteerName,
    String? medicalTeamId,
    String? fastestRoute,
    String? status,
    DateTime? resolvedAt,
  }) = _EmergencyIncident;

  factory EmergencyIncident.fromJson(Map<String, dynamic> json) =>
      _$EmergencyIncidentFromJson(json);
}

@freezed
class Volunteer with _$Volunteer {
  const factory Volunteer({
    required String id,
    required String name,
    required String currentLocation,
    required String status,
    String? assignedIncidentId,
    double? latitude,
    double? longitude,
  }) = _Volunteer;

  factory Volunteer.fromJson(Map<String, dynamic> json) =>
      _$VolunteerFromJson(json);
}
