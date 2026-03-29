import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/emoji_helper.dart';
import '../../core/utils/haptic_helper.dart';
import '../../core/utils/sound_service.dart';
import '../../models/habit_stack.dart';

/// A habit card with inline horizontal swipe-to-complete using spring physics
/// and throttled haptic feedback for a premium "Apple-like" feel.
///
/// Wraps the card content directly (no dependency on HabitCard widget) to
/// control gesture layering precisely.
class SwipeableHabitCard extends StatefulWidget {
  final HabitStack stack;
  final bool isDone;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onComplete;

  const SwipeableHabitCard({
    super.key,
    required this.stack,
    required this.isDone,
    required this.index,
    required this.onTap,
    required this.onDelete,
    required this.onComplete,
  });

  @override
  State<SwipeableHabitCard> createState() => _SwipeableHabitCardState();
}

class _SwipeableHabitCardState extends State<SwipeableHabitCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  late Animation<double> _pulseScale;
  double _dragOffset = 0;
  double _lastHapticOffset = 0;
  bool _hasPassedThreshold = false;
  bool _isDragging = false;
  bool _isCompletingAnimation = false;
  bool _wasDone = false;

  // Spring constants — tuned for an Apple-like natural feel
  static const _spring = SpringDescription(
    mass: 1,
    stiffness: 300,
    damping: 22,
  );

  // How far the card can travel (set in build via LayoutBuilder)
  double _maxDrag = 300;

  // Completion threshold as fraction of card width
  static const _thresholdFraction = 0.45;

  // Haptic throttle: trigger every N pixels of drag travel
  static const _hapticInterval = 40.0;

  @override
  void initState() {
    super.initState();
    _wasDone = widget.isDone;
    _controller = AnimationController.unbounded(vsync: this);
    _controller.addListener(_onAnimationTick);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _pulseScale = Tween<double>(begin: 1.0, end: 1.07).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.elasticOut),
    );
  }

  @override
  void didUpdateWidget(covariant SwipeableHabitCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger pulse when isDone transitions false → true
    if (widget.isDone && !_wasDone) {
      _wasDone = true;
      HapticHelper.selectionClick();
      SoundService.playComplete();
      _pulseController.forward(from: 0);
    } else {
      _wasDone = widget.isDone;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onAnimationTick);
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _onAnimationTick() {
    setState(() => _dragOffset = _controller.value);
  }

  // Non-linear resistance: drag feels heavier closer to the edge
  double _applyResistance(double rawOffset) {
    final fraction = (rawOffset.abs() / _maxDrag).clamp(0.0, 1.0);
    final resistance = 1.0 - fraction * 0.45;
    return rawOffset * resistance;
  }

  void _onDragStart(DragStartDetails details) {
    if (widget.isDone || _isCompletingAnimation) return;
    _controller.stop();
    _isDragging = true;
    _hasPassedThreshold = false;
    _lastHapticOffset = 0;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (widget.isDone || _isCompletingAnimation) return;

    final newRaw = _dragOffset + details.delta.dx;
    // Only allow right-swipe (positive direction)
    final clamped = newRaw.clamp(0.0, _maxDrag);
    setState(() => _dragOffset = _applyResistance(clamped));

    // Throttled haptic during drag
    if ((_dragOffset - _lastHapticOffset).abs() >= _hapticInterval) {
      HapticHelper.selectionClick();
      _lastHapticOffset = _dragOffset;
    }

    // One-shot haptic when crossing threshold
    final threshold = _maxDrag * _thresholdFraction;
    if (!_hasPassedThreshold && _dragOffset >= threshold) {
      _hasPassedThreshold = true;
      HapticHelper.mediumImpact();
      SoundService.playClick();
    } else if (_hasPassedThreshold && _dragOffset < threshold) {
      _hasPassedThreshold = false;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (widget.isDone || _isCompletingAnimation) return;
    _isDragging = false;

    final threshold = _maxDrag * _thresholdFraction;

    if (_dragOffset >= threshold) {
      _animateCompletion();
    } else {
      _animateSnapBack();
    }
  }

  void _animateCompletion() {
    _isCompletingAnimation = true;
    HapticHelper.heavyImpact();

    final simulation = SpringSimulation(
      _spring,
      _dragOffset,
      _maxDrag * 1.2, // overshoot slightly past the edge
      0,
    );
    _controller.animateWith(simulation).then((_) {
      if (mounted) {
        widget.onComplete();
      }
    });
  }

  void _animateSnapBack() {
    HapticHelper.lightImpact();

    final simulation = SpringSimulation(
      _spring,
      _dragOffset,
      0, // snap to origin
      0,
    );
    _controller.animateWith(simulation);
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Delete Stack?',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          'This will also remove all streak and completion history for this stack.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textMuted),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onDelete();
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColors
        .stackColors[widget.stack.colorIndex % AppColors.stackColors.length];
    final progress = (_dragOffset / _maxDrag).clamp(0.0, 1.0);

    // Visual effects based on drag progress
    final scale = 1.0 + (progress * 0.03); // subtle scale-up
    final elevation = progress * 16; // shadow growth
    final completionColorOpacity = (progress - 0.5).clamp(0.0, 0.5); // green tint after 50%
    final fadeOpacity = _isCompletingAnimation
        ? (1.0 - (progress - 0.8).clamp(0.0, 1.0) * 5).clamp(0.0, 1.0)
        : 1.0;

    final emoji = widget.stack.emoji == '?'
        ? getHabitEmoji('${widget.stack.triggerHabit} ${widget.stack.newHabit}')
        : widget.stack.emoji;

    return LayoutBuilder(
      builder: (context, constraints) {
        _maxDrag = constraints.maxWidth;

        return AnimatedBuilder(
          animation: _pulseScale,
          builder: (context, child) {
            final pulseVal = _pulseScale.value;
            final pulseGlow = (pulseVal - 1.0) / 0.07; // 0→1 during pulse

            return Transform.scale(
              scale: pulseVal,
              child: Opacity(
                opacity: fadeOpacity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      // --- Swipe gradient trail (only visible during drag) ---
                      if (_dragOffset > 2 || _isCompletingAnimation)
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _isCompletingAnimation
                              ? (1.0 - progress).clamp(0.0, 1.0)
                              : 1.0,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            width: _isCompletingAnimation
                                ? constraints.maxWidth
                                : _dragOffset + 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  color.withOpacity(0.0),
                                  color.withOpacity(0.06 + progress * 0.18),
                                  color.withOpacity(0.12 + progress * 0.25),
                                ],
                                stops: const [0.0, 0.5, 1.0],
                              ),
                            ),
                          ),
                        ),

                      // --- Foreground card ---
                      Transform.translate(
                        offset: Offset(_dragOffset, 0),
                        child: Transform.scale(
                          scale: _isDragging ? scale : 1.0,
                          child: GestureDetector(
                            onTap: widget.isDone ? null : widget.onTap,
                            onLongPress: () => _showDeleteDialog(context),
                            onHorizontalDragStart: _onDragStart,
                            onHorizontalDragUpdate: _onDragUpdate,
                            onHorizontalDragEnd: _onDragEnd,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: widget.isDone ? 0.7 : 1.0,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: const EdgeInsets.only(bottom: 14),
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: widget.isDone
                                      ? AppColors.success.withOpacity(0.12)
                                      : Color.lerp(
                                          AppColors.surface,
                                          AppColors.success.withOpacity(0.12),
                                          progress,
                                        ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: widget.isDone
                                        ? AppColors.success.withOpacity(0.4)
                                        : progress > 0.3
                                            ? Color.lerp(
                                                color.withOpacity(0.3),
                                                AppColors.success
                                                    .withOpacity(0.6),
                                                ((progress - 0.3) * 2)
                                                    .clamp(0.0, 1.0),
                                              )!
                                            : color.withOpacity(0.3),
                                    width: 1.5,
                                  ),
                                  boxShadow: widget.isDone ||
                                          pulseGlow > 0.01 ||
                                          _isDragging ||
                                          progress > 0
                                      ? [
                                          BoxShadow(
                                            color: widget.isDone
                                                ? AppColors.success
                                                    .withOpacity(0.25)
                                                : color.withOpacity(
                                                    0.15 + progress * 0.2),
                                            blurRadius: widget.isDone
                                                ? 12
                                                : 8 + elevation + (20 * pulseGlow),
                                            spreadRadius: widget.isDone
                                                ? 1
                                                : progress * 2 + (3 * pulseGlow),
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Row(
                          children: [
                            // Emoji container
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Text(
                                  emoji,
                                  style: const TextStyle(fontSize: 26),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            // Habit text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'After I ${widget.stack.triggerHabit}',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 12,
                                      decoration: widget.isDone
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'I will ${widget.stack.newHabit}',
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      decoration: widget.isDone
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: color.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      widget.stack.category,
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Right icon
                            widget.isDone
                                ? const Icon(Icons.check_circle_rounded,
                                    color: AppColors.success, size: 28)
                                : AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    child: progress > 0.3
                                        ? Icon(
                                            Icons.check_circle_outline_rounded,
                                            key: const ValueKey('check'),
                                            color: AppColors.success
                                                .withOpacity(
                                                    ((progress - 0.3) * 2)
                                                        .clamp(0.0, 1.0)),
                                            size: 28,
                                          )
                                        : const Icon(
                                            Icons.chevron_right_rounded,
                                            key: ValueKey('arrow'),
                                            color: AppColors.textMuted,
                                            size: 28,
                                          ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),  // Opacity
              ),  // Container
            );  // Transform.scale
          },  // AnimatedBuilder builder
        );  // AnimatedBuilder
      },  // LayoutBuilder builder
    )  // LayoutBuilder
        .animate()
        .fadeIn(delay: Duration(milliseconds: 100 * widget.index))
        .slideX(begin: 0.05);
  }
}
