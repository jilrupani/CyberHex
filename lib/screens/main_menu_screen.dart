import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/game_models.dart';
import '../models/levels_data.dart';
import '../theme/cyber_theme.dart';
import '../utils/game_storage.dart';
import 'game_screen.dart';
import 'shop_screen.dart';
import 'onboarding_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> with SingleTickerProviderStateMixin {
  late AnimationController _titleController;
  int _credits = 0;
  int _unlockedLevel = 1;

  @override
  void initState() {
    super.initState();
    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _loadProgress();
  }

  void _loadProgress() {
    setState(() {
      _credits = GameStorage.getCredits();
      _unlockedLevel = GameStorage.getUnlockedLevel();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final levels = LevelsData.getLevels();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: CyberTheme.bgGradient,
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
                        const Text(
                          "v1.0.0 // ACTIVE",
                          style: CyberTheme.terminalMuted,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                HapticFeedback.selectionClick();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OnboardingScreen(isReplay: true),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: CyberTheme.cardBackground,
                                  border: Border.all(color: CyberTheme.primaryCyan, width: 1.5),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: CyberTheme.neonGlow(CyberTheme.primaryCyan, blurRadius: 4),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.help_outline, color: CyberTheme.primaryCyan, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      "INFO",
                                      style: TextStyle(
                                        color: CyberTheme.primaryCyan,
                                        fontFamily: 'Courier',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                HapticFeedback.selectionClick();
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
                                      "$_credits DATA",
                                      style: const TextStyle(
                                        color: CyberTheme.successGreen,
                                        fontFamily: 'Courier',
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
                      ],
                    ),
                    const Spacer(flex: 1),
                    
                    // Main Logo
                    AnimatedBuilder(
                      animation: _titleController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: 0.8 + 0.2 * sin(_titleController.value * pi * 2),
                          child: child,
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: CyberTheme.primaryCyan, width: 2),
                              boxShadow: CyberTheme.neonGlow(CyberTheme.primaryCyan, blurRadius: 10),
                            ),
                            child: const Icon(
                              Icons.security,
                              color: CyberTheme.primaryCyan,
                              size: 48,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "CYBERHEX",
                            style: TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 6.0,
                              shadows: [
                                Shadow(color: CyberTheme.primaryCyan, blurRadius: 12),
                              ],
                            ),
                          ),
                          const Text(
                            "NODE_HACKER_MAINFRAME",
                            style: TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 12,
                              color: CyberTheme.secondaryMagenta,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const Spacer(flex: 1),
                    
                    // Levels dashboard list
                    const Text(
                      "SELECT TARGET NODE NETWORK:",
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
                                    HapticFeedback.mediumImpact();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GameScreen(level: level),
                                      ),
                                    ).then((_) => _loadProgress());
                                  }
                                : () {
                                    HapticFeedback.vibrate();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "NODE NETWORK ENCRYPTED. COMPLETE PREVIOUS STAGES.",
                                          style: TextStyle(fontFamily: 'Courier', color: CyberTheme.errorRed),
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
                                            fontFamily: 'Courier',
                                            fontWeight: FontWeight.bold,
                                            color: isUnlocked ? Colors.white : Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          level.codeName,
                                          style: TextStyle(
                                            fontFamily: 'Courier',
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
                        HapticFeedback.heavyImpact();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: CyberTheme.cardBackground,
                            title: const Text("PURGE ALL DATA?", style: TextStyle(color: CyberTheme.errorRed, fontFamily: 'Courier')),
                            content: const Text(
                              "WARNING: This will wipe all system credits and unlocked configurations permanently.",
                              style: TextStyle(color: Colors.white, fontFamily: 'Courier'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("CANCEL", style: TextStyle(color: Colors.white, fontFamily: 'Courier')),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await GameStorage.resetProgress();
                                  Navigator.pop(context);
                                  _loadProgress();
                                },
                                child: const Text("PURGE", style: TextStyle(color: CyberTheme.errorRed, fontFamily: 'Courier')),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text(
                        "// PURGE DATABASE PROGRESS",
                        style: TextStyle(
                          color: CyberTheme.errorRed,
                          fontFamily: 'Courier',
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
