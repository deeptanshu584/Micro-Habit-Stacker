import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/analytics_provider.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(analyticsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: analyticsAsync.when(
          loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary)),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (data) => CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _Header()),
              SliverToBoxAdapter(child: _TopStatsRow(data: data)),
              SliverToBoxAdapter(child: _InsightCards(data: data)),
              SliverToBoxAdapter(child: _Last30DaysChart(data: data)),
              SliverToBoxAdapter(child: _WeekdayBarChart(data: data)),
              SliverToBoxAdapter(child: _MoodDonutChart(data: data)),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: const Text(
        'Analytics 📊',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1);
  }
}

class _TopStatsRow extends StatelessWidget {
  final AnalyticsData data;
  const _TopStatsRow({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Row(
        children: [
          _StatCard(
            value: '${data.totalCompletions}',
            label: 'Total\nCompletions',
            color: AppColors.primary,
            icon: '✅',
          ),
          const SizedBox(width: 12),
          _StatCard(
            value: '${data.overallCompletionRate.toStringAsFixed(0)}%',
            label: 'Last 30\nDays Rate',
            color: AppColors.accentGold,
            icon: '📈',
          ),
          const SizedBox(width: 12),
          _StatCard(
            value: '${data.bestDayStreak}d',
            label: 'Best Day\nStreak',
            color: AppColors.success,
            icon: '🔥',
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms);
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final String icon;

  const _StatCard({
    required this.value,
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.25), width: 1),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InsightCards extends StatelessWidget {
  final AnalyticsData data;
  const _InsightCards({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              _InsightTile(
                label: 'Most Consistent',
                value: data.mostConsistentHabit,
                icon: '🏅',
                color: AppColors.accentGold,
              ),
              const SizedBox(width: 12),
              _InsightTile(
                label: 'Strongest Day',
                value: data.strongestDayName,
                icon: '💪',
                color: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _InsightTile(
                label: 'Weakest Day',
                value: data.weakestDayName,
                icon: '⚠️',
                color: AppColors.accent,
              ),
              const SizedBox(width: 12),
              _InsightTile(
                label: 'Active Stacks',
                value: '${data.totalStacks}',
                icon: '📚',
                color: AppColors.success,
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 150.ms);
  }
}

class _InsightTile extends StatelessWidget {
  final String label;
  final String value;
  final String icon;
  final Color color;

  const _InsightTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.2), width: 1),
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: TextStyle(
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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

class _Last30DaysChart extends StatelessWidget {
  final AnalyticsData data;
  const _Last30DaysChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final spots = <FlSpot>[];
    for (int i = 0; i < data.last30DayCounts.length; i++) {
      spots.add(FlSpot(i.toDouble(), data.last30DayCounts[i].toDouble()));
    }

    return _ChartCard(
      title: 'Last 30 Days',
      subtitle: 'Daily completions',
      child: SizedBox(
        height: 140,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
              getDrawingHorizontalLine: (_) => FlLine(
                color: AppColors.surfaceLight,
                strokeWidth: 1,
              ),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 24,
                  interval: 1,
                  getTitlesWidget: (value, _) => Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: AppColors.primary,
                barWidth: 2.5,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: AppColors.primary.withOpacity(0.08),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 200.ms);
  }
}

class _WeekdayBarChart extends StatelessWidget {
  final AnalyticsData data;
  const _WeekdayBarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final maxVal = data.weekdayCounts.reduce((a, b) => a > b ? a : b);

    return _ChartCard(
      title: 'By Day of Week',
      subtitle: 'Which days you show up most',
      child: SizedBox(
        height: 140,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: maxVal == 0 ? 5 : maxVal.toDouble() * 1.2,
            barTouchData: BarTouchData(enabled: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, _) => Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      days[value.toInt()],
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
            barGroups: List.generate(7, (i) {
              final isMax = data.weekdayCounts[i] == maxVal && maxVal > 0;
              return BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: data.weekdayCounts[i].toDouble(),
                    color: isMax ? AppColors.primary : AppColors.surfaceLight,
                    width: 22,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 250.ms);
  }
}

class _MoodDonutChart extends StatelessWidget {
  final AnalyticsData data;
  const _MoodDonutChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final meh = data.moodCounts[1] ?? 0;
    final good = data.moodCounts[2] ?? 0;
    final great = data.moodCounts[3] ?? 0;
    final total = meh + good + great;

    return _ChartCard(
      title: 'Mood Breakdown',
      subtitle: 'How completing habits made you feel',
      child: total == 0
          ? const SizedBox(
              height: 140,
              child: Center(
                child: Text(
                  'No mood data yet',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 13,
                  ),
                ),
              ),
            )
          : SizedBox(
              height: 140,
              child: Row(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 3,
                        centerSpaceRadius: 35,
                        sections: [
                          if (meh > 0)
                            PieChartSectionData(
                              value: meh.toDouble(),
                              color: AppColors.moodMeh,
                              radius: 28,
                              showTitle: false,
                            ),
                          if (good > 0)
                            PieChartSectionData(
                              value: good.toDouble(),
                              color: AppColors.moodGood,
                              radius: 28,
                              showTitle: false,
                            ),
                          if (great > 0)
                            PieChartSectionData(
                              value: great.toDouble(),
                              color: AppColors.moodGreat,
                              radius: 28,
                              showTitle: false,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _MoodLegendItem(
                        emoji: '😕',
                        label: 'Meh',
                        count: meh,
                        color: AppColors.moodMeh,
                        total: total,
                      ),
                      const SizedBox(height: 10),
                      _MoodLegendItem(
                        emoji: '😊',
                        label: 'Good',
                        count: good,
                        color: AppColors.moodGood,
                        total: total,
                      ),
                      const SizedBox(height: 10),
                      _MoodLegendItem(
                        emoji: '🔥',
                        label: 'Great',
                        count: great,
                        color: AppColors.moodGreat,
                        total: total,
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
    ).animate().fadeIn(delay: 300.ms);
  }
}

class _MoodLegendItem extends StatelessWidget {
  final String emoji;
  final String label;
  final int count;
  final Color color;
  final int total;

  const _MoodLegendItem({
    required this.emoji,
    required this.label,
    required this.count,
    required this.color,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final pct = total == 0 ? 0 : ((count / total) * 100).round();
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '$emoji $label',
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '$pct%',
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _ChartCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.surfaceLight, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
