import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../models/habit_stack.dart';
import '../../providers/habit_stack_provider.dart';

class AddStackScreen extends ConsumerStatefulWidget {
  const AddStackScreen({super.key});

  @override
  ConsumerState<AddStackScreen> createState() => _AddStackScreenState();
}

class _AddStackScreenState extends ConsumerState<AddStackScreen> {
  final _triggerController = TextEditingController();
  final _newHabitController = TextEditingController();
  String _selectedEmoji = '?';
  String _selectedCategory = 'Morning';
  int _selectedColorIndex = 0;
  int _reminderHour = -1;
  int _reminderMinute = 0;
  bool _showEmojiPicker = false;
  bool _isSaving = false;

  @override
  void dispose() {
    _triggerController.dispose();
    _newHabitController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_triggerController.text.trim().isEmpty || _newHabitController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in both habit fields'),
          backgroundColor: AppColors.surface,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    final stack = HabitStack()
      ..uid = const Uuid().v4()
      ..triggerHabit = _triggerController.text.trim()
      ..newHabit = _newHabitController.text.trim()
      ..emoji = _selectedEmoji
      ..category = _selectedCategory
      ..colorIndex = _selectedColorIndex
      ..createdAt = DateTime.now()
      ..reminderHour = _reminderHour
      ..reminderMinute = _reminderMinute
      ..isActive = true
      ..streakFreezeEnabled = true
      ..order = 0;

    await ref.read(habitStackNotifierProvider.notifier).addStack(stack);

    if (mounted) Navigator.pop(context);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.primary,
            surface: AppColors.surface,
            onSurface: AppColors.textPrimary,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _reminderHour = picked.hour;
        _reminderMinute = picked.minute;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textSecondary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'New Stack',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: _isSaving ? null : _save,
              child: Text(
                _isSaving ? 'Saving...' : 'Save',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => setState(() => _showEmojiPicker = false),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FormulaCard(
                triggerController: _triggerController,
                newHabitController: _newHabitController,
                emoji: _selectedEmoji,
                onEmojiTap: () => setState(() => _showEmojiPicker = !_showEmojiPicker),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05),

              if (_showEmojiPicker) ...[
                const SizedBox(height: 12),
                _EmojiPickerWidget(
                  onSelected: (emoji) => setState(() {
                    _selectedEmoji = emoji;
                    _showEmojiPicker = false;
                  }),
                ).animate().fadeIn(duration: 200.ms),
              ],

              const SizedBox(height: 24),
              _SectionLabel('Category'),
              const SizedBox(height: 12),
              _CategorySelector(
                selected: _selectedCategory,
                onChanged: (val) => setState(() => _selectedCategory = val),
              ).animate().fadeIn(delay: 100.ms),

              const SizedBox(height: 24),
              _SectionLabel('Color'),
              const SizedBox(height: 12),
              _ColorSelector(
                selectedIndex: _selectedColorIndex,
                onChanged: (val) => setState(() => _selectedColorIndex = val),
              ).animate().fadeIn(delay: 150.ms),

              const SizedBox(height: 24),
              _SectionLabel('Daily Reminder'),
              const SizedBox(height: 12),
              _ReminderTile(
                hour: _reminderHour,
                minute: _reminderMinute,
                onTap: _pickTime,
                onClear: () => setState(() => _reminderHour = -1),
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormulaCard extends StatelessWidget {
  final TextEditingController triggerController;
  final TextEditingController newHabitController;
  final String emoji;
  final VoidCallback onEmojiTap;

  const _FormulaCard({
    required this.triggerController,
    required this.newHabitController,
    required this.emoji,
    required this.onEmojiTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceLight, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onEmojiTap,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 30)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'After I...',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          _StyledTextField(
            controller: triggerController,
            hint: 'e.g. pour my morning coffee',
          ),
          const SizedBox(height: 20),
          const Text(
            'I will...',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _StyledTextField(
            controller: newHabitController,
            hint: 'e.g. write 3 things I am grateful for',
          ),
        ],
      ),
    );
  }
}

class _StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _StyledTextField({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
        filled: true,
        fillColor: AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

class _EmojiPickerWidget extends StatelessWidget {
  final Function(String) onSelected;
  const _EmojiPickerWidget({required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: EmojiPicker(
        onEmojiSelected: (_, emoji) => onSelected(emoji.emoji),
        config: const Config(height: 256),
      ),
    );
  }
}

class _CategorySelector extends StatelessWidget {
  final String selected;
  final Function(String) onChanged;
  const _CategorySelector({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(AppConstants.categories.length, (i) {
        final cat = AppConstants.categories[i];
        final emoji = (i < AppConstants.categoryEmojis.length) ? AppConstants.categoryEmojis[i] : '';     
        final isSelected = cat == selected;
        return GestureDetector(
          onTap: () => onChanged(cat),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary.withOpacity(0.2) : AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.surfaceLight,
                width: 1.5,
              ),
            ),
            child: Text(
              '$emoji  $cat',
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _ColorSelector extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;
  const _ColorSelector({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(AppColors.stackColors.length, (i) {
        final color = AppColors.stackColors[i];
        final isSelected = i == selectedIndex;
        return GestureDetector(
          onTap: () => onChanged(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(right: 12),
            width: isSelected ? 36 : 30,
            height: isSelected ? 36 : 30,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: AppColors.textPrimary, width: 3)
                  : null,
              boxShadow: isSelected
                  ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 8, spreadRadius: 2)]
                  : null,
            ),
          ),
        );
      }),
    );
  }
}

class _ReminderTile extends StatelessWidget {
  final int hour;
  final int minute;
  final VoidCallback onTap;
  final VoidCallback onClear;
  const _ReminderTile({
    required this.hour,
    required this.minute,
    required this.onTap,
    required this.onClear,
  });

  String _formatTime() {
    final h = hour % 12 == 0 ? 12 : hour % 12;
    final m = minute.toString().padLeft(2, '0');
    final period = hour < 12 ? 'AM' : 'PM';
    return "$h:$m $period";
  }

  @override
  Widget build(BuildContext context) {
    final hasReminder = hour != -1;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: hasReminder ? AppColors.primary.withOpacity(0.4) : AppColors.surfaceLight,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.notifications_outlined,
              color: hasReminder ? AppColors.primary : AppColors.textMuted,
              size: 22,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                hasReminder ? 'Remind me at $_formatTime()' : 'Set a daily reminder (optional)',        
                style: TextStyle(
                  color: hasReminder ? AppColors.textPrimary : AppColors.textMuted,
                  fontSize: 14,
                ),
              ),
            ),
            if (hasReminder)
              GestureDetector(
                onTap: onClear,
                child: const Icon(Icons.close, color: AppColors.textMuted, size: 18),
              ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }
}
