import 'package:audioplayers/audioplayers.dart';
import 'prefs_service.dart';

class SoundService {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playClick() async {
    if (PrefsService.soundEnabled) {
      // Re-trigger plays the sound again even if currently playing
      if (_player.state == PlayerState.playing) {
        await _player.stop();
      }
      await _player.play(AssetSource('sounds/click.mp3'));
    }
  }

  static Future<void> playComplete() async {
    if (PrefsService.soundEnabled) {
      if (_player.state == PlayerState.playing) {
        await _player.stop();
      }
      await _player.play(AssetSource('sounds/click.mp3')); // Using the same sound for now, can swap later
    }
  }
}
