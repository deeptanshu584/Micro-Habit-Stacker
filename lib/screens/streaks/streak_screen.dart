import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/emoji_helper.dart';
import '../../models/habit_stack.dart';
import '../../providers/streak_provider.dart';
import '../../widgets/heatmap_widget.dart';
import '../../widgets/streak_badge.dart';

class StreakScreen extends ConsumerWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allStreaksAsync = ref.watch(allStreaksProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: allStreaksAsync.when(
          loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary)),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (allStreaks) {
            if (allStreaks.isEmpty) {
              return _EmptyState();
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _Header(),
                ),
                SliverToBoxAdapter(
                  child: _OverallSummary(allStreaks: allStreaks),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = allStreaks[index];
                        final stack = item['stack'] as HabitStack;
                        final streak = item['streak'] as StreakData;
                        return _StackStreakCard(
                          stack: stack,
                          streak: streak,
                          index: index,
                        );
                      },
                      childCount: allStreaks.length,
                    ),
                  ),
                ),
              ],
            );
          },
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
        'Your Streaks 🔥',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1);
  }
}

class _OverallSummary extends StatelessWidget {
  final List<Map<String, dynamic>> allStreaks;
  const _OverallSummary({required this.allStreaks});

  @override
  Widget build(BuildContext context) {
    int totalCompletions = 0;
    int bestOverallStreak = 0;
    int activeStreaks = 0;

    for (final item in allStreaks) {
      final streak = item['streak'] as StreakData;
      totalCompletions += streak.totalCompletions;
      if (streak.bestStreak > bestOverallStreak) {
        bestOverallStreak = streak.bestStreak;
      }
      if (streak.currentStreak > 0) activeStreaks++;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Row(
        children: [
          _StatBox(
            value: '$totalCompletions',
            label: 'Total Done',
            color: AppColors.primary,
          ),
          const SizedBox(width: 12),
          _StatBox(
            value: '$bestOverallStreak',
            label: 'Best Streak',
            color: AppColors.accentGold,
          ),
          const SizedBox(width: 12),
          _StatBox(
            value: '$activeStreaks',
            label: 'Active Now',
            color: AppColors.success,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms);
  }
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatBox({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StackStreakCard extends StatelessWidget {
  final HabitStack stack;
  final StreakData streak;
  final int index;

  const _StackStreakCard({
    required this.stack,
    required this.streak,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        AppColors.stackColors[stack.colorIndex % AppColors.stackColors.length];

    final emoji = stack.emoji == '?'
        ? getHabitEmoji('${stack.triggerHabit} ${stack.newHabit}')
        : stack.emoji;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'I will ${stack.newHabit}',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      stack.category,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              StreakBadge(streak: streak.currentStreak),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _MiniStat(
                label: 'Current',
                value: '${streak.currentStreak}d',
                color: AppColors.primary,
              ),
              const SizedBox(width: 12),
              _MiniStat(
                label: 'Best',
                value: '${streak.bestStreak}d',
                color: AppColors.accentGold,
              ),
              const SizedBox(width: 12),
              _MiniStat(
                label: 'Total',
                value: '${streak.totalCompletions}x',
                color: AppColors.accent,
              ),
            ],
          ),
          const SizedBox(height: 16),
          HeatmapWidget(
            completedDates: streak.completedDates,
            color: color,
          ),
          if (streak.currentStreak >= 7) ...[
            const SizedBox(height: 14),
            _IdentityStatement(
              newHabit: stack.newHabit,
              streak: streak.currentStreak,
              color: color,
            ),
          ],
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 100 * index)).slideY(begin: 0.05);
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MiniStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IdentityStatement extends StatelessWidget {
  final String newHabit;
  final int streak;
  final Color color;

  const _IdentityStatement({
    required this.newHabit,
    required this.streak,
    required this.color,
  });

  String _getMessage() {
    if (streak >= 30) return 'You have fully become someone who does this. 🏆';
    if (streak >= 21) return 'This is no longer a habit. This is who you are. ✨';
    if (streak >= 14) return 'You are building a real identity around this. 💪';
    return 'You are becoming someone who $newHabit. Keep going. 🌱';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _getMessage(),
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('📅', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          const Text(
            'No streaks yet',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Complete a habit stack to start your streak',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn().scale(begin: const Offset(0.9, 0.9));
  }
}
