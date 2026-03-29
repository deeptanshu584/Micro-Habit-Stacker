import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/haptic_helper.dart';
import '../../core/utils/sound_service.dart';
import '../../models/habit_stack.dart';
import '../../providers/completion_provider.dart';
import '../../widgets/emoji_burst.dart';

class SwipeCompleteScreen extends ConsumerStatefulWidget {
  final HabitStack stack;
  const SwipeCompleteScreen({super.key, required this.stack});

  @override
  ConsumerState<SwipeCompleteScreen> createState() => _SwipeCompleteScreenState();
}

class _SwipeCompleteScreenState extends ConsumerState<SwipeCompleteScreen>
    with SingleTickerProviderStateMixin {
  double _dragOffset = 0;
  bool _isCompleted = false;
  late AnimationController _pulseController;

  static const double _threshold = 200;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_isCompleted) return;
    setState(() {
      _dragOffset = (_dragOffset + details.delta.dy).clamp(-_threshold, 0);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_isCompleted) return;
    if (_dragOffset <= -_threshold * 0.75) {
      _complete();
    } else {
      setState(() => _dragOffset = 0);
    }
  }

  Future<void> _complete() async {
    HapticHelper.heavyImpact();
    SoundService.playComplete();
    setState(() => _isCompleted = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) _showMoodPicker();
  }

  void _showMoodPicker() {
    // Capture parent context for overlay (modal has its own context)
    final parentContext = context;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isDismissible: false,
      builder: (_) => _MoodPicker(
        onSelected: (mood) async {
          // Fire emoji burst on the parent overlay
          if (mood > 0) {
            final intensity = mood == 1
                ? BurstIntensity.meh
                : mood == 2
                    ? BurstIntensity.good
                    : BurstIntensity.great;
            showEmojiBurst(parentContext, intensity);
          }

          await ref.read(completionNotifierProvider.notifier)
              .markComplete(widget.stack.uid, mood);

          // Brief pause to let the burst animate
          await Future.delayed(Duration(milliseconds: mood >= 3 ? 800 : 500));

          if (mounted) {
            Navigator.pop(parentContext); // close sheet
            Navigator.pop(parentContext); // go back to home
          }
        },
      ),
    );
  }

  double get _progress => (_dragOffset.abs() / _threshold).clamp(0, 1);

  @override
  Widget build(BuildContext context) {
    final color = AppColors.stackColors[
        widget.stack.colorIndex % AppColors.stackColors.length];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: GestureDetector(
        onVerticalDragUpdate: _onDragUpdate,
        onVerticalDragEnd: _onDragEnd,
        child: Stack(
          children: [
            // Background color flood as user drags
            AnimatedContainer(
              duration: const Duration(milliseconds: 50),
              width: double.infinity,
              height: double.infinity,
              color: _isCompleted
                  ? AppColors.success.withOpacity(0.15)
                  : color.withOpacity(_progress * 0.12),
            ),

            // Main content
            SafeArea(
              child: Column(
                children: [
                  _TopBar(),
                  const Spacer(),
                  _StackContent(
                    stack: widget.stack,
                    color: color,
                    isCompleted: _isCompleted,
                    dragOffset: _dragOffset,
                    progress: _progress,
                    pulseController: _pulseController,
                  ),
                  const Spacer(),
                  _SwipeHint(
                    isCompleted: _isCompleted,
                    progress: _progress,
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.textSecondary),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class _StackContent extends StatelessWidget {
  final HabitStack stack;
  final Color color;
  final bool isCompleted;
  final double dragOffset;
  final double progress;
  final AnimationController pulseController;

  const _StackContent({
    required this.stack,
    required this.color,
    required this.isCompleted,
    required this.dragOffset,
    required this.progress,
    required this.pulseController,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, dragOffset * 0.4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'habit-emoji-${stack.uid}',
              child: Material(
                type: MaterialType.transparency,
                child: AnimatedBuilder(
                  animation: pulseController,
                  builder: (_, __) => Transform.scale(
                    scale: isCompleted
                        ? 1.3
                        : 1.0 + (pulseController.value * 0.06),
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppColors.success.withOpacity(0.2)
                            : color.withOpacity(0.15 + progress * 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isCompleted ? AppColors.success : color,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: isCompleted
                            ? const Icon(Icons.check_rounded,
                                color: AppColors.success, size: 52)
                            : Text(
                                stack.emoji,
                                style: const TextStyle(fontSize: 52),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Trigger text
            Text(
              'After I ${stack.triggerHabit}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 12),

            // New habit text
            Text(
              'I will ${stack.newHabit}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isCompleted ? AppColors.success : AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 16),

            // Category chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                stack.category,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate(target: isCompleted ? 1 : 0)
        .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05))
        .then()
        .scale(begin: const Offset(1.05, 1.05), end: const Offset(1, 1));
  }
}

class _SwipeHint extends StatelessWidget {
  final bool isCompleted;
  final double progress;

  const _SwipeHint({required this.isCompleted, required this.progress});

  @override
  Widget build(BuildContext context) {
    if (isCompleted) return const SizedBox.shrink();
    return Opacity(
      opacity: (1 - progress * 1.5).clamp(0, 1),
      child: Column(
        children: [
          const Icon(Icons.keyboard_arrow_up_rounded,
              color: AppColors.textMuted, size: 28)
              .animate(onPlay: (c) => c.repeat())
              .slideY(begin: 0, end: -0.3, duration: 800.ms, curve: Curves.easeInOut)
              .then()
              .slideY(begin: -0.3, end: 0, duration: 800.ms),
          const SizedBox(height: 8),
          const Text(
            'Swipe up to complete',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _MoodPicker extends StatelessWidget {
  final Function(int) onSelected;
  const _MoodPicker({required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A1F14).withOpacity(0.72),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  '🎉 Done!',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'How did that feel?',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _MoodButton(emoji: '😕', label: 'Meh', mood: 1, onTap: onSelected),
                    _MoodButton(emoji: '😊', label: 'Good', mood: 2, onTap: onSelected),
                    _MoodButton(emoji: '🔥', label: 'Great', mood: 3, onTap: onSelected),
                  ],
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => onSelected(0),
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().slideY(begin: 0.2, duration: 300.ms).fadeIn();
  }
}

class _MoodButton extends StatelessWidget {
  final String emoji;
  final String label;
  final int mood;
  final Function(int) onTap;

  const _MoodButton({
    required this.emoji,
    required this.label,
    required this.mood,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticHelper.lightImpact();
        onTap(mood);
      },
      child: Container(
        width: 90,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ).animate().scale(
      delay: Duration(milliseconds: 100 * mood),
      duration: 300.ms,
      begin: const Offset(0.8, 0.8),
    );
  }
}
