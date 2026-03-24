import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/habit_stack_provider.dart';
import '../../providers/completion_provider.dart';
import '../../widgets/habit_card.dart';
import '../add_stack/add_stack_screen.dart';
import '../complete/swipe_complete_screen.dart';
import '../streaks/streak_screen.dart';
import '../analytics/analytics_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final stacksAsync = ref.watch(habitStacksProvider);
    final completionsAsync = ref.watch(todayCompletionsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: stacksAsync.when(
          loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),        
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (stacks) {
            final completions = completionsAsync.asData?.value ?? {};
            final completed = stacks.where((s) => completions.contains(s.uid)).length;
            final total = stacks.length;

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _Header(completed: completed, total: total)),
                SliverToBoxAdapter(child: _ProgressBar(completed: completed, total: total)),
                SliverToBoxAdapter(child: _QuoteCard()),
                if (stacks.isEmpty)
                  SliverFillRemaining(child: _EmptyState())
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final stack = stacks[index];
                          final isDone = completions.contains(stack.uid);
                          return HabitCard(
                            stack: stack,
                            isDone: isDone,
                            index: index,
                            onDelete: () {
                              ref
                                  .read(habitStackNotifierProvider.notifier)
                                  .deleteStack(stack.id);
                            },
                            onTap: () {
                              if (!isDone) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SwipeCompleteScreen(stack: stack),
                                  ),
                                );
                              }
                            },
                          );
                        },
                        childCount: stacks.length,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: _AddButton(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            setState(() => _currentIndex = 0);
          } else if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const StreakScreen()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AnalyticsScreen()));
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_rounded),
            label: 'Streaks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Analytics',
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final int completed;
  final int total;
  const _Header({required this.completed, required this.total});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning ??';
    if (hour < 17) return 'Good afternoon ?';
    return 'Good evening ??';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _greeting(),
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Your Stacks',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$completed / $total done',
                  style: const TextStyle(
                    color: AppColors.accent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(
                  Icons.settings_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1);
  }
}

class _ProgressBar extends StatelessWidget {
  final int completed;
  final int total;
  const _ProgressBar({required this.completed, required this.total});

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : completed / total;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.surfaceLight,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          if (completed == total && total > 0) ...[
            const SizedBox(height: 8),
            const Text(
              '?? All done for today!',
              style: TextStyle(
                color: AppColors.accentGold,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(delay: 100.ms);
  }
}

class _QuoteCard extends StatelessWidget {
  String _todaysQuote() {
    return AppConstants.motivationalQuotes[DateTime.now().day % AppConstants.motivationalQuotes.length];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.surfaceLight, width: 1),
        ),
        child: Row(
          children: [
            const Text('?', style: TextStyle(fontSize: 18)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _todaysQuote(),
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 200.ms);
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('??', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          const Text(
            'No stacks yet',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap + to create your first habit stack',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).scale(begin: const Offset(0.9, 0.9));
  }
}

class _AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddStackScreen()),
      ),
      backgroundColor: AppColors.primary,
      icon: const Icon(Icons.add, color: AppColors.textPrimary),
      label: const Text(
        'New Stack',
        style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
      ),
    ).animate().slideY(begin: 1, delay: 400.ms, duration: 400.ms);
  }
}
