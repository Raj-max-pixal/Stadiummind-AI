class HotelRoomModel {
  final String osmId;
  final String name;
  final String category;
  final double latitude;
  final double longitude;
  final double distanceMeters;
  final String? rooms;
  final String? beds;
  final String? phone;
  final String? website;
  final String? address;

  const HotelRoomModel({
    required this.osmId,
    required this.name,
    required this.category,
    required this.latitude,
    required this.longitude,
    required this.distanceMeters,
    this.rooms,
    this.beds,
    this.phone,
    this.website,
    this.address,
  });

  String get distanceLabel {
    if (distanceMeters < 1000) {
      return '${distanceMeters.round()} m';
    }
    return '${(distanceMeters / 1000).toStringAsFixed(1)} km';
  }

  bool get hasRoomData => rooms != null || beds != null;
}
