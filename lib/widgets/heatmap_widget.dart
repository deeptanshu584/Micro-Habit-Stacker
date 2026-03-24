import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class HeatmapWidget extends StatelessWidget {
  final List<DateTime> completedDates;
  final Color color;

  const HeatmapWidget({
    super.key,
    required this.completedDates,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Show last 10 weeks (70 days)
    final today = DateTime.now();
    final startDate = today.subtract(const Duration(days: 69));

    final completedSet = completedDates
        .map((d) => '${d.year}-${d.month}-${d.day}')
        .toSet();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Last 10 weeks',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: Row(
            children: List.generate(10, (week) {
              return Expanded(
                child: Column(
                  children: List.generate(7, (day) {
                    final date = startDate.add(Duration(days: week * 7 + day));
                    final key = '${date.year}-${date.month}-${date.day}';
                    final isDone = completedSet.contains(key);
                    final isToday = date.year == today.year &&
                        date.month == today.month &&
                        date.day == today.day;
                    final isFuture = date.isAfter(today);

                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          color: isFuture
                              ? Colors.transparent
                              : isDone
                                  ? color
                                  : AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(3),
                          border: isToday
                              ? Border.all(color: AppColors.textSecondary, width: 1)
                              : null,
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 4),
            const Text('missed',
                style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
            const SizedBox(width: 10),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 4),
            const Text('done',
                style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
          ],
        ),
      ],
    );
  }
}
