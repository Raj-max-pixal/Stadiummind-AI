import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/crowd_provider.dart';
import '../../providers/assistant_provider.dart';
import '../../widgets/charts/crowd_chart.dart';
import '../../widgets/common/custom_card.dart';
import '../../widgets/common/loading_indicator.dart';

class CrowdIntelligenceScreen extends ConsumerStatefulWidget {
  const CrowdIntelligenceScreen({super.key});

  @override
  ConsumerState<CrowdIntelligenceScreen> createState() =>
      _CrowdIntelligenceScreenState();
}

class _CrowdIntelligenceScreenState
    extends ConsumerState<CrowdIntelligenceScreen> {
  @override
  void initState() {
    super.initState();
    // Load crowd data
    Future.microtask(() {
      ref.read(crowdProvider.notifier).loadCrowdData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final crowdData = ref.watch(crowdProvider);
    final assistantState = ref.watch(assistantProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crowd Intelligence'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(crowdProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: crowdData == null
          ? const Center(child: LoadingIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                await ref.read(crowdProvider.notifier).refresh();
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Overall Status Card
                    CustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Overall Status',
                                    style: theme.textTheme.labelMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    crowdData.overallStatus,
                                    style: theme.textTheme.headlineSmall?.copyWith(
                                      color: _getStatusColor(crowdData.overallStatus),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(crowdData.overallStatus)
                                      .withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _getStatusIcon(crowdData.overallStatus),
                                  color: _getStatusColor(crowdData.overallStatus),
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _StatItem(
                                  label: 'Attendance',
                                  value: '${crowdData.totalAttendance}',
                                  icon: Icons.people,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _StatItem(
                                  label: 'Avg Wait',
                                  value: '${crowdData.averageWaitTime}m',
                                  icon: Icons.timer,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Live Crowd Chart
                    Text(
                      'Live Crowd Density',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    CustomCard(
                      child: SizedBox(
                        height: 200,
                        child: CrowdChart(
                          data: crowdData.gates.map((g) => g.percentage).toList(),
                          labels: crowdData.gates.map((g) => g.gateName).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Gate Status List
                    Text(
                      'Gate Status',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    ...crowdData.gates.map((gate) => _GateCard(gate: gate)),
                    const SizedBox(height: 24),

                    // AI Insights
                    if (crowdData.aiInsight != null) ...[
                      Text(
                        'AI Insights',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      CustomCard(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.lightbulb,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                crowdData.aiInsight!,
                                style: theme.textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // AI Recommendations
                    if (crowdData.aiRecommendation != null) ...[
                      CustomCard(
                        child: Row(
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
                                    'AI Recommendation',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    crowdData.aiRecommendation!,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // AI Prediction
                    Text(
                      'AI Crowd Prediction',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    CustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Select Gate',
                              border: InputBorder.none,
                            ),
                            items: crowdData.gates
                                .map((gate) => DropdownMenuItem(
                                      value: gate.gateId,
                                      child: Text(gate.gateName),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                _getPrediction(value);
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          if (assistantState.isLoading)
                            const LoadingIndicator()
                          else if (assistantState.response != null)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                assistantState.response!,
                                style: theme.textTheme.bodySmall,
                              ),
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

  void _getPrediction(String gateId) {
    ref.read(assistantProvider.notifier).ask(
      query: 'Predict crowd congestion for $gateId in the next 15 minutes',
      userRole: 'fan',
      context: {'gate_id': gateId},
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'normal':
        return Colors.green;
      case 'busy':
        return Colors.orange;
      case 'congested':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'normal':
        return Icons.check_circle;
      case 'busy':
        return Icons.warning;
      case 'congested':
        return Icons.error;
      default:
        return Icons.info;
    }
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.labelSmall,
        ),
      ],
    );
  }
}

class _GateCard extends StatelessWidget {
  final dynamic gate;

  const _GateCard({required this.gate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percentage = gate.percentage as double;
    
    Color getColor() {
      if (percentage < 50) return Colors.green;
      if (percentage < 75) return Colors.orange;
      return Colors.red;
    }
    
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                gate.gateName,
                style: theme.textTheme.titleMedium,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: getColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${percentage.toInt()}%',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: getColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(getColor()),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${gate.currentCount} / ${gate.capacity}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              Text(
                gate.status,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: getColor(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
