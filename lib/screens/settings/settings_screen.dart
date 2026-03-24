import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/prefs_service.dart';
import '../../core/utils/notification_service.dart';
import '../../providers/isar_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _streakFreezeEnabled = PrefsService.streakFreezeEnabled;

  Future<void> _confirmReset(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Reset All Data?',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          'This will permanently delete all your habit stacks, '
          'streaks, and completion history. This cannot be undone.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textMuted),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Reset',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final isar = await ref.read(isarProvider.future);
      await isar.writeTxn(() => isar.clear());
      await NotificationService.cancelAll();
      await PrefsService.clearAll();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All data has been reset'),
            backgroundColor: AppColors.surface,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: AppColors.textSecondary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SectionHeader('App'),
          const SizedBox(height: 12),
          _SettingsTile(
            icon: '🔥',
            title: 'Streak Freeze',
            subtitle: 'Allow one missed day per week without breaking streak',
            trailing: Switch(
              value: _streakFreezeEnabled,
              activeColor: AppColors.primary,
              onChanged: (val) async {
                setState(() => _streakFreezeEnabled = val);
                await PrefsService.setStreakFreeze(val);
              },
            ),
          ).animate().fadeIn(delay: 50.ms),
          const SizedBox(height: 10),
          _SettingsTile(
            icon: '🔔',
            title: 'Notifications',
            subtitle: 'Reminders are set per habit stack when you create one',
            trailing: const Icon(
              Icons.info_outline_rounded,
              color: AppColors.textMuted,
              size: 18,
            ),
          ).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 24),
          _SectionHeader('About'),
          const SizedBox(height: 12),
          _SettingsTile(
            icon: '📖',
            title: 'Inspired By',
            subtitle: 'Atomic Habits by James Clear',
            trailing: const SizedBox.shrink(),
          ).animate().fadeIn(delay: 150.ms),
          const SizedBox(height: 10),
          _SettingsTile(
            icon: '⚡',
            title: 'Built With',
            subtitle: 'Flutter • Riverpod • Isar • fl_chart',
            trailing: const SizedBox.shrink(),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 10),
          _SettingsTile(
            icon: '📍',
            title: 'Version',
            subtitle: '1.0.0',
            trailing: const SizedBox.shrink(),
          ).animate().fadeIn(delay: 250.ms),
          const SizedBox(height: 24),
          _SectionHeader('Danger Zone'),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => _confirmReset(context),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.redAccent.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Text('🗑️', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reset All Data',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Permanently delete all stacks, streaks and history',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded,
                      color: Colors.redAccent, size: 20),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 40),
          Center(
            child: Text(
              'Small steps. Every day. 🌱',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        color: AppColors.textMuted,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final Widget trailing;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.surfaceLight, width: 1),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
