import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'game_storage.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;

  AudioManager._internal();

  final AudioPlayer _bgmPlayer = AudioPlayer();
  bool _isInitialized = false;
  StreamSubscription<Duration>? _positionSubscription;

  Future<void> init() async {
    if (_isInitialized) return;
    
    // Set loop mode so the background music loops
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
      await _bgmPlayer.play(AssetSource('the_mountain-silent-hope-143298.mp3'));

      // Listen for position updates to reset every 10 seconds
      await _positionSubscription?.cancel();
      _positionSubscription = _bgmPlayer.onPositionChanged.listen((position) {
        if (position >= const Duration(seconds: 10)) {
          _bgmPlayer.seek(Duration.zero);
        }
      });
    } catch (e) {
      debugPrint("Error playing background music: $e");
    }
  }

  Future<void> stopBgm() async {
    try {
      await _positionSubscription?.cancel();
      _positionSubscription = null;
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
