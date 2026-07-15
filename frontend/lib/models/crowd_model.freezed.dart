// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crowd_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GateData _$GateDataFromJson(Map<String, dynamic> json) {
  return _GateData.fromJson(json);
}

/// @nodoc
mixin _$GateData {
  String get gateId => throw _privateConstructorUsedError;
  String get gateName => throw _privateConstructorUsedError;
  double get capacity => throw _privateConstructorUsedError;
  double get currentCount => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get prediction => throw _privateConstructorUsedError;
  String? get recommendation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GateDataCopyWith<GateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GateDataCopyWith<$Res> {
  factory $GateDataCopyWith(GateData value, $Res Function(GateData) then) =
      _$GateDataCopyWithImpl<$Res, GateData>;
  @useResult
  $Res call(
      {String gateId,
      String gateName,
      double capacity,
      double currentCount,
      double percentage,
      String status,
      String? prediction,
      String? recommendation});
}

/// @nodoc
class _$GateDataCopyWithImpl<$Res, $Val extends GateData>
    implements $GateDataCopyWith<$Res> {
  _$GateDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gateId = null,
    Object? gateName = null,
    Object? capacity = null,
    Object? currentCount = null,
    Object? percentage = null,
    Object? status = null,
    Object? prediction = freezed,
    Object? recommendation = freezed,
  }) {
    return _then(_value.copyWith(
      gateId: null == gateId
          ? _value.gateId
          : gateId // ignore: cast_nullable_to_non_nullable
              as String,
      gateName: null == gateName
          ? _value.gateName
          : gateName // ignore: cast_nullable_to_non_nullable
              as String,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as double,
      currentCount: null == currentCount
          ? _value.currentCount
          : currentCount // ignore: cast_nullable_to_non_nullable
              as double,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      prediction: freezed == prediction
          ? _value.prediction
          : prediction // ignore: cast_nullable_to_non_nullable
              as String?,
      recommendation: freezed == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GateDataImplCopyWith<$Res>
    implements $GateDataCopyWith<$Res> {
  factory _$$GateDataImplCopyWith(
          _$GateDataImpl value, $Res Function(_$GateDataImpl) then) =
      __$$GateDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String gateId,
      String gateName,
      double capacity,
      double currentCount,
      double percentage,
      String status,
      String? prediction,
      String? recommendation});
}

/// @nodoc
class __$$GateDataImplCopyWithImpl<$Res>
    extends _$GateDataCopyWithImpl<$Res, _$GateDataImpl>
    implements _$$GateDataImplCopyWith<$Res> {
  __$$GateDataImplCopyWithImpl(
      _$GateDataImpl _value, $Res Function(_$GateDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gateId = null,
    Object? gateName = null,
    Object? capacity = null,
    Object? currentCount = null,
    Object? percentage = null,
    Object? status = null,
    Object? prediction = freezed,
    Object? recommendation = freezed,
  }) {
    return _then(_$GateDataImpl(
      gateId: null == gateId
          ? _value.gateId
          : gateId // ignore: cast_nullable_to_non_nullable
              as String,
      gateName: null == gateName
          ? _value.gateName
          : gateName // ignore: cast_nullable_to_non_nullable
              as String,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as double,
      currentCount: null == currentCount
          ? _value.currentCount
          : currentCount // ignore: cast_nullable_to_non_nullable
              as double,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      prediction: freezed == prediction
          ? _value.prediction
          : prediction // ignore: cast_nullable_to_non_nullable
              as String?,
      recommendation: freezed == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GateDataImpl implements _GateData {
  const _$GateDataImpl(
      {required this.gateId,
      required this.gateName,
      required this.capacity,
      required this.currentCount,
      required this.percentage,
      required this.status,
      this.prediction,
      this.recommendation});

  factory _$GateDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$GateDataImplFromJson(json);

  @override
  final String gateId;
  @override
  final String gateName;
  @override
  final double capacity;
  @override
  final double currentCount;
  @override
  final double percentage;
  @override
  final String status;
  @override
  final String? prediction;
  @override
  final String? recommendation;

  @override
  String toString() {
    return 'GateData(gateId: $gateId, gateName: $gateName, capacity: $capacity, currentCount: $currentCount, percentage: $percentage, status: $status, prediction: $prediction, recommendation: $recommendation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GateDataImpl &&
            (identical(other.gateId, gateId) || other.gateId == gateId) &&
            (identical(other.gateName, gateName) ||
                other.gateName == gateName) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.currentCount, currentCount) ||
                other.currentCount == currentCount) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.prediction, prediction) ||
                other.prediction == prediction) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, gateId, gateName, capacity,
      currentCount, percentage, status, prediction, recommendation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GateDataImplCopyWith<_$GateDataImpl> get copyWith =>
      __$$GateDataImplCopyWithImpl<_$GateDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GateDataImplToJson(
      this,
    );
  }
}

abstract class _GateData implements GateData {
  const factory _GateData(
      {required final String gateId,
      required final String gateName,
      required final double capacity,
      required final double currentCount,
      required final double percentage,
      required final String status,
      final String? prediction,
      final String? recommendation}) = _$GateDataImpl;

  factory _GateData.fromJson(Map<String, dynamic> json) =
      _$GateDataImpl.fromJson;

  @override
  String get gateId;
  @override
  String get gateName;
  @override
  double get capacity;
  @override
  double get currentCount;
  @override
  double get percentage;
  @override
  String get status;
  @override
  String? get prediction;
  @override
  String? get recommendation;
  @override
  @JsonKey(ignore: true)
  _$$GateDataImplCopyWith<_$GateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CrowdModel _$CrowdModelFromJson(Map<String, dynamic> json) {
  return _CrowdModel.fromJson(json);
}

/// @nodoc
mixin _$CrowdModel {
  String get timestamp => throw _privateConstructorUsedError;
  int get totalAttendance => throw _privateConstructorUsedError;
  List<GateData> get gates => throw _privateConstructorUsedError;
  double get averageWaitTime => throw _privateConstructorUsedError;
  String get overallStatus => throw _privateConstructorUsedError;
  String? get aiInsight => throw _privateConstructorUsedError;
  String? get aiRecommendation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CrowdModelCopyWith<CrowdModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CrowdModelCopyWith<$Res> {
  factory $CrowdModelCopyWith(
          CrowdModel value, $Res Function(CrowdModel) then) =
      _$CrowdModelCopyWithImpl<$Res, CrowdModel>;
  @useResult
  $Res call(
      {String timestamp,
      int totalAttendance,
      List<GateData> gates,
      double averageWaitTime,
      String overallStatus,
      String? aiInsight,
      String? aiRecommendation});
}

/// @nodoc
class _$CrowdModelCopyWithImpl<$Res, $Val extends CrowdModel>
    implements $CrowdModelCopyWith<$Res> {
  _$CrowdModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? totalAttendance = null,
    Object? gates = null,
    Object? averageWaitTime = null,
    Object? overallStatus = null,
    Object? aiInsight = freezed,
    Object? aiRecommendation = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      totalAttendance: null == totalAttendance
          ? _value.totalAttendance
          : totalAttendance // ignore: cast_nullable_to_non_nullable
              as int,
      gates: null == gates
          ? _value.gates
          : gates // ignore: cast_nullable_to_non_nullable
              as List<GateData>,
      averageWaitTime: null == averageWaitTime
          ? _value.averageWaitTime
          : averageWaitTime // ignore: cast_nullable_to_non_nullable
              as double,
      overallStatus: null == overallStatus
          ? _value.overallStatus
          : overallStatus // ignore: cast_nullable_to_non_nullable
              as String,
      aiInsight: freezed == aiInsight
          ? _value.aiInsight
          : aiInsight // ignore: cast_nullable_to_non_nullable
              as String?,
      aiRecommendation: freezed == aiRecommendation
          ? _value.aiRecommendation
          : aiRecommendation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CrowdModelImplCopyWith<$Res>
    implements $CrowdModelCopyWith<$Res> {
  factory _$$CrowdModelImplCopyWith(
          _$CrowdModelImpl value, $Res Function(_$CrowdModelImpl) then) =
      __$$CrowdModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String timestamp,
      int totalAttendance,
      List<GateData> gates,
      double averageWaitTime,
      String overallStatus,
      String? aiInsight,
      String? aiRecommendation});
}

/// @nodoc
class __$$CrowdModelImplCopyWithImpl<$Res>
    extends _$CrowdModelCopyWithImpl<$Res, _$CrowdModelImpl>
    implements _$$CrowdModelImplCopyWith<$Res> {
  __$$CrowdModelImplCopyWithImpl(
      _$CrowdModelImpl _value, $Res Function(_$CrowdModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? totalAttendance = null,
    Object? gates = null,
    Object? averageWaitTime = null,
    Object? overallStatus = null,
    Object? aiInsight = freezed,
    Object? aiRecommendation = freezed,
  }) {
    return _then(_$CrowdModelImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      totalAttendance: null == totalAttendance
          ? _value.totalAttendance
          : totalAttendance // ignore: cast_nullable_to_non_nullable
              as int,
      gates: null == gates
          ? _value._gates
          : gates // ignore: cast_nullable_to_non_nullable
              as List<GateData>,
      averageWaitTime: null == averageWaitTime
          ? _value.averageWaitTime
          : averageWaitTime // ignore: cast_nullable_to_non_nullable
              as double,
      overallStatus: null == overallStatus
          ? _value.overallStatus
          : overallStatus // ignore: cast_nullable_to_non_nullable
              as String,
      aiInsight: freezed == aiInsight
          ? _value.aiInsight
          : aiInsight // ignore: cast_nullable_to_non_nullable
              as String?,
      aiRecommendation: freezed == aiRecommendation
          ? _value.aiRecommendation
          : aiRecommendation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CrowdModelImpl implements _CrowdModel {
  const _$CrowdModelImpl(
      {required this.timestamp,
      required this.totalAttendance,
      required final List<GateData> gates,
      required this.averageWaitTime,
      required this.overallStatus,
      this.aiInsight,
      this.aiRecommendation})
      : _gates = gates;

  factory _$CrowdModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CrowdModelImplFromJson(json);

  @override
  final String timestamp;
  @override
  final int totalAttendance;
  final List<GateData> _gates;
  @override
  List<GateData> get gates {
    if (_gates is EqualUnmodifiableListView) return _gates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gates);
  }

  @override
  final double averageWaitTime;
  @override
  final String overallStatus;
  @override
  final String? aiInsight;
  @override
  final String? aiRecommendation;

  @override
  String toString() {
    return 'CrowdModel(timestamp: $timestamp, totalAttendance: $totalAttendance, gates: $gates, averageWaitTime: $averageWaitTime, overallStatus: $overallStatus, aiInsight: $aiInsight, aiRecommendation: $aiRecommendation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CrowdModelImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.totalAttendance, totalAttendance) ||
                other.totalAttendance == totalAttendance) &&
            const DeepCollectionEquality().equals(other._gates, _gates) &&
            (identical(other.averageWaitTime, averageWaitTime) ||
                other.averageWaitTime == averageWaitTime) &&
            (identical(other.overallStatus, overallStatus) ||
                other.overallStatus == overallStatus) &&
            (identical(other.aiInsight, aiInsight) ||
                other.aiInsight == aiInsight) &&
            (identical(other.aiRecommendation, aiRecommendation) ||
                other.aiRecommendation == aiRecommendation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      timestamp,
      totalAttendance,
      const DeepCollectionEquality().hash(_gates),
      averageWaitTime,
      overallStatus,
      aiInsight,
      aiRecommendation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CrowdModelImplCopyWith<_$CrowdModelImpl> get copyWith =>
      __$$CrowdModelImplCopyWithImpl<_$CrowdModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CrowdModelImplToJson(
      this,
    );
  }
}

abstract class _CrowdModel implements CrowdModel {
  const factory _CrowdModel(
      {required final String timestamp,
      required final int totalAttendance,
      required final List<GateData> gates,
      required final double averageWaitTime,
      required final String overallStatus,
      final String? aiInsight,
      final String? aiRecommendation}) = _$CrowdModelImpl;

  factory _CrowdModel.fromJson(Map<String, dynamic> json) =
      _$CrowdModelImpl.fromJson;

  @override
  String get timestamp;
  @override
  int get totalAttendance;
  @override
  List<GateData> get gates;
  @override
  double get averageWaitTime;
  @override
  String get overallStatus;
  @override
  String? get aiInsight;
  @override
  String? get aiRecommendation;
  @override
  @JsonKey(ignore: true)
  _$$CrowdModelImplCopyWith<_$CrowdModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
