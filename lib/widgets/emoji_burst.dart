import 'dart:math';
import 'package:flutter/material.dart';
import '../core/utils/haptic_helper.dart';

/// Emoji burst intensity matching the mood score.
enum BurstIntensity { meh, good, great }

/// Shows an emoji burst overlay on top of the current screen.
///
/// Call this from anywhere with a valid [BuildContext]:
/// ```dart
/// showEmojiBurst(context, BurstIntensity.great);
/// ```
void showEmojiBurst(BuildContext context, BurstIntensity intensity) {
  // Haptic feedback
  switch (intensity) {
    case BurstIntensity.meh:
      HapticHelper.lightImpact();
      break;
    case BurstIntensity.good:
      HapticHelper.selectionClick();
      break;
    case BurstIntensity.great:
      HapticHelper.mediumImpact();
      break;
  }

  final overlay = Overlay.of(context);
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (_) => _EmojiBurstOverlay(
      intensity: intensity,
      onComplete: () => entry.remove(),
    ),
  );

  overlay.insert(entry);
}

// ─── Overlay widget ──────────────────────────────────────────────────────────

class _EmojiBurstOverlay extends StatefulWidget {
  final BurstIntensity intensity;
  final VoidCallback onComplete;

  const _EmojiBurstOverlay({
    required this.intensity,
    required this.onComplete,
  });

  @override
  State<_EmojiBurstOverlay> createState() => _EmojiBurstOverlayState();
}

class _EmojiBurstOverlayState extends State<_EmojiBurstOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Particle> _particles;
  final _random = Random();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete();
        }
      });

    _particles = _createParticles();
    _controller.forward();
  }

  List<_Particle> _createParticles() {
    int count;
    String emoji;

    switch (widget.intensity) {
      case BurstIntensity.meh:
        count = 3;
        emoji = '😐';
        break;
      case BurstIntensity.good:
        count = 8;
        emoji = '😊';
        break;
      case BurstIntensity.great:
        count = 20;
        emoji = '🔥';
        break;
    }

    // For "great", mix in some 🎉 emojis
    final emojis = widget.intensity == BurstIntensity.great
        ? ['🔥', '🎉', '⭐', '🔥', '🎉']
        : [emoji];

    return List.generate(count, (_) {
      return _Particle(
        emoji: emojis[_random.nextInt(emojis.length)],
        // Horizontal start: centered with random spread ±40% of screen
        startX: 0.5 + (_random.nextDouble() - 0.5) * 0.8,
        // Horizontal drift during animation
        driftX: (_random.nextDouble() - 0.5) * 0.25,
        // Vertical rise: 40–80% of screen height
        riseHeight: 0.4 + _random.nextDouble() * 0.4,
        // Size
        fontSize: 22.0 + _random.nextDouble() * 14.0,
        // Start delay (stagger within the animation)
        delayFraction: _random.nextDouble() * 0.25,
        // Optional rotation
        rotation: (_random.nextDouble() - 0.5) * 0.6,
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

    return IgnorePointer(
      child: SizedBox.expand(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Stack(
              children: _particles.map((p) {
                // Remap animation progress to account for particle's delay
                final t = ((_controller.value - p.delayFraction) /
                        (1.0 - p.delayFraction))
                    .clamp(0.0, 1.0);

                if (t <= 0) return const SizedBox.shrink();

                // Ease-out curve for natural deceleration
                final eased = Curves.easeOutCubic.transform(t);

                // Position
                final x = (p.startX + p.driftX * eased) * size.width;
                final y = size.height - (p.riseHeight * eased * size.height);

                // Fade: fully visible from 0–60%, then fade out
                final opacity = t < 0.6 ? 1.0 : (1.0 - ((t - 0.6) / 0.4));

                // Scale: pop in, then shrink slightly
                final scale = t < 0.15
                    ? Curves.easeOut.transform(t / 0.15)
                    : 1.0 - (t - 0.15) * 0.15;

                return Positioned(
                  left: x - (p.fontSize / 2),
                  top: y - (p.fontSize / 2),
                  child: Transform.rotate(
                    angle: p.rotation * eased,
                    child: Transform.scale(
                      scale: scale.clamp(0.0, 1.5),
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
      ),
    );
  }
}

// ─── Particle data ───────────────────────────────────────────────────────────

class _Particle {
  final String emoji;
  final double startX;
  final double driftX;
  final double riseHeight;
  final double fontSize;
  final double delayFraction;
  final double rotation;

  const _Particle({
    required this.emoji,
    required this.startX,
    required this.driftX,
    required this.riseHeight,
    required this.fontSize,
    required this.delayFraction,
    required this.rotation,
  });
}
