import 'package:flutter_test/flutter_test.dart';
import 'package:stadiummind_ai/models/hotel_room_model.dart';

void main() {
  group('HotelRoomModel', () {
    test('formats short distances in meters', () {
      const room = HotelRoomModel(
        osmId: 'node/1',
        name: 'Real Hotel',
        category: 'hotel',
        latitude: 12.0,
        longitude: 77.0,
        distanceMeters: 845,
      );

      expect(room.distanceLabel, '845 m');
      expect(room.hasRoomData, isFalse);
    });

    test('formats longer distances in kilometers and detects room data', () {
      const room = HotelRoomModel(
        osmId: 'way/2',
        name: 'Mapped Guest House',
        category: 'guest house',
        latitude: 12.0,
        longitude: 77.0,
        distanceMeters: 2350,
        rooms: '18',
      );

      expect(room.distanceLabel, '2.4 km');
      expect(room.hasRoomData, isTrue);
    });
  });
}
