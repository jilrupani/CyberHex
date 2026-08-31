import 'package:flutter/material.dart';
import '../theme/cyber_theme.dart';
import '../utils/app_strings.dart';
import '../utils/game_storage.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  late String _selectedCode;
  String _activeWallpaperId = 'matrix_cyan';

  @override
  void initState() {
    super.initState();
    _selectedCode = AppStrings.currentLanguage;
    _activeWallpaperId = GameStorage.getSelectedWallpaper();
  }

  void _onSaveLanguage() async {
    await AppStrings.changeLanguage(_selectedCode);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeThemeColor = CyberTheme.getWallpaperPrimaryColor(_activeWallpaperId);
    final languages = AppStrings.supportedLanguages;

    return Scaffold(
      backgroundColor: CyberTheme.background,
      body: Container(
        decoration: CyberTheme.getWallpaperDecoration(_activeWallpaperId),
        child: Stack(
          children: [
            // Ambient Hex Grid lines
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: CustomPaint(
                  painter: SelectLangGridPainter(),
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
                        Expanded(
                          child: Text(
                            AppStrings.selectLanguageTitle,
                            style: CyberTheme.terminalTitle.copyWith(
                              fontSize: 22,
                              color: activeThemeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        AppStrings.selectLanguageDesc,
                        style: CyberTheme.terminalMuted.copyWith(fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Language List
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: languages.length,
                        itemBuilder: (context, index) {
                          final lang = languages[index];
                          final isSelected = lang.code == _selectedCode;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCode = lang.code;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? CyberTheme.cardBackground
                                    : CyberTheme.cardBackground.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected ? activeThemeColor : const Color(0xFF1F2438),
                                  width: isSelected ? 2.0 : 1.5,
                                ),
                                boxShadow: isSelected
                                    ? CyberTheme.neonGlow(activeThemeColor, blurRadius: 8)
                                    : [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 6,
                                          spreadRadius: 1,
                                        ),
                                      ],
                              ),
                              child: Row(
                                children: [
                                  // Flag Icon Circle Badge
                                  Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF161B30),
                                      border: Border.all(
                                        color: isSelected ? activeThemeColor : const Color(0xFF2E3859),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        lang.flagEmoji,
                                        style: const TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),

                                  // Language Names
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang.nativeName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: isSelected ? Colors.white : Colors.white70,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          lang.englishName,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: isSelected
                                                ? CyberTheme.secondaryMagenta
                                                : Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Radio selection indicator
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected ? activeThemeColor : const Color(0xFF4A5578),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: isSelected
                                        ? Center(
                                            child: Container(
                                              width: 12,
                                              height: 12,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: activeThemeColor,
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Continue Action Button
                    GestureDetector(
                      onTap: _onSaveLanguage,
                      child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          color: CyberTheme.cardBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: activeThemeColor, width: 2),
                          boxShadow: CyberTheme.neonGlow(activeThemeColor, blurRadius: 10),
                        ),
                        child: Center(
                          child: Text(
                            AppStrings.continueBtn,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: activeThemeColor,
                              letterSpacing: 1.5,
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

class SelectLangGridPainter extends CustomPainter {
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
