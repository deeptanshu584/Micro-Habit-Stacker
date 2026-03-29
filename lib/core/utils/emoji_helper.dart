/// Maps habit text keywords to meaningful emojis.
///
/// If the user has manually picked an emoji, prefer that.
/// This function is used as a fallback for auto-assignment.
String getHabitEmoji(String habitText) {
  final text = habitText.toLowerCase();

  const keywordMap = <List<String>, String>{
    ['read', 'book']: '📚',
    ['study', 'learn']: '🧠',
    ['water', 'drink', 'hydrate']: '💧',
    ['exercise', 'workout', 'gym', 'run', 'jog']: '💪',
    ['meditate', 'breathe', 'mindful']: '🧘',
    ['write', 'journal', 'note']: '✍️',
    ['sleep', 'rest', 'nap', 'bed']: '😴',
    ['stretch', 'yoga']: '🧘‍♀️',
    ['walk', 'step']: '🚶',
    ['cook', 'meal', 'eat', 'food']: '🍳',
    ['clean', 'tidy', 'organize']: '🧹',
    ['code', 'program', 'develop']: '💻',
    ['music', 'play', 'instrument', 'piano', 'guitar']: '🎵',
    ['pray', 'gratitude', 'grateful']: '🙏',
    ['coffee', 'tea']: '☕',
    ['shower', 'brush', 'teeth', 'floss']: '🪥',
  };

  for (final entry in keywordMap.entries) {
    for (final keyword in entry.key) {
      if (text.contains(keyword)) {
        return entry.value;
      }
    }
  }

  return '⭐';
}

/// Returns an emoji for a given category name.
String getCategoryEmoji(String category) {
  const map = <String, String>{
    'Morning': '🌅',
    'Work': '💼',
    'Night': '🌙',
    'Fitness': '💪',
    'Other': '⭐',
  };
  return map[category] ?? '⭐';
}
