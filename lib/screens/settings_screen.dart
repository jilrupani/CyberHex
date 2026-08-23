import 'package:flutter/material.dart';
import '../theme/cyber_theme.dart';
import 'rules_screen.dart';
import '../utils/game_storage.dart';
import '../utils/audio_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _musicEnabled = true;

  @override
  void initState() {
    super.initState();
    _musicEnabled = GameStorage.getMusicEnabled();
  }

  void _toggleMusic(bool value) async {
    setState(() {
      _musicEnabled = value;
    });
    await AudioManager().setMusicEnabled(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CyberTheme.background,
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
            // Ambient Hex Grid lines
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: CustomPaint(
                  painter: GridPatternPainter(),
                ),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: CyberTheme.primaryCyan),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "System Settings",
                          style: CyberTheme.terminalTitle.copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Category 1: Sound Settings
                    Text(
                      "Audio Configurations",
                      style: CyberTheme.terminalAccent.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: CyberTheme.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _musicEnabled ? CyberTheme.primaryCyan.withOpacity(0.4) : const Color(0xFF1F2438),
                          width: 1.5
                        ),
                        boxShadow: _musicEnabled
                            ? [
                                BoxShadow(
                                  color: CyberTheme.primaryCyan.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                )
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                )
                              ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        child: Row(
                          children: [
                            Icon(
                              _musicEnabled ? Icons.music_note : Icons.music_off,
                              color: _musicEnabled ? CyberTheme.primaryCyan : const Color(0xFF6B728E),
                              size: 24
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Background Music",
                                    style: CyberTheme.terminalBody.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Ambient sci-fi cyber sound loops",
                                    style: CyberTheme.terminalMuted.copyWith(fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: _musicEnabled,
                              onChanged: _toggleMusic,
                              activeThumbColor: CyberTheme.primaryCyan,
                              activeTrackColor: CyberTheme.primaryCyan.withOpacity(0.3),
                              inactiveThumbColor: const Color(0xFF6B728E),
                              inactiveTrackColor: const Color(0xFF16192B),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Category 2: Hacking Database
                    Text(
                      "Hacking Database & Reference",
                      style: CyberTheme.terminalAccent.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: CyberTheme.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF1F2438), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RulesScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                            child: Row(
                              children: [
                                const Icon(Icons.menu_book, color: CyberTheme.primaryCyan, size: 24),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "System Rules & Hacking Guide",
                                        style: CyberTheme.terminalBody.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Objective, Node types, colors and stages",
                                        style: CyberTheme.terminalMuted.copyWith(fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios, color: CyberTheme.primaryCyan, size: 14),
                              ],
                            ),
                          ),
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

class GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1B223F)
      ..strokeWidth = 1.0;

    const step = 30.0;
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
