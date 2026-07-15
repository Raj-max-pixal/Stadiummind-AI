// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crowd_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GateDataImpl _$$GateDataImplFromJson(Map<String, dynamic> json) =>
    _$GateDataImpl(
      gateId: json['gateId'] as String,
      gateName: json['gateName'] as String,
      capacity: (json['capacity'] as num).toDouble(),
      currentCount: (json['currentCount'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
      status: json['status'] as String,
      prediction: json['prediction'] as String?,
      recommendation: json['recommendation'] as String?,
    );

Map<String, dynamic> _$$GateDataImplToJson(_$GateDataImpl instance) =>
    <String, dynamic>{
      'gateId': instance.gateId,
      'gateName': instance.gateName,
      'capacity': instance.capacity,
      'currentCount': instance.currentCount,
      'percentage': instance.percentage,
      'status': instance.status,
      'prediction': instance.prediction,
      'recommendation': instance.recommendation,
    };

_$CrowdModelImpl _$$CrowdModelImplFromJson(Map<String, dynamic> json) =>
    _$CrowdModelImpl(
      timestamp: json['timestamp'] as String,
      totalAttendance: (json['totalAttendance'] as num).toInt(),
      gates: (json['gates'] as List<dynamic>)
          .map((e) => GateData.fromJson(e as Map<String, dynamic>))
          .toList(),
      averageWaitTime: (json['averageWaitTime'] as num).toDouble(),
      overallStatus: json['overallStatus'] as String,
      aiInsight: json['aiInsight'] as String?,
      aiRecommendation: json['aiRecommendation'] as String?,
    );

Map<String, dynamic> _$$CrowdModelImplToJson(_$CrowdModelImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'totalAttendance': instance.totalAttendance,
      'gates': instance.gates,
      'averageWaitTime': instance.averageWaitTime,
      'overallStatus': instance.overallStatus,
      'aiInsight': instance.aiInsight,
      'aiRecommendation': instance.aiRecommendation,
    };
