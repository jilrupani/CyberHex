import 'package:shared_preferences/shared_preferences.dart';

class GameStorage {
  static SharedPreferences? _prefs;

  static const String _keyCredits = 'cyberhex_credits';
  static const String _keyUnlockedLevel = 'cyberhex_unlocked_level';
  static const String _keyUpgradePrefix = 'cyberhex_upgrade_';
  static const String _keyOnboardingCompleted = 'cyberhex_onboarding_completed';
  static const String _keyMusicEnabled = 'cyberhex_music_enabled';
  static const String _keyLanguage = 'cyberhex_language';

  static String getLanguage() {
    return _prefs?.getString(_keyLanguage) ?? 'en';
  }

  static Future<void> setLanguage(String langCode) async {
    await _prefs?.setString(_keyLanguage, langCode);
  }

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool getOnboardingCompleted() {
    return _prefs?.getBool(_keyOnboardingCompleted) ?? false;
  }

  static Future<void> setOnboardingCompleted(bool value) async {
    await _prefs?.setBool(_keyOnboardingCompleted, value);
  }

  static bool getMusicEnabled() {
    return _prefs?.getBool(_keyMusicEnabled) ?? true;
  }

  static Future<void> setMusicEnabled(bool value) async {
    await _prefs?.setBool(_keyMusicEnabled, value);
  }

  static int getCredits() {
    return _prefs?.getInt(_keyCredits) ?? 0;
  }

  static Future<void> addCredits(int amount) async {
    final current = getCredits();
    await _prefs?.setInt(_keyCredits, current + amount);
  }

  static Future<void> setCredits(int amount) async {
    await _prefs?.setInt(_keyCredits, amount);
  }

  static int getUnlockedLevel() {
    return _prefs?.getInt(_keyUnlockedLevel) ?? 1;
  }

  static Future<void> unlockLevel(int levelId) async {
    final current = getUnlockedLevel();
    if (levelId > current) {
      await _prefs?.setInt(_keyUnlockedLevel, levelId);
    }
  }

  static int getUpgradeLevel(String upgradeId) {
    return _prefs?.getInt('$_keyUpgradePrefix$upgradeId') ?? 0;
  }

  static Future<void> setUpgradeLevel(String upgradeId, int level) async {
    await _prefs?.setInt('$_keyUpgradePrefix$upgradeId', level);
  }

  static const String _keySelectedWallpaper = 'cyberhex_selected_wallpaper';
  static const String _keyUnlockedWallpapers = 'cyberhex_unlocked_wallpapers';
  static const String _keyLastDailyReward = 'cyberhex_last_daily_reward';

  static String getSelectedWallpaper() {
    return _prefs?.getString(_keySelectedWallpaper) ?? 'matrix_cyan';
  }

  static Future<void> setSelectedWallpaper(String id) async {
    await _prefs?.setString(_keySelectedWallpaper, id);
  }

  static List<String> getUnlockedWallpapers() {
    final list = _prefs?.getStringList(_keyUnlockedWallpapers);
    if (list == null || list.isEmpty) {
      return ['matrix_cyan'];
    }
    return list;
  }

  static Future<void> unlockWallpaper(String id) async {
    final unlocked = getUnlockedWallpapers();
    if (!unlocked.contains(id)) {
      unlocked.add(id);
      await _prefs?.setStringList(_keyUnlockedWallpapers, unlocked);
    }
  }

  static int getLastDailyRewardTime() {
    return _prefs?.getInt(_keyLastDailyReward) ?? 0;
  }

  static Future<void> setLastDailyRewardTime(int timestamp) async {
    await _prefs?.setInt(_keyLastDailyReward, timestamp);
  }

  static bool isDailyRewardAvailable() {
    final lastTime = getLastDailyRewardTime();
    if (lastTime == 0) return true;
    final lastDate = DateTime.fromMillisecondsSinceEpoch(lastTime);
    final now = DateTime.now();
    return now.difference(lastDate).inHours >= 24;
  }

  static Future<void> resetProgress() async {
    await _prefs?.setInt(_keyCredits, 0);
    await _prefs?.setInt(_keyUnlockedLevel, 1);
    await _prefs?.setString(_keySelectedWallpaper, 'matrix_cyan');
    await _prefs?.setStringList(_keyUnlockedWallpapers, ['matrix_cyan']);
    await _prefs?.setInt(_keyLastDailyReward, 0);
    
    // Clear all upgrade keys
    final keys = _prefs?.getKeys() ?? {};
    for (var key in keys) {
      if (key.startsWith(_keyUpgradePrefix)) {
        await _prefs?.remove(key);
      }
    }
  }
}
