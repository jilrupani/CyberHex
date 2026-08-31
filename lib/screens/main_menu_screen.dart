import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/levels_data.dart';
import '../theme/cyber_theme.dart';
import '../utils/app_strings.dart';
import '../utils/game_storage.dart';
import '../widgets/daily_reward_widget.dart';
import '../widgets/hacker_status_widget.dart';
import 'game_screen.dart';
import 'shop_screen.dart';
import 'settings_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int _credits = 0;
  int _unlockedLevel = 1;
  String _activeWallpaperId = 'matrix_cyan';

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  void _loadProgress() {
    setState(() {
      _credits = GameStorage.getCredits();
      _unlockedLevel = GameStorage.getUnlockedLevel();
      _activeWallpaperId = GameStorage.getSelectedWallpaper();
    });
  }

  String _formatCodeName(String name) {
    return name.split('_').where((word) {
      return int.tryParse(word) == null;
    }).map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context, Color themeColor) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: CyberTheme.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: themeColor, width: 1.5),
        ),
        title: Row(
          children: [
            Icon(Icons.power_settings_new, color: themeColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                AppStrings.disconnectTitle,
                style: TextStyle(color: themeColor, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ],
        ),
        content: Text(
          AppStrings.disconnectDesc,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppStrings.cancel, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: themeColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(AppStrings.exitGame, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final levels = LevelsData.getLevels();
    final activeThemeColor = CyberTheme.getWallpaperPrimaryColor(_activeWallpaperId);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await _showExitConfirmationDialog(context, activeThemeColor);
        if (shouldExit) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
      body: Container(
        decoration: CyberTheme.getWallpaperDecoration(_activeWallpaperId),
        child: Stack(
          children: [
            // Cyber Grid Background Lines
            Positioned.fill(
              child: Opacity(
                opacity: 0.15,
                child: CustomPaint(
                  painter: GridBackgroundPainter(),
                ),
              ),
            ),
            
            // Main content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsScreen(),
                              ),
                            ).then((_) => _loadProgress());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: CyberTheme.cardBackground,
                              border: Border.all(color: activeThemeColor, width: 1.5),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: CyberTheme.neonGlow(activeThemeColor, blurRadius: 4),
                            ),
                            child: Icon(
                              Icons.settings,
                              color: activeThemeColor,
                              size: 20,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ShopScreen()),
                            ).then((_) => _loadProgress());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: CyberTheme.cardBackground,
                              border: Border.all(color: CyberTheme.successGreen, width: 1.5),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: CyberTheme.neonGlow(CyberTheme.successGreen, blurRadius: 4),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.analytics, color: CyberTheme.successGreen, size: 14),
                                const SizedBox(width: 6),
                                Text(
                                  "$_credits ${AppStrings.dataCredits}",
                                  style: const TextStyle(
                                    color: CyberTheme.successGreen,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Modular Widgets Section
                    HackerStatusWidget(
                      unlockedLevel: _unlockedLevel,
                      credits: _credits,
                      activeWallpaperId: _activeWallpaperId,
                      themeColor: activeThemeColor,
                    ),
                    const SizedBox(height: 10),
                    DailyRewardWidget(
                      onRewardClaimed: _loadProgress,
                      themeColor: activeThemeColor,
                    ),
                    const SizedBox(height: 16),
                    
                    // Levels dashboard list header
                    Text(
                      AppStrings.selectTargetNetwork,
                      style: CyberTheme.terminalAccent.copyWith(color: activeThemeColor),
                    ),
                    const SizedBox(height: 10),
                    
                    Expanded(
                      child: ListView.builder(
                        itemCount: levels.length,
                        itemBuilder: (context, index) {
                          final level = levels[index];
                          final isUnlocked = level.id <= _unlockedLevel;

                          return GestureDetector(
                            onTap: isUnlocked
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GameScreen(level: level),
                                      ),
                                    ).then((_) => _loadProgress());
                                  }
                                : () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Node network encrypted. Complete previous stages.",
                                          style: TextStyle(color: CyberTheme.errorRed),
                                        ),
                                        backgroundColor: CyberTheme.cardBackground,
                                      ),
                                    );
                                  },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isUnlocked ? CyberTheme.cardBackground : CyberTheme.cardBackground.withOpacity(0.4),
                                border: Border.all(
                                  color: isUnlocked ? activeThemeColor : Colors.grey.shade800,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: isUnlocked ? CyberTheme.neonGlow(activeThemeColor, blurRadius: 4) : null,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isUnlocked ? Icons.wifi_find : Icons.lock_outline,
                                    color: isUnlocked ? activeThemeColor : Colors.grey,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppStrings.stageLabel(level.id),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isUnlocked ? Colors.white : Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          AppStrings.translateCodeName(level.codeName),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: isUnlocked ? CyberTheme.secondaryMagenta : Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isUnlocked)
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: activeThemeColor,
                                      size: 16,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Reset Data Button (Bottom)
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: CyberTheme.cardBackground,
                            title: Text(AppStrings.purgeDataTitle, style: const TextStyle(color: CyberTheme.errorRed)),
                            content: Text(
                              AppStrings.purgeDataWarning,
                              style: const TextStyle(color: Colors.white),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(AppStrings.cancel, style: const TextStyle(color: Colors.white)),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await GameStorage.resetProgress();
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    _loadProgress();
                                  }
                                },
                                child: Text(AppStrings.purgeAction, style: const TextStyle(color: CyberTheme.errorRed)),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        AppStrings.purgeButton,
                        style: const TextStyle(
                          color: CyberTheme.errorRed,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}

// Background painter to paint cyber grid lines
class GridBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1B223F)
      ..strokeWidth = 1.0;

    const step = 40.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
