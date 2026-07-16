import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/assistant_provider.dart';
import '../../widgets/common/custom_card.dart';
import '../../core/theme/color_palette.dart';

class CopilotMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  CopilotMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class AICopilotScreen extends ConsumerStatefulWidget {
  const AICopilotScreen({super.key});

  @override
  ConsumerState<AICopilotScreen> createState() => _AICopilotScreenState();
}

class _AICopilotScreenState extends ConsumerState<AICopilotScreen> {
  final _controller = TextEditingController();
  final List<CopilotMessage> _messages = [];
  bool _isTyping = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleAsk() async {
    final query = _controller.text.trim();
    if (query.isEmpty) return;

    _controller.clear();
    setState(() {
      _messages.add(
          CopilotMessage(text: query, isUser: true, timestamp: DateTime.now()));
      _isTyping = true;
    });

    try {
      await ref.read(assistantProvider.notifier).ask(
            query: query,
            userRole: 'admin',
          );

      final response = ref.read(assistantProvider).response;
      setState(() {
        _isTyping = false;
        if (response != null) {
          _messages.add(CopilotMessage(
              text: response, isUser: false, timestamp: DateTime.now()));
        } else {
          final err = ref.read(assistantProvider).errorMessage;
          _messages.add(CopilotMessage(
            text: err ?? "Error retrieving operations briefing.",
            isUser: false,
            timestamp: DateTime.now(),
          ));
        }
      });
    } catch (e) {
      setState(() {
        _isTyping = false;
        _messages.add(CopilotMessage(
          text: "Operations interface error: $e",
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Operations Copilot'),
        actions: [
          if (_messages.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: () {
                setState(() {
                  _messages.clear();
                });
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Executive Briefing Section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Executive Briefing Card
                  Text(
                    'AI Executive Briefing',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    theme.colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.psychology,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Live Stadium Intelligence',
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'AI-generated operational insights',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () {
                                // Refresh briefing
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.black.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDark ? Colors.white10 : Colors.black12,
                            ),
                          ),
                          child: Text(
                            'Today\'s attendance: 78,432 (98% of capacity). '
                            'Peak crowd at 7:45 PM. '
                            'Gate B congestion reduced by 35% after AI recommendation. '
                            '3 medical emergencies handled in average 4.2 minutes. '
                            'AI prediction: Gate A will reach 95% capacity in 15 minutes. '
                            'Recommendation: Redirect 30% of incoming fans to Gate C.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // AI Decision Engine
                  Text(
                    'AI Decision Engine',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.auto_awesome,
                                color: Colors.orange,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Active AI Decisions',
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '2 decisions executed today',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const _DecisionItem(
                          title: 'Gate B Staff Increase',
                          description: 'AI recommended +25% staff at Gate B',
                          impact: 'Wait time reduced by 40%',
                          timestamp: '10 minutes ago',
                        ),
                        const SizedBox(height: 12),
                        const _DecisionItem(
                          title: 'Crowd Redirect to Gate C',
                          description: 'AI redirected 1,200 fans from Gate A',
                          impact: 'Gate A congestion reduced by 35%',
                          timestamp: '25 minutes ago',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Ask AI Section
                  Text(
                    'Ask AI Operations Copilot',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Message history
                  if (_messages.isNotEmpty) ...[
                    ..._messages
                        .map((msg) => _buildMessageBubble(msg, theme, isDark)),
                    const SizedBox(height: 12),
                  ],

                  if (_isTyping) ...[
                    _buildTypingIndicator(theme, isDark),
                    const SizedBox(height: 12),
                  ],

                  CustomCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              hintText:
                                  'Ask operations, predictions, redirections...',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            onSubmitted: (_) => _handleAsk(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: _handleAsk,
                          color: theme.colorScheme.primary,
                        ),
                      ],
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

  Widget _buildMessageBubble(CopilotMessage msg, ThemeData theme, bool isDark) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        decoration: BoxDecoration(
          gradient: msg.isUser ? AppColors.primaryGradient : null,
          color: msg.isUser
              ? null
              : (isDark
                  ? AppColors.cardDark.withOpacity(0.5)
                  : AppColors.cardLight),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: msg.isUser ? const Radius.circular(16) : Radius.zero,
            bottomRight: msg.isUser ? Radius.zero : const Radius.circular(16),
          ),
          border: msg.isUser
              ? null
              : Border.all(
                  color: isDark
                      ? AppColors.glassBorderDark
                      : AppColors.glassBorderLight,
                  width: 1,
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  msg.isUser ? Icons.person : Icons.psychology,
                  size: 14,
                  color:
                      msg.isUser ? Colors.white70 : theme.colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  msg.isUser ? 'Admin Query' : 'Copilot Intelligence',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color:
                        msg.isUser ? Colors.white70 : theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              msg.text,
              style: TextStyle(
                color: msg.isUser
                    ? Colors.white
                    : (isDark ? AppColors.textOnDark : AppColors.textPrimary),
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator(ThemeData theme, bool isDark) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.cardDark.withOpacity(0.5)
              : AppColors.cardLight,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
            bottomLeft: Radius.zero,
          ),
          border: Border.all(
            color:
                isDark ? AppColors.glassBorderDark : AppColors.glassBorderLight,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDot(0),
            const SizedBox(width: 4),
            _buildDot(1),
            const SizedBox(width: 4),
            _buildDot(2),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return _DotAnimation(index: index);
  }
}

class _DecisionItem extends StatelessWidget {
  final String title;
  final String description;
  final String impact;
  final String timestamp;

  const _DecisionItem({
    required this.title,
    required this.description,
    required this.impact,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                timestamp,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.trending_up,
                size: 14,
                color: Colors.green,
              ),
              const SizedBox(width: 4),
              Text(
                impact,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DotAnimation extends StatefulWidget {
  final int index;
  const _DotAnimation({required this.index});

  @override
  State<_DotAnimation> createState() => _DotAnimationState();
}

class _DotAnimationState extends State<_DotAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Interval(widget.index * 0.2, 0.6 + widget.index * 0.2,
            curve: Curves.easeInOut),
      ),
    );
    _animController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -6 * _animation.value),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isDark ? Colors.white70 : Colors.black54,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
