import 'package:flutter/material.dart';
import '../models/levels_data.dart';
import '../theme/cyber_theme.dart';
import '../utils/game_storage.dart';
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

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  void _loadProgress() {
    setState(() {
      _credits = GameStorage.getCredits();
      _unlockedLevel = GameStorage.getUnlockedLevel();
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


  @override
  Widget build(BuildContext context) {
    final levels = LevelsData.getLevels();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: CyberTheme.bgGradient,
          image: DecorationImage(
            image: const AssetImage('assets/cyber_wallpaper.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.72),
              BlendMode.darken,
            ),
          ),
        ),
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
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: CyberTheme.cardBackground,
                              border: Border.all(color: CyberTheme.primaryCyan, width: 1.5),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: CyberTheme.neonGlow(CyberTheme.primaryCyan, blurRadius: 4),
                            ),
                            child: const Icon(
                              Icons.settings,
                              color: CyberTheme.primaryCyan,
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
                                  "$_credits Data",
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
                    const SizedBox(height: 24),
                    
                    // Levels dashboard list
                    Text(
                      "Select Target Node Network:",
                      style: CyberTheme.terminalAccent,
                    ),
                    const SizedBox(height: 12),
                    
                    Expanded(
                      flex: 4,
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
                                  color: isUnlocked ? CyberTheme.primaryCyan : Colors.grey.shade800,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: isUnlocked ? CyberTheme.neonGlow(CyberTheme.primaryCyan, blurRadius: 4) : null,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isUnlocked ? Icons.wifi_find : Icons.lock_outline,
                                    color: isUnlocked ? CyberTheme.primaryCyan : Colors.grey,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          level.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isUnlocked ? Colors.white : Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          _formatCodeName(level.codeName),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: isUnlocked ? CyberTheme.secondaryMagenta : Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isUnlocked)
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: CyberTheme.primaryCyan,
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
                            title: const Text("Purge all data?", style: TextStyle(color: CyberTheme.errorRed)),
                            content: const Text(
                              "Warning: This will wipe all system credits and unlocked configurations permanently.",
                              style: TextStyle(color: Colors.white),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await GameStorage.resetProgress();
                                  Navigator.pop(context);
                                  _loadProgress();
                                },
                                child: const Text("Purge", style: TextStyle(color: CyberTheme.errorRed)),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text(
                        "Purge Database Progress",
                        style: TextStyle(
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
