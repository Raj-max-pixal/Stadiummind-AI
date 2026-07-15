import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/translation_provider.dart';
import '../../widgets/common/custom_card.dart';
import '../../widgets/common/loading_indicator.dart';

class VolunteerDashboard extends ConsumerStatefulWidget {
  const VolunteerDashboard({super.key});

  @override
  ConsumerState<VolunteerDashboard> createState() => _VolunteerDashboardState();
}

class _VolunteerDashboardState extends ConsumerState<VolunteerDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const _HomeScreen(),
    const _TranslationScreen(),
    const _AlertsScreen(),
    const _ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.translate_outlined),
            selectedIcon: Icon(Icons.translate),
            label: 'Translate',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_active_outlined),
            selectedIcon: Icon(Icons.notifications_active),
            label: 'Alerts',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Volunteer Dashboard',
                  style: theme.textTheme.titleLarge,
                ),
                Text(
                  'FIFA World Cup 2026',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                onPressed: () {},
              ),
            ],
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: 'Assists Today',
                          value: '24',
                          icon: Icons.people,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          title: 'Active Alerts',
                          value: '3',
                          icon: Icons.warning,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // AI Operations Summary
                  Text(
                    'AI Operations Summary',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.insights,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Stadium Status: NORMAL',
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'AI Analysis: All gates operating within normal parameters. Gate B showing moderate congestion. AI recommends redirecting 20% of incoming fans to Gate C.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Nearby Fans Needing Help
                  Text(
                    'Fans Needing Help',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  CustomCard(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: const Text('Fan at Section 12'),
                      subtitle: const Text('Needs directions to Gate C'),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigation),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  CustomCard(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: const Text('Fan at Food Court'),
                      subtitle: const Text('Spanish speaker needs assistance'),
                      trailing: IconButton(
                        icon: const Icon(Icons.translate),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return CustomCard(
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _TranslationScreen extends ConsumerStatefulWidget {
  const _TranslationScreen();

  @override
  ConsumerState<_TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends ConsumerState<_TranslationScreen> {
  final _inputController = TextEditingController();
  String _sourceLanguage = AppConstants.langEnglish;
  String _targetLanguage = AppConstants.langSpanish;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _handleTranslate() {
    if (_inputController.text.isNotEmpty) {
      ref.read(translationProvider.notifier).translateText(
        text: _inputController.text,
        sourceLanguage: _sourceLanguage,
        targetLanguage: _targetLanguage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translationState = ref.watch(translationProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Translation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Language Selection
            Row(
              children: [
                Expanded(
                  child: CustomCard(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _sourceLanguage,
                        items: const [
                          DropdownMenuItem(
                            value: AppConstants.langEnglish,
                            child: Text('English'),
                          ),
                          DropdownMenuItem(
                            value: AppConstants.langSpanish,
                            child: Text('Spanish'),
                          ),
                          DropdownMenuItem(
                            value: AppConstants.langHindi,
                            child: Text('Hindi'),
                          ),
                          DropdownMenuItem(
                            value: AppConstants.langTamil,
                            child: Text('Tamil'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _sourceLanguage = value);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.swap_horiz),
                  onPressed: () {
                    setState(() {
                      final temp = _sourceLanguage;
                      _sourceLanguage = _targetLanguage;
                      _targetLanguage = temp;
                    });
                  },
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomCard(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _targetLanguage,
                        items: const [
                          DropdownMenuItem(
                            value: AppConstants.langEnglish,
                            child: Text('English'),
                          ),
                          DropdownMenuItem(
                            value: AppConstants.langSpanish,
                            child: Text('Spanish'),
                          ),
                          DropdownMenuItem(
                            value: AppConstants.langHindi,
                            child: Text('Hindi'),
                          ),
                          DropdownMenuItem(
                            value: AppConstants.langTamil,
                            child: Text('Tamil'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _targetLanguage = value);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Input
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Input',
                        style: theme.textTheme.labelMedium,
                      ),
                      IconButton(
                        icon: const Icon(Icons.mic),
                        onPressed: () {
                          // TODO: Implement speech-to-text
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _inputController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Enter text to translate...',
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Translate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _handleTranslate,
                icon: translationState.isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.translate),
                label: Text(translationState.isLoading ? 'Translating...' : 'Translate'),
              ),
            ),
            const SizedBox(height: 24),
            
            // Output
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Translation',
                        style: theme.textTheme.labelMedium,
                      ),
                      IconButton(
                        icon: const Icon(Icons.volume_up),
                        onPressed: () {
                          // TODO: Implement text-to-speech
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (translationState.isLoading)
                    const LoadingIndicator()
                  else if (translationState.translatedText != null)
                    Text(
                      translationState.translatedText!,
                      style: theme.textTheme.bodyMedium,
                    )
                  else if (translationState.errorMessage != null)
                    Text(
                      translationState.errorMessage!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    )
                  else
                    const Text(
                      'Translation will appear here...',
                      style: TextStyle(color: Colors.grey),
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

class _AlertsScreen extends StatelessWidget {
  const _AlertsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Alerts'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CustomCard(
            color: Colors.red.withOpacity(0.1),
            child: ListTile(
              leading: const Icon(Icons.emergency, color: Colors.red),
              title: const Text('Medical Emergency'),
              subtitle: const Text('Section 15 • High Priority'),
              trailing: IconButton(
                icon: const Icon(Icons.navigation),
                onPressed: () {},
              ),
            ),
          ),
          CustomCard(
            color: Colors.orange.withOpacity(0.1),
            child: ListTile(
              leading: const Icon(Icons.warning, color: Colors.orange),
              title: const Text('Crowd Congestion'),
              subtitle: const Text('Gate B • Medium Priority'),
              trailing: IconButton(
                icon: const Icon(Icons.navigation),
                onPressed: () {},
              ),
            ),
          ),
          CustomCard(
            color: Colors.blue.withOpacity(0.1),
            child: ListTile(
              leading: const Icon(Icons.info, color: Colors.blue),
              title: const Text('Lost Child'),
              subtitle: const Text('Section 8 • Low Priority'),
              trailing: IconButton(
                icon: const Icon(Icons.navigation),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: theme.colorScheme.secondary,
              child: const Icon(
                Icons.volunteer_activism,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Volunteer User',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'volunteer@stadiummind.ai',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Volunteer',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
