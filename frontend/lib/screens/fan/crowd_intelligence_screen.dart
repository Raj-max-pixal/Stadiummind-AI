import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/color_palette.dart';
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
    final isDark = theme.brightness == Brightness.dark;
    final crowdData = ref.watch(crowdProvider);
    final assistantState = ref.watch(assistantProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crowd Intelligence'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                ref.read(crowdProvider.notifier).refresh();
              },
            ),
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
                      gradient: LinearGradient(
                        colors: [
                          _getStatusColor(crowdData.overallStatus)
                              .withOpacity(0.15),
                          _getStatusColor(crowdData.overallStatus)
                              .withOpacity(0.05),
                        ],
                      ),
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
                                    style:
                                        theme.textTheme.labelMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    crowdData.overallStatus,
                                    style:
                                        theme.textTheme.headlineSmall?.copyWith(
                                      color: _getStatusColor(
                                          crowdData.overallStatus),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      _getStatusColor(crowdData.overallStatus),
                                      _getStatusColor(crowdData.overallStatus)
                                          .withOpacity(0.7),
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: _getStatusColor(
                                              crowdData.overallStatus)
                                          .withOpacity(0.3),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  _getStatusIcon(crowdData.overallStatus),
                                  color: Colors.white,
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
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomCard(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        height: 220,
                        child: CrowdChart(
                          data:
                              crowdData.gates.map((g) => g.percentage).toList(),
                          labels:
                              crowdData.gates.map((g) => g.gateName).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Gate Status List
                    Text(
                      'Gate Status',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...crowdData.gates.map((gate) => _GateCard(gate: gate)),
                    const SizedBox(height: 24),

                    // AI Insights
                    if (crowdData.aiInsight != null) ...[
                      Text(
                        'AI Insights',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomCard(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.1),
                            AppColors.primary.withOpacity(0.05),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.lightbulb,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                crowdData.aiInsight!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  height: 1.4,
                                ),
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
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange.withOpacity(0.1),
                            Colors.orange.withOpacity(0.05),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.orange,
                                    Colors.orange.shade300
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
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
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      height: 1.4,
                                    ),
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
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomCard(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.secondary.withOpacity(0.1),
                          AppColors.secondary.withOpacity(0.05),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.black.withOpacity(0.03),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isDark
                                    ? Colors.white.withOpacity(0.1)
                                    : Colors.black.withOpacity(0.05),
                                width: 1,
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Select Gate',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
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
                          ),
                          const SizedBox(height: 16),
                          if (assistantState.isLoading)
                            const LoadingIndicator()
                          else if (assistantState.response != null)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    theme.colorScheme.surfaceContainerHighest,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
