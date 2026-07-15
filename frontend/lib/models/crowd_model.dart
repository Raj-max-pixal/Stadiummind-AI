import 'package:freezed_annotation/freezed_annotation.dart';

part 'crowd_model.freezed.dart';
part 'crowd_model.g.dart';

@freezed
class GateData with _$GateData {
  const factory GateData({
    required String gateId,
    required String gateName,
    required double capacity,
    required double currentCount,
    required double percentage,
    required String status,
    String? prediction,
    String? recommendation,
  }) = _GateData;

  factory GateData.fromJson(Map<String, dynamic> json) =>
      _$GateDataFromJson(json);
}

@freezed
class CrowdModel with _$CrowdModel {
  const factory CrowdModel({
    required String timestamp,
    required int totalAttendance,
    required List<GateData> gates,
    required double averageWaitTime,
    required String overallStatus,
    String? aiInsight,
    String? aiRecommendation,
  }) = _CrowdModel;

  factory CrowdModel.fromJson(Map<String, dynamic> json) =>
      _$CrowdModelFromJson(json);
}
