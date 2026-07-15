// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emergency_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmergencyIncident _$EmergencyIncidentFromJson(Map<String, dynamic> json) {
  return _EmergencyIncident.fromJson(json);
}

/// @nodoc
mixin _$EmergencyIncident {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get reportedAt => throw _privateConstructorUsedError;
  String? get aiSummary => throw _privateConstructorUsedError;
  String? get aiRecommendation => throw _privateConstructorUsedError;
  String? get assignedVolunteerId => throw _privateConstructorUsedError;
  String? get assignedVolunteerName => throw _privateConstructorUsedError;
  String? get medicalTeamId => throw _privateConstructorUsedError;
  String? get fastestRoute => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  DateTime? get resolvedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmergencyIncidentCopyWith<EmergencyIncident> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmergencyIncidentCopyWith<$Res> {
  factory $EmergencyIncidentCopyWith(
          EmergencyIncident value, $Res Function(EmergencyIncident) then) =
      _$EmergencyIncidentCopyWithImpl<$Res, EmergencyIncident>;
  @useResult
  $Res call(
      {String id,
      String type,
      String priority,
      String location,
      String description,
      DateTime reportedAt,
      String? aiSummary,
      String? aiRecommendation,
      String? assignedVolunteerId,
      String? assignedVolunteerName,
      String? medicalTeamId,
      String? fastestRoute,
      String? status,
      DateTime? resolvedAt});
}

/// @nodoc
class _$EmergencyIncidentCopyWithImpl<$Res, $Val extends EmergencyIncident>
    implements $EmergencyIncidentCopyWith<$Res> {
  _$EmergencyIncidentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? priority = null,
    Object? location = null,
    Object? description = null,
    Object? reportedAt = null,
    Object? aiSummary = freezed,
    Object? aiRecommendation = freezed,
    Object? assignedVolunteerId = freezed,
    Object? assignedVolunteerName = freezed,
    Object? medicalTeamId = freezed,
    Object? fastestRoute = freezed,
    Object? status = freezed,
    Object? resolvedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      reportedAt: null == reportedAt
          ? _value.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      aiSummary: freezed == aiSummary
          ? _value.aiSummary
          : aiSummary // ignore: cast_nullable_to_non_nullable
              as String?,
      aiRecommendation: freezed == aiRecommendation
          ? _value.aiRecommendation
          : aiRecommendation // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedVolunteerId: freezed == assignedVolunteerId
          ? _value.assignedVolunteerId
          : assignedVolunteerId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedVolunteerName: freezed == assignedVolunteerName
          ? _value.assignedVolunteerName
          : assignedVolunteerName // ignore: cast_nullable_to_non_nullable
              as String?,
      medicalTeamId: freezed == medicalTeamId
          ? _value.medicalTeamId
          : medicalTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      fastestRoute: freezed == fastestRoute
          ? _value.fastestRoute
          : fastestRoute // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmergencyIncidentImplCopyWith<$Res>
    implements $EmergencyIncidentCopyWith<$Res> {
  factory _$$EmergencyIncidentImplCopyWith(_$EmergencyIncidentImpl value,
          $Res Function(_$EmergencyIncidentImpl) then) =
      __$$EmergencyIncidentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      String priority,
      String location,
      String description,
      DateTime reportedAt,
      String? aiSummary,
      String? aiRecommendation,
      String? assignedVolunteerId,
      String? assignedVolunteerName,
      String? medicalTeamId,
      String? fastestRoute,
      String? status,
      DateTime? resolvedAt});
}

/// @nodoc
class __$$EmergencyIncidentImplCopyWithImpl<$Res>
    extends _$EmergencyIncidentCopyWithImpl<$Res, _$EmergencyIncidentImpl>
    implements _$$EmergencyIncidentImplCopyWith<$Res> {
  __$$EmergencyIncidentImplCopyWithImpl(_$EmergencyIncidentImpl _value,
      $Res Function(_$EmergencyIncidentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? priority = null,
    Object? location = null,
    Object? description = null,
    Object? reportedAt = null,
    Object? aiSummary = freezed,
    Object? aiRecommendation = freezed,
    Object? assignedVolunteerId = freezed,
    Object? assignedVolunteerName = freezed,
    Object? medicalTeamId = freezed,
    Object? fastestRoute = freezed,
    Object? status = freezed,
    Object? resolvedAt = freezed,
  }) {
    return _then(_$EmergencyIncidentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      reportedAt: null == reportedAt
          ? _value.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      aiSummary: freezed == aiSummary
          ? _value.aiSummary
          : aiSummary // ignore: cast_nullable_to_non_nullable
              as String?,
      aiRecommendation: freezed == aiRecommendation
          ? _value.aiRecommendation
          : aiRecommendation // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedVolunteerId: freezed == assignedVolunteerId
          ? _value.assignedVolunteerId
          : assignedVolunteerId // ignore: cast_nullable_to_non_nullable
              as String?,
      assignedVolunteerName: freezed == assignedVolunteerName
          ? _value.assignedVolunteerName
          : assignedVolunteerName // ignore: cast_nullable_to_non_nullable
              as String?,
      medicalTeamId: freezed == medicalTeamId
          ? _value.medicalTeamId
          : medicalTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      fastestRoute: freezed == fastestRoute
          ? _value.fastestRoute
          : fastestRoute // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmergencyIncidentImpl implements _EmergencyIncident {
  const _$EmergencyIncidentImpl(
      {required this.id,
      required this.type,
      required this.priority,
      required this.location,
      required this.description,
      required this.reportedAt,
      this.aiSummary,
      this.aiRecommendation,
      this.assignedVolunteerId,
      this.assignedVolunteerName,
      this.medicalTeamId,
      this.fastestRoute,
      this.status,
      this.resolvedAt});

  factory _$EmergencyIncidentImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmergencyIncidentImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String priority;
  @override
  final String location;
  @override
  final String description;
  @override
  final DateTime reportedAt;
  @override
  final String? aiSummary;
  @override
  final String? aiRecommendation;
  @override
  final String? assignedVolunteerId;
  @override
  final String? assignedVolunteerName;
  @override
  final String? medicalTeamId;
  @override
  final String? fastestRoute;
  @override
  final String? status;
  @override
  final DateTime? resolvedAt;

  @override
  String toString() {
    return 'EmergencyIncident(id: $id, type: $type, priority: $priority, location: $location, description: $description, reportedAt: $reportedAt, aiSummary: $aiSummary, aiRecommendation: $aiRecommendation, assignedVolunteerId: $assignedVolunteerId, assignedVolunteerName: $assignedVolunteerName, medicalTeamId: $medicalTeamId, fastestRoute: $fastestRoute, status: $status, resolvedAt: $resolvedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmergencyIncidentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.reportedAt, reportedAt) ||
                other.reportedAt == reportedAt) &&
            (identical(other.aiSummary, aiSummary) ||
                other.aiSummary == aiSummary) &&
            (identical(other.aiRecommendation, aiRecommendation) ||
                other.aiRecommendation == aiRecommendation) &&
            (identical(other.assignedVolunteerId, assignedVolunteerId) ||
                other.assignedVolunteerId == assignedVolunteerId) &&
            (identical(other.assignedVolunteerName, assignedVolunteerName) ||
                other.assignedVolunteerName == assignedVolunteerName) &&
            (identical(other.medicalTeamId, medicalTeamId) ||
                other.medicalTeamId == medicalTeamId) &&
            (identical(other.fastestRoute, fastestRoute) ||
                other.fastestRoute == fastestRoute) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      priority,
      location,
      description,
      reportedAt,
      aiSummary,
      aiRecommendation,
      assignedVolunteerId,
      assignedVolunteerName,
      medicalTeamId,
      fastestRoute,
      status,
      resolvedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmergencyIncidentImplCopyWith<_$EmergencyIncidentImpl> get copyWith =>
      __$$EmergencyIncidentImplCopyWithImpl<_$EmergencyIncidentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmergencyIncidentImplToJson(
      this,
    );
  }
}

abstract class _EmergencyIncident implements EmergencyIncident {
  const factory _EmergencyIncident(
      {required final String id,
      required final String type,
      required final String priority,
      required final String location,
      required final String description,
      required final DateTime reportedAt,
      final String? aiSummary,
      final String? aiRecommendation,
      final String? assignedVolunteerId,
      final String? assignedVolunteerName,
      final String? medicalTeamId,
      final String? fastestRoute,
      final String? status,
      final DateTime? resolvedAt}) = _$EmergencyIncidentImpl;

  factory _EmergencyIncident.fromJson(Map<String, dynamic> json) =
      _$EmergencyIncidentImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get priority;
  @override
  String get location;
  @override
  String get description;
  @override
  DateTime get reportedAt;
  @override
  String? get aiSummary;
  @override
  String? get aiRecommendation;
  @override
  String? get assignedVolunteerId;
  @override
  String? get assignedVolunteerName;
  @override
  String? get medicalTeamId;
  @override
  String? get fastestRoute;
  @override
  String? get status;
  @override
  DateTime? get resolvedAt;
  @override
  @JsonKey(ignore: true)
  _$$EmergencyIncidentImplCopyWith<_$EmergencyIncidentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Volunteer _$VolunteerFromJson(Map<String, dynamic> json) {
  return _Volunteer.fromJson(json);
}

/// @nodoc
mixin _$Volunteer {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get currentLocation => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get assignedIncidentId => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VolunteerCopyWith<Volunteer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VolunteerCopyWith<$Res> {
  factory $VolunteerCopyWith(Volunteer value, $Res Function(Volunteer) then) =
      _$VolunteerCopyWithImpl<$Res, Volunteer>;
  @useResult
  $Res call(
      {String id,
      String name,
      String currentLocation,
      String status,
      String? assignedIncidentId,
      double? latitude,
      double? longitude});
}

/// @nodoc
class _$VolunteerCopyWithImpl<$Res, $Val extends Volunteer>
    implements $VolunteerCopyWith<$Res> {
  _$VolunteerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? currentLocation = null,
    Object? status = null,
    Object? assignedIncidentId = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      currentLocation: null == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      assignedIncidentId: freezed == assignedIncidentId
          ? _value.assignedIncidentId
          : assignedIncidentId // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VolunteerImplCopyWith<$Res>
    implements $VolunteerCopyWith<$Res> {
  factory _$$VolunteerImplCopyWith(
          _$VolunteerImpl value, $Res Function(_$VolunteerImpl) then) =
      __$$VolunteerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String currentLocation,
      String status,
      String? assignedIncidentId,
      double? latitude,
      double? longitude});
}

/// @nodoc
class __$$VolunteerImplCopyWithImpl<$Res>
    extends _$VolunteerCopyWithImpl<$Res, _$VolunteerImpl>
    implements _$$VolunteerImplCopyWith<$Res> {
  __$$VolunteerImplCopyWithImpl(
      _$VolunteerImpl _value, $Res Function(_$VolunteerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? currentLocation = null,
    Object? status = null,
    Object? assignedIncidentId = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_$VolunteerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      currentLocation: null == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      assignedIncidentId: freezed == assignedIncidentId
          ? _value.assignedIncidentId
          : assignedIncidentId // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VolunteerImpl implements _Volunteer {
  const _$VolunteerImpl(
      {required this.id,
      required this.name,
      required this.currentLocation,
      required this.status,
      this.assignedIncidentId,
      this.latitude,
      this.longitude});

  factory _$VolunteerImpl.fromJson(Map<String, dynamic> json) =>
      _$$VolunteerImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String currentLocation;
  @override
  final String status;
  @override
  final String? assignedIncidentId;
  @override
  final double? latitude;
  @override
  final double? longitude;

  @override
  String toString() {
    return 'Volunteer(id: $id, name: $name, currentLocation: $currentLocation, status: $status, assignedIncidentId: $assignedIncidentId, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VolunteerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.assignedIncidentId, assignedIncidentId) ||
                other.assignedIncidentId == assignedIncidentId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, currentLocation,
      status, assignedIncidentId, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VolunteerImplCopyWith<_$VolunteerImpl> get copyWith =>
      __$$VolunteerImplCopyWithImpl<_$VolunteerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VolunteerImplToJson(
      this,
    );
  }
}

abstract class _Volunteer implements Volunteer {
  const factory _Volunteer(
      {required final String id,
      required final String name,
      required final String currentLocation,
      required final String status,
      final String? assignedIncidentId,
      final double? latitude,
      final double? longitude}) = _$VolunteerImpl;

  factory _Volunteer.fromJson(Map<String, dynamic> json) =
      _$VolunteerImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get currentLocation;
  @override
  String get status;
  @override
  String? get assignedIncidentId;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  @JsonKey(ignore: true)
  _$$VolunteerImplCopyWith<_$VolunteerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
