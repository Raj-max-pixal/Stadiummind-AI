import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/translation_provider.dart';
import '../../widgets/common/custom_card.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../core/theme/color_palette.dart';

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
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        child: KeyedSubtree(
          key: ValueKey(_selectedIndex),
          child: _screens[_selectedIndex],
        ),
      ),
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
                  AppConstants.eventName,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ticket scanner opened.')),
                ),
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
                                color:
                                    theme.colorScheme.primary.withOpacity(0.1),
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
                        onPressed: () =>
                            ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Route started to Fan at Section 12.')),
                        ),
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
                        onPressed: () =>
                            ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Translation assistant opened for Spanish support.')),
                        ),
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

  final FlutterTts _flutterTts = FlutterTts();
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

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

  void _speakText(String text, String lang) async {
    String ttsLang = 'en-US';
    if (lang == AppConstants.langSpanish)
      ttsLang = 'es-ES';
    else if (lang == AppConstants.langHindi)
      ttsLang = 'hi-IN';
    else if (lang == AppConstants.langTamil) ttsLang = 'ta-IN';

    try {
      await _flutterTts.setLanguage(ttsLang);
      await _flutterTts.speak(text);
    } catch (e) {
      print("TTS Error: $e");
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = false;
      try {
        available = await _speech.initialize(
          onStatus: (val) => print('onStatus: $val'),
          onError: (val) => print('onError: $val'),
        );
      } catch (e) {
        print("Speech initialization error: $e");
      }

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _inputController.text = val.recognizedWords;
          }),
        );
      } else {
        _openSpeechFallback();
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _openSpeechFallback() {
    setState(() => _isListening = true);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _SpeechInputFallbackDialog(
          onCompleted: (resultText) {
            setState(() {
              _isListening = false;
              _inputController.text = resultText;
            });
            _handleTranslate();
          },
          onCancelled: () {
            setState(() {
              _isListening = false;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translationState = ref.watch(translationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Translation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                          'Input Text',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isListening ? Icons.mic : Icons.mic_none,
                            color: _isListening
                                ? Colors.red
                                : theme.colorScheme.primary,
                          ),
                          onPressed: _listen,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _inputController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText:
                            'Enter text to translate or tap microphone...',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
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
                  label: Text(translationState.isLoading
                      ? 'Translating...'
                      : 'Translate'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
                          'Translation Result',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.volume_up,
                            color: translationState.translatedText != null
                                ? theme.colorScheme.primary
                                : Colors.grey,
                          ),
                          onPressed: translationState.translatedText != null
                              ? () => _speakText(
                                    translationState.translatedText!,
                                    _targetLanguage,
                                  )
                              : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (translationState.isLoading)
                      const LoadingIndicator()
                    else if (translationState.translatedText != null)
                      Text(
                        translationState.translatedText!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
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
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                          'Navigating to medical emergency at Section 15.')),
                ),
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
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Navigating to Gate B congestion point.')),
                ),
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
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                          'Navigating to lost child report at Section 8.')),
                ),
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

class _SpeechInputFallbackDialog extends StatefulWidget {
  final Function(String) onCompleted;
  final VoidCallback onCancelled;

  const _SpeechInputFallbackDialog({
    required this.onCompleted,
    required this.onCancelled,
  });

  @override
  State<_SpeechInputFallbackDialog> createState() =>
      _SpeechInputFallbackDialogState();
}

class _SpeechInputFallbackDialogState extends State<_SpeechInputFallbackDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  final String _statusText = "Listening...";
  int _selectedPhraseIndex = 0;

  final List<String> _fallbackPhrases = [
    "Where is the nearest restroom?",
    "Gate C has a very short queue today.",
    "I need a medical kit in Section 15 immediately.",
    "Please scan your digital ticket at the gate.",
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    // Simulate auto-completion after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pop();
        widget.onCompleted(_fallbackPhrases[_selectedPhraseIndex]);
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Voice Input',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Speech recognition is using a guided input fallback.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 24),

            // Pulsing animation
            AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.red
                        .withOpacity(0.1 + 0.15 * _animController.value),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.red
                          .withOpacity(0.4 * (1.0 - _animController.value)),
                      width: 4 + 8 * _animController.value,
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.mic, color: Colors.red, size: 36),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              _statusText,
              style: theme.textTheme.labelMedium?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Phrase Selector
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select Phrase to Speak:',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...List.generate(_fallbackPhrases.length, (index) {
              return RadioListTile<int>(
                title: Text(_fallbackPhrases[index],
                    style: const TextStyle(fontSize: 12)),
                value: index,
                groupValue: _selectedPhraseIndex,
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _selectedPhraseIndex = val);
                  }
                },
                dense: true,
                contentPadding: EdgeInsets.zero,
              );
            }),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onCancelled();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
