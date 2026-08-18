import 'package:shared_preferences/shared_preferences.dart';

class GameStorage {
  static SharedPreferences? _prefs;

  static const String _keyCredits = 'cyberhex_credits';
  static const String _keyUnlockedLevel = 'cyberhex_unlocked_level';
  static const String _keyUpgradePrefix = 'cyberhex_upgrade_';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
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

  static Future<void> resetProgress() async {
    await _prefs?.setInt(_keyCredits, 0);
    await _prefs?.setInt(_keyUnlockedLevel, 1);
    
    // Clear all upgrade keys
    final keys = _prefs?.getKeys() ?? {};
    for (var key in keys) {
      if (key.startsWith(_keyUpgradePrefix)) {
        await _prefs?.remove(key);
      }
    }
  }
}
