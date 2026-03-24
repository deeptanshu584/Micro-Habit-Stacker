import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_colors.dart';

class StreakBadge extends StatelessWidget {
  final int streak;
  const StreakBadge({super.key, required this.streak});

  Color get _color {
    if (streak >= 30) return const Color(0xFFFF6B6B);
    if (streak >= 14) return AppColors.accentGold;
    if (streak >= 7)  return AppColors.primary;
    if (streak >= 1)  return AppColors.accent;
    return AppColors.textMuted;
  }

  String get _icon {
    if (streak >= 30) return '🏅';
    if (streak >= 14) return '⚡';
    if (streak >= 7)  return '🔥';
    if (streak >= 1)  return '✨';
    return '💤';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(
            '$streak',
            style: TextStyle(
              color: _color,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ).animate().scale(duration: 300.ms, begin: const Offset(0.8, 0.8));
  }
}
