import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/assistant_provider.dart';
import '../../widgets/common/custom_card.dart';
import '../../widgets/common/loading_indicator.dart';

class AICopilotScreen extends ConsumerStatefulWidget {
  const AICopilotScreen({super.key});

  @override
  ConsumerState<AICopilotScreen> createState() => _AICopilotScreenState();
}

class _AICopilotScreenState extends ConsumerState<AICopilotScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleAsk() {
    if (_controller.text.isNotEmpty) {
      ref.read(assistantProvider.notifier).ask(
        query: _controller.text,
        userRole: 'admin',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final assistantState = ref.watch(assistantProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Operations Copilot'),
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
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withOpacity(0.1),
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
                                    style: theme.textTheme.titleSmall,
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
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Today\'s attendance: 78,432 (98% of capacity). '
                            'Peak crowd at 7:45 PM. '
                            'Gate B congestion reduced by 35% after AI recommendation. '
                            '3 medical emergencies handled in average 4.2 minutes. '
                            'AI prediction: Gate A will reach 95% capacity in 15 minutes. '
                            'Recommendation: Redirect 30% of incoming fans to Gate C.',
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // AI Decision Engine
                  Text(
                    'AI Decision Engine',
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
                                    style: theme.textTheme.titleSmall,
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
                        _DecisionItem(
                          title: 'Gate B Staff Increase',
                          description: 'AI recommended +25% staff at Gate B',
                          impact: 'Wait time reduced by 40%',
                          timestamp: '10 minutes ago',
                        ),
                        const SizedBox(height: 12),
                        _DecisionItem(
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
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  CustomCard(
                    child: Column(
                      children: [
                        TextField(
                          controller: _controller,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: 'Ask about stadium operations, crowd predictions, or recommendations...',
                            border: InputBorder.none,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              onPressed: _handleAsk,
                              icon: const Icon(Icons.send),
                              label: const Text('Ask AI'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // AI Response
                  if (assistantState.isLoading)
                    const LoadingIndicator()
                  else if (assistantState.response != null)
                    CustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.psychology,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'AI Response',
                                style: theme.textTheme.titleSmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            assistantState.response!,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    )
                  else if (assistantState.errorMessage != null)
                    CustomCard(
                      color: theme.colorScheme.errorContainer,
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: theme.colorScheme.error,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              assistantState.errorMessage!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.error,
                              ),
                            ),
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
              Icon(
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
