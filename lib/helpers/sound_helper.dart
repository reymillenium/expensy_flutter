// Packages:
// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

// Helpers:

// Utilities:

class SoundHelper {
  final AudioCache player = AudioCache(prefix: 'assets/audio/');

  // Plays a click sound:
  void playSmallButtonClick({double volume = 1.00}) {
    playNote(fileName: 'zapsplat_multimedia_notification_pop_message_tooltip_small_click_007_63077.mp3', volume: volume);
  }

  // Plays a sound from a given file name and the volume:
  void playNote({String fileName, double volume = 1.00}) {
    player.play(fileName, volume: volume);
  }
}
