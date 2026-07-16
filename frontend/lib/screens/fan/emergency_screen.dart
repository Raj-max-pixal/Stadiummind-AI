import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/emergency_provider.dart';
import '../../widgets/common/custom_card.dart';

class EmergencyScreen extends ConsumerStatefulWidget {
  const EmergencyScreen({super.key});

  @override
  ConsumerState<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends ConsumerState<EmergencyScreen> {
  final _descriptionController = TextEditingController();
  String _selectedType = 'Medical Emergency';
  String _selectedLocation = 'Section 5';

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleEmergencyReport() {
    ref.read(emergencyProvider.notifier).reportEmergency(
          type: _selectedType,
          location: _selectedLocation,
          description: _descriptionController.text,
          reporterId: 'user_123',
        );
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '$_selectedType reported at $_selectedLocation. Response team notified.'),
        backgroundColor: Colors.red,
      ),
    );
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emergency Button
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.red.shade600,
                    Colors.red.shade800,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _handleEmergencyReport,
                  borderRadius: BorderRadius.circular(20),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.emergency,
                        size: 64,
                        color: Colors.white,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'REPORT EMERGENCY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tap to report emergency',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Emergency Type Selection
            Text(
              'Emergency Type',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _EmergencyTypeChip(
                  label: 'Medical',
                  isSelected: _selectedType == 'Medical Emergency',
                  onTap: () =>
                      setState(() => _selectedType = 'Medical Emergency'),
                ),
                _EmergencyTypeChip(
                  label: 'Security',
                  isSelected: _selectedType == 'Security Incident',
                  onTap: () =>
                      setState(() => _selectedType = 'Security Incident'),
                ),
                _EmergencyTypeChip(
                  label: 'Fire',
                  isSelected: _selectedType == 'Fire',
                  onTap: () => setState(() => _selectedType = 'Fire'),
                ),
                _EmergencyTypeChip(
                  label: 'Fight',
                  isSelected: _selectedType == 'Fight/Altercation',
                  onTap: () =>
                      setState(() => _selectedType = 'Fight/Altercation'),
                ),
                _EmergencyTypeChip(
                  label: 'Lost Child',
                  isSelected: _selectedType == 'Lost Child',
                  onTap: () => setState(() => _selectedType = 'Lost Child'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Location Selection
            Text(
              'Location',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            CustomCard(
              child: DropdownButtonFormField<String>(
                value: _selectedLocation,
                decoration: const InputDecoration(
                  labelText: 'Select Location',
                  border: InputBorder.none,
                ),
                items: const [
                  'Section 5',
                  'Section 8',
                  'Section 12',
                  'Section 15',
                  'Gate A',
                  'Gate B',
                  'Gate C',
                  'Food Court',
                  'Concourse A',
                  'Concourse B',
                ].map((location) {
                  return DropdownMenuItem(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedLocation = value);
                  }
                },
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              'Description',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            CustomCard(
              child: TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Describe the emergency...',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Emergency Contacts
            Text(
              'Emergency Contacts',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            CustomCard(
              child: ListTile(
                leading: const Icon(Icons.local_hospital, color: Colors.red),
                title: const Text('Medical Room'),
                subtitle: const Text('Section 5 • 2 min away'),
                trailing: IconButton(
                  icon: const Icon(Icons.directions),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Route started to Medical Room.')),
                  ),
                ),
              ),
            ),
            CustomCard(
              child: ListTile(
                leading: const Icon(Icons.security, color: Colors.blue),
                title: const Text('Security'),
                subtitle: const Text('Gate A • 1 min away'),
                trailing: IconButton(
                  icon: const Icon(Icons.directions),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Route started to Security at Gate A.')),
                  ),
                ),
              ),
            ),
            CustomCard(
              child: ListTile(
                leading:
                    const Icon(Icons.fire_extinguisher, color: Colors.orange),
                title: const Text('Fire Station'),
                subtitle: const Text('Section 12 • 3 min away'),
                trailing: IconButton(
                  icon: const Icon(Icons.directions),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Route started to Fire Station.')),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // AI Emergency Info
            CustomCard(
              color: Colors.blue.withOpacity(0.1),
              child: Row(
                children: [
                  Icon(
                    Icons.psychology,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Emergency Response',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'AI will automatically analyze your emergency, assign nearest volunteers, and calculate the fastest route for response teams.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmergencyTypeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _EmergencyTypeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: Colors.red.withOpacity(0.2),
      checkmarkColor: Colors.red,
    );
  }
}
