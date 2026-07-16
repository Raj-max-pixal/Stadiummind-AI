import 'dart:math';

import 'package:dio/dio.dart';

import '../models/hotel_room_model.dart';

class HotelRoomService {
  HotelRoomService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://overpass-api.de/api',
            connectTimeout: const Duration(seconds: 20),
            receiveTimeout: const Duration(seconds: 30),
          ),
        );

  final Dio _dio;

  Future<List<HotelRoomModel>> findNearbyRooms({
    required double latitude,
    required double longitude,
    required int radiusMeters,
  }) async {
    final query = '''
[out:json][timeout:25];
(
  node["tourism"~"^(hotel|motel|guest_house|hostel|apartment)\$"](around:$radiusMeters,$latitude,$longitude);
  way["tourism"~"^(hotel|motel|guest_house|hostel|apartment)\$"](around:$radiusMeters,$latitude,$longitude);
  relation["tourism"~"^(hotel|motel|guest_house|hostel|apartment)\$"](around:$radiusMeters,$latitude,$longitude);
);
out center 50;
''';

    final response = await _dio.post(
      '/interpreter',
      data: {'data': query},
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    final elements = (response.data['elements'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();

    final rooms = elements
        .map(
          (element) => _mapElement(
            element,
            latitude,
            longitude,
          ),
        )
        .whereType<HotelRoomModel>()
        .toList()
      ..sort((a, b) => a.distanceMeters.compareTo(b.distanceMeters));

    return rooms;
  }

  HotelRoomModel? _mapElement(
    Map<String, dynamic> element,
    double userLatitude,
    double userLongitude,
  ) {
    final tags = (element['tags'] as Map<String, dynamic>? ?? {})
        .map((key, value) => MapEntry(key, value.toString()));

    final latitude = _readCoordinate(element, 'lat');
    final longitude = _readCoordinate(element, 'lon');
    if (latitude == null || longitude == null) return null;

    final name = tags['name'] ?? tags['brand'] ?? 'Name not provided in OSM';
    final category = tags['tourism'] ?? 'lodging';
    final addressParts = [
      tags['addr:housenumber'],
      tags['addr:street'],
      tags['addr:city'],
      tags['addr:state'],
    ].where((part) => part != null && part.trim().isNotEmpty).join(', ');

    return HotelRoomModel(
      osmId: '${element['type']}/${element['id']}',
      name: name,
      category: category.replaceAll('_', ' '),
      latitude: latitude,
      longitude: longitude,
      distanceMeters: _distanceMeters(
        userLatitude,
        userLongitude,
        latitude,
        longitude,
      ),
      rooms: tags['rooms'],
      beds: tags['beds'],
      phone: tags['contact:phone'] ?? tags['phone'],
      website: tags['contact:website'] ?? tags['website'],
      address: addressParts.isEmpty ? null : addressParts,
    );
  }

  double? _readCoordinate(Map<String, dynamic> element, String key) {
    final direct = element[key];
    if (direct is num) return direct.toDouble();

    final center = element['center'];
    if (center is Map<String, dynamic>) {
      final centerValue = center[key];
      if (centerValue is num) return centerValue.toDouble();
    }

    return null;
  }

  double _distanceMeters(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadiusMeters = 6371000.0;
    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusMeters * c;
  }

  double _degreesToRadians(double degrees) => degrees * pi / 180;
}

final hotelRoomService = HotelRoomService();
