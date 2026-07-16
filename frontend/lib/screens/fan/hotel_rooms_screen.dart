import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/theme/color_palette.dart';
import '../../models/hotel_room_model.dart';
import '../../services/hotel_room_service.dart';
import '../../widgets/common/custom_card.dart';
import '../../widgets/common/loading_indicator.dart';

class HotelRoomsScreen extends StatefulWidget {
  const HotelRoomsScreen({super.key});

  @override
  State<HotelRoomsScreen> createState() => _HotelRoomsScreenState();
}

class _HotelRoomsScreenState extends State<HotelRoomsScreen> {
  final List<int> _radiusOptions = const [2000, 5000, 10000];
  int _radiusMeters = 5000;
  bool _isLoading = true;
  String? _errorMessage;
  Position? _position;
  List<HotelRoomModel> _rooms = const [];

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  Future<void> _loadRooms() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled on this device.');
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        throw Exception(
            'Location permission is required to find rooms near you.');
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Location permission is permanently denied. Enable it in browser or device settings.',
        );
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final rooms = await hotelRoomService.findNearbyRooms(
        latitude: position.latitude,
        longitude: position.longitude,
        radiusMeters: _radiusMeters,
      );

      if (!mounted) return;
      setState(() {
        _position = position;
        _rooms = rooms;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _errorMessage = error.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms Near Me'),
        actions: [
          IconButton(
            tooltip: 'Refresh real hotel data',
            onPressed: _isLoading ? null : _loadRooms,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadRooms,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CustomCard(
              margin: EdgeInsets.zero,
              gradient: AppColors.secondaryGradient,
              child: Row(
                children: [
                  const Icon(Icons.hotel, color: Colors.white, size: 42),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Real nearby lodging',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Loaded from OpenStreetMap. Live prices and booking availability are not shown unless a booking API is connected.',
                          style: TextStyle(color: Colors.white70, height: 1.35),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildRadiusControl(theme),
            const SizedBox(height: 16),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 80),
                child: LoadingIndicator(),
              )
            else if (_errorMessage != null)
              _buildError(theme)
            else if (_rooms.isEmpty)
              _buildEmpty(theme)
            else ...[
              Text(
                '${_rooms.length} real places found',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_position != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Near ${_position!.latitude.toStringAsFixed(4)}, ${_position!.longitude.toStringAsFixed(4)}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
              const SizedBox(height: 12),
              ..._rooms.map((room) => _HotelRoomCard(room: room)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRadiusControl(ThemeData theme) {
    return CustomCard(
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          Icon(Icons.radar, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Search radius',
              style: theme.textTheme.titleSmall,
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _radiusMeters,
              items: _radiusOptions
                  .map(
                    (radius) => DropdownMenuItem<int>(
                      value: radius,
                      child: Text('${radius ~/ 1000} km'),
                    ),
                  )
                  .toList(),
              onChanged: _isLoading
                  ? null
                  : (value) {
                      if (value == null) return;
                      setState(() => _radiusMeters = value);
                      _loadRooms();
                    },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(ThemeData theme) {
    return CustomCard(
      color: theme.colorScheme.error.withOpacity(0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.location_off, color: theme.colorScheme.error, size: 34),
          const SizedBox(height: 12),
          Text(
            'Could not load real nearby rooms',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(_errorMessage ?? 'Unknown location or network error.'),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _loadRooms,
            icon: const Icon(Icons.refresh),
            label: const Text('Try again'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty(ThemeData theme) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.search_off, color: theme.colorScheme.primary, size: 34),
          const SizedBox(height: 12),
          Text(
            'No real lodging data found nearby',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try a larger radius. The app will only show places returned by OpenStreetMap.',
          ),
        ],
      ),
    );
  }
}

class _HotelRoomCard extends StatelessWidget {
  final HotelRoomModel room;

  const _HotelRoomCard({required this.room});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.hotel,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${room.category} - ${room.distanceLabel}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _FactChip(
                icon: Icons.source,
                label: room.osmId,
              ),
              if (room.rooms != null)
                _FactChip(
                  icon: Icons.meeting_room,
                  label: '${room.rooms} rooms',
                ),
              if (room.beds != null)
                _FactChip(
                  icon: Icons.bed,
                  label: '${room.beds} beds',
                ),
              if (!room.hasRoomData)
                const _FactChip(
                  icon: Icons.info_outline,
                  label: 'Room count not provided',
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (room.address != null)
            _InfoLine(icon: Icons.place, text: room.address!),
          if (room.phone != null)
            _InfoLine(icon: Icons.phone, text: room.phone!),
          if (room.website != null)
            _InfoLine(icon: Icons.language, text: room.website!),
          _InfoLine(
            icon: Icons.my_location,
            text:
                '${room.latitude.toStringAsFixed(5)}, ${room.longitude.toStringAsFixed(5)}',
          ),
        ],
      ),
    );
  }
}

class _FactChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FactChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      visualDensity: VisualDensity.compact,
    );
  }
}

class _InfoLine extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoLine({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: SelectableText(
              text,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
