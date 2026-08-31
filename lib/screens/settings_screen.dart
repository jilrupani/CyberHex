import 'package:flutter/material.dart';
import '../theme/cyber_theme.dart';
import '../utils/app_strings.dart';
import '../utils/audio_manager.dart';
import '../utils/game_storage.dart';
import 'rules_screen.dart';
import 'select_language_screen.dart';

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
    AppStrings.languageNotifier.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    AppStrings.languageNotifier.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _toggleMusic(bool value) async {
    setState(() {
      _musicEnabled = value;
    });
    await AudioManager().setMusicEnabled(value);
  }

  @override
  Widget build(BuildContext context) {
    final activeWallpaperId = GameStorage.getSelectedWallpaper();
    final activeThemeColor = CyberTheme.getWallpaperPrimaryColor(activeWallpaperId);
    final currentLang = AppStrings.supportedLanguages.firstWhere(
      (l) => l.code == AppStrings.currentLanguage,
      orElse: () => AppStrings.supportedLanguages.first,
    );

    return Scaffold(
      backgroundColor: CyberTheme.background,
      body: Container(
        decoration: CyberTheme.getWallpaperDecoration(activeWallpaperId),
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
                          icon: Icon(Icons.arrow_back, color: activeThemeColor),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppStrings.systemSettings,
                          style: CyberTheme.terminalTitle.copyWith(fontSize: 20, color: activeThemeColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Category 1: Language Settings
                    Text(
                      AppStrings.languageSettings,
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
                                builder: (context) => const SelectLanguageScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFF161B30),
                                    border: Border.all(color: activeThemeColor.withOpacity(0.5)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      currentLang.flagEmoji,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.appLanguage,
                                        style: CyberTheme.terminalBody.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "${currentLang.nativeName} (${currentLang.englishName})",
                                        style: CyberTheme.terminalMuted.copyWith(fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios, color: activeThemeColor, size: 14),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Category 2: Sound Settings
                    Text(
                      AppStrings.audioConfigurations,
                      style: CyberTheme.terminalAccent.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: CyberTheme.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _musicEnabled ? activeThemeColor.withOpacity(0.4) : const Color(0xFF1F2438),
                          width: 1.5,
                        ),
                        boxShadow: _musicEnabled
                            ? [
                                BoxShadow(
                                  color: activeThemeColor.withOpacity(0.1),
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
                              color: _musicEnabled ? activeThemeColor : const Color(0xFF6B728E),
                              size: 24,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.backgroundMusic,
                                    style: CyberTheme.terminalBody.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    AppStrings.audioSubtitle,
                                    style: CyberTheme.terminalMuted.copyWith(fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: _musicEnabled,
                              onChanged: _toggleMusic,
                              activeThumbColor: activeThemeColor,
                              activeTrackColor: activeThemeColor.withOpacity(0.3),
                              inactiveThumbColor: const Color(0xFF6B728E),
                              inactiveTrackColor: const Color(0xFF16192B),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Category 3: Hacking Database
                    Text(
                      AppStrings.hackingDatabaseRef,
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
                                Icon(Icons.menu_book, color: activeThemeColor, size: 24),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.systemRulesTitle,
                                        style: CyberTheme.terminalBody.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        AppStrings.systemRulesSubtitle,
                                        style: CyberTheme.terminalMuted.copyWith(fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios, color: activeThemeColor, size: 14),
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
