import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/prefs_service.dart';
import '../home/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPage> _pages = const [
    _OnboardingPage(
      emoji: '🧠',
      title: 'The Science of Habits',
      body:
          'Research shows that the best way to build a new habit is to '
          'anchor it to something you already do every day. '
          'This is called Habit Stacking.',
      color: AppColors.primary,
    ),
    _OnboardingPage(
      emoji: '🔗',
      title: 'The Formula',
      body:
          '"After I [EXISTING HABIT], I will [NEW HABIT]."\n\n'
          'For example:\nAfter I pour my morning coffee,\n'
          'I will write 3 things I\'m grateful for.',
      color: AppColors.accent,
    ),
    _OnboardingPage(
      emoji: '🔥',
      title: 'Build Your Streak',
      body:
          'Swipe up every day to complete your stacks. '
          'Watch your streaks grow. '
          'Miss a day? You get one streak freeze per week — '
          'because life happens.',
      color: AppColors.accentGold,
    ),
    _OnboardingPage(
      emoji: '🌱',
      title: 'Start Small',
      body:
          'The secret is to make the new habit so small '
          'it feels almost too easy. '
          'One glass of water. Five minutes of reading. '
          'Ten pushups. Small wins compound.',
      color: AppColors.success,
    ),
  ];

  Future<void> _finish() async {
    await PrefsService.setOnboardingComplete();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _finish,
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _pages.length,
                itemBuilder: (context, index) =>
                    _PageContent(page: _pages[index]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (i) {
                final isActive = i == _currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive
                        ? _pages[_currentPage].color
                        : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _pages.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _finish();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _pages[_currentPage].color,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    _currentPage < _pages.length - 1
                        ? 'Next'
                        : 'Start Stacking 🚀',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final String emoji;
  final String title;
  final String body;
  final Color color;

  const _OnboardingPage({
    required this.emoji,
    required this.title,
    required this.body,
    required this.color,
  });
}

class _PageContent extends StatelessWidget {
  final _OnboardingPage page;
  const _PageContent({required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: page.color.withOpacity(0.12),
              shape: BoxShape.circle,
              border: Border.all(
                color: page.color.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                page.emoji,
                style: const TextStyle(fontSize: 56),
              ),
            ),
          )
              .animate()
              .scale(duration: 400.ms, begin: const Offset(0.7, 0.7))
              .fadeIn(),
          const SizedBox(height: 40),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 26,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          )
              .animate()
              .fadeIn(delay: 150.ms)
              .slideY(begin: 0.1),
          const SizedBox(height: 20),
          Text(
            page.body,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.7,
            ),
          )
              .animate()
              .fadeIn(delay: 250.ms)
              .slideY(begin: 0.1),
        ],
      ),
    );
  }
}
