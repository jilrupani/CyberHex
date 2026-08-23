import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'game_storage.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;

  AudioManager._internal();

  final AudioPlayer _bgmPlayer = AudioPlayer();
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;
    
    // Set loop mode so the background music loops infinitely
    await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
    _isInitialized = true;

    // Start playing BGM if music is enabled in settings
    if (GameStorage.getMusicEnabled()) {
      await playBgm();
    }
  }

  Future<void> playBgm() async {
    try {
      if (!_isInitialized) {
        await init();
      }
      // AudioPlayers 6.x: AssetSource references files relative to the assets/ folder.
      // E.g. AssetSource('cyber_bgm.wav') plays 'assets/cyber_bgm.wav'.
      await _bgmPlayer.play(AssetSource('cyber_bgm.wav'));
    } catch (e) {
      debugPrint("Error playing background music: $e");
    }
  }

  Future<void> stopBgm() async {
    try {
      await _bgmPlayer.stop();
    } catch (e) {
      debugPrint("Error stopping background music: $e");
    }
  }

  Future<void> setMusicEnabled(bool enabled) async {
    await GameStorage.setMusicEnabled(enabled);
    if (enabled) {
      await playBgm();
    } else {
      await stopBgm();
    }
  }
}
