import 'dart:math';
import 'package:flutter/material.dart';
import '../core/utils/haptic_helper.dart';

// ─── Public API ──────────────────────────────────────────────────────────────

/// Milestones that trigger a celebration.
const _milestones = [7, 30, 100];

/// Call this after a streak value updates.
/// If [streak] is a milestone (7 / 30 / 100) it shows the celebration overlay.
void showMilestoneCelebration(BuildContext context, int streak) {
  if (!_milestones.contains(streak)) return;

  _MilestoneLevel level;
  if (streak == 100) {
    level = _MilestoneLevel.hundred;
    HapticHelper.heavyImpact();
  } else if (streak == 30) {
    level = _MilestoneLevel.thirty;
    HapticHelper.mediumImpact();
  } else {
    level = _MilestoneLevel.seven;
    HapticHelper.selectionClick();
  }

  final overlay = Overlay.of(context);
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (_) => _MilestoneCelebrationOverlay(
      level: level,
      streak: streak,
      onComplete: () => entry.remove(),
    ),
  );

  overlay.insert(entry);
}

// ─── Internal types ───────────────────────────────────────────────────────────

enum _MilestoneLevel { seven, thirty, hundred }

extension _MilestoneLevelX on _MilestoneLevel {
  int get particleCount => switch (this) {
        _MilestoneLevel.seven => 20,
        _MilestoneLevel.thirty => 45,
        _MilestoneLevel.hundred => 80,
      };

  Duration get duration => switch (this) {
        _MilestoneLevel.seven => const Duration(milliseconds: 900),
        _MilestoneLevel.thirty => const Duration(milliseconds: 1300),
        _MilestoneLevel.hundred => const Duration(milliseconds: 1800),
      };

  double get glowOpacity => switch (this) {
        _MilestoneLevel.seven => 0.0,
        _MilestoneLevel.thirty => 0.08,
        _MilestoneLevel.hundred => 0.16,
      };

  String get badgeTitle => switch (this) {
        _MilestoneLevel.seven => '7 Day Streak 🔥',
        _MilestoneLevel.thirty => '30 Day Consistency 💪',
        _MilestoneLevel.hundred => '100 Day Master 🚀',
      };

  String get badgeSub => switch (this) {
        _MilestoneLevel.seven => "You're building real momentum!",
        _MilestoneLevel.thirty => "A full month of showing up. Incredible.",
        _MilestoneLevel.hundred => "100 days. You are unstoppable. 🎉",
      };

  Color get color => switch (this) {
        _MilestoneLevel.seven => const Color(0xFFFFC107),
        _MilestoneLevel.thirty => const Color(0xFFFF7043),
        _MilestoneLevel.hundred => const Color(0xFFE040FB),
      };

  List<String> get emojis => switch (this) {
        _MilestoneLevel.seven => ['⭐', '🎉', '✨'],
        _MilestoneLevel.thirty => ['🔥', '🎉', '💪', '⚡'],
        _MilestoneLevel.hundred => ['🚀', '🎉', '🏆', '🔥', '💥', '⭐'],
      };
}

// ─── Overlay widget ───────────────────────────────────────────────────────────

class _MilestoneCelebrationOverlay extends StatefulWidget {
  final _MilestoneLevel level;
  final int streak;
  final VoidCallback onComplete;

  const _MilestoneCelebrationOverlay({
    required this.level,
    required this.streak,
    required this.onComplete,
  });

  @override
  State<_MilestoneCelebrationOverlay> createState() =>
      _MilestoneCelebrationOverlayState();
}

class _MilestoneCelebrationOverlayState
    extends State<_MilestoneCelebrationOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Confetto> _particles;
  final _random = Random();
  bool _showBadge = false;

  @override
  void initState() {
    super.initState();

    _particles = _generateParticles();

    _controller = AnimationController(vsync: this, duration: widget.level.duration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Show badge after confetti settles
          if (mounted) setState(() => _showBadge = true);
          Future.delayed(const Duration(milliseconds: 2200), () {
            if (mounted) widget.onComplete();
          });
        }
      })
      ..forward();
  }

  List<_Confetto> _generateParticles() {
    return List.generate(widget.level.particleCount, (_) {
      return _Confetto(
        emoji: widget.level.emojis[
            _random.nextInt(widget.level.emojis.length)],
        startX: 0.2 + _random.nextDouble() * 0.6,       // center cluster
        startY: 0.55 + _random.nextDouble() * 0.2,      // lower-center birth
        driftX: (_random.nextDouble() - 0.5) * 0.55,
        riseHeight: 0.35 + _random.nextDouble() * 0.5,
        fontSize: 16.0 + _random.nextDouble() * 18.0,
        delay: _random.nextDouble() * 0.3,
        rotation: (_random.nextDouble() - 0.5) * pi,
        spin: (_random.nextDouble() - 0.5) * pi * 2,    // full rotation during flight
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = widget.level.color;

    return IgnorePointer(
      ignoring: !_showBadge,
      child: Stack(
        children: [
          // ── Screen glow (30+) ─────────────────────────────────────────────
          if (widget.level.glowOpacity > 0)
            AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                final t = _controller.value;
                final glow = t < 0.3
                    ? Curves.easeOut.transform(t / 0.3)
                    : 1.0 - Curves.easeIn.transform((t - 0.3) / 0.7);
                return Opacity(
                  opacity: glow * widget.level.glowOpacity,
                  child: Container(
                    color: color,
                    width: size.width,
                    height: size.height,
                  ),
                );
              },
            ),

          // ── Confetti particles ────────────────────────────────────────────
          AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return Stack(
                children: _particles.map((p) {
                  final raw = _controller.value;
                  final t = ((raw - p.delay) / (1.0 - p.delay)).clamp(0.0, 1.0);
                  if (t <= 0) return const SizedBox.shrink();

                  final eased = Curves.easeOutCubic.transform(t);
                  final x = (p.startX + p.driftX * eased) * size.width;
                  final y = p.startY * size.height -
                      p.riseHeight * eased * size.height;

                  final opacity =
                      t < 0.55 ? 1.0 : (1.0 - ((t - 0.55) / 0.45));
                  final scale = t < 0.12
                      ? Curves.easeOut.transform(t / 0.12)
                      : 1.0 - (t - 0.12) * 0.12;

                  return Positioned(
                    left: x - p.fontSize / 2,
                    top: y - p.fontSize / 2,
                    child: Transform.rotate(
                      angle: p.rotation + p.spin * eased,
                      child: Transform.scale(
                        scale: scale.clamp(0.0, 1.4),
                        child: Opacity(
                          opacity: opacity.clamp(0.0, 1.0),
                          child: Text(
                            p.emoji,
                            style: TextStyle(fontSize: p.fontSize),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),

          // ── Badge popup ───────────────────────────────────────────────────
          AnimatedPositioned(
            duration: const Duration(milliseconds: 450),
            curve: Curves.elasticOut,
            bottom: _showBadge ? 80 : -200,
            left: 24,
            right: 24,
            child: _BadgeCard(
              level: widget.level,
              onDismiss: () {
                if (mounted) {
                  setState(() => _showBadge = false);
                  Future.delayed(const Duration(milliseconds: 300), () {
                    widget.onComplete();
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Badge card ───────────────────────────────────────────────────────────────

class _BadgeCard extends StatelessWidget {
  final _MilestoneLevel level;
  final VoidCallback onDismiss;

  const _BadgeCard({required this.level, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final color = level.color;

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1612),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withOpacity(0.5), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.25),
              blurRadius: 24,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon badge circle
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.6), width: 1.5),
              ),
              child: Center(
                child: Text(
                  level == _MilestoneLevel.seven
                      ? '🔥'
                      : level == _MilestoneLevel.thirty
                          ? '💪'
                          : '🚀',
                  style: const TextStyle(fontSize: 26),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level.badgeTitle,
                    style: TextStyle(
                      color: color,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    level.badgeSub,
                    style: const TextStyle(
                      color: Color(0xFFBBAA99),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Dismiss button
            GestureDetector(
              onTap: onDismiss,
              child: const Icon(
                Icons.close_rounded,
                color: Color(0xFF887766),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Particle data ────────────────────────────────────────────────────────────

class _Confetto {
  final String emoji;
  final double startX;
  final double startY;
  final double driftX;
  final double riseHeight;
  final double fontSize;
  final double delay;
  final double rotation;
  final double spin;

  _Confetto({
    required this.emoji,
    required this.startX,
    required this.startY,
    required this.driftX,
    required this.riseHeight,
    required this.fontSize,
    required this.delay,
    required this.rotation,
    required this.spin,
  });
}
