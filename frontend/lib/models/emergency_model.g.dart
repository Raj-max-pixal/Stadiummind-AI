// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmergencyIncidentImpl _$$EmergencyIncidentImplFromJson(
        Map<String, dynamic> json) =>
    _$EmergencyIncidentImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      priority: json['priority'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      reportedAt: DateTime.parse(json['reportedAt'] as String),
      aiSummary: json['aiSummary'] as String?,
      aiRecommendation: json['aiRecommendation'] as String?,
      assignedVolunteerId: json['assignedVolunteerId'] as String?,
      assignedVolunteerName: json['assignedVolunteerName'] as String?,
      medicalTeamId: json['medicalTeamId'] as String?,
      fastestRoute: json['fastestRoute'] as String?,
      status: json['status'] as String?,
      resolvedAt: json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
    );

Map<String, dynamic> _$$EmergencyIncidentImplToJson(
        _$EmergencyIncidentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'priority': instance.priority,
      'location': instance.location,
      'description': instance.description,
      'reportedAt': instance.reportedAt.toIso8601String(),
      'aiSummary': instance.aiSummary,
      'aiRecommendation': instance.aiRecommendation,
      'assignedVolunteerId': instance.assignedVolunteerId,
      'assignedVolunteerName': instance.assignedVolunteerName,
      'medicalTeamId': instance.medicalTeamId,
      'fastestRoute': instance.fastestRoute,
      'status': instance.status,
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
    };

_$VolunteerImpl _$$VolunteerImplFromJson(Map<String, dynamic> json) =>
    _$VolunteerImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      currentLocation: json['currentLocation'] as String,
      status: json['status'] as String,
      assignedIncidentId: json['assignedIncidentId'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$VolunteerImplToJson(_$VolunteerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'currentLocation': instance.currentLocation,
      'status': instance.status,
      'assignedIncidentId': instance.assignedIncidentId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
