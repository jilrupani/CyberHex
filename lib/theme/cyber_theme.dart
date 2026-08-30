import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/wallpaper_model.dart';

class CyberTheme {
  // Brand Colors
  static const Color background = Color(0xFF070913);
  static const Color cardBackground = Color(0xFF101426);
  static const Color primaryCyan = Color(0xFF00FFCC);
  static const Color secondaryMagenta = Color(0xFFFF007F);
  static const Color accentAmber = Color(0xFFFFB700);
  static const Color successGreen = Color(0xFF39FF14);
  static const Color errorRed = Color(0xFFFF3333);
  static const Color terminalGreen = Color(0xFF00FF66);
  
  // Muted/Glow Colors
  static Color primaryGlow = primaryCyan.withOpacity(0.4);
  static Color secondaryGlow = secondaryMagenta.withOpacity(0.4);
  
  // Dynamic Background Decoration Helper
  static BoxDecoration getWallpaperDecoration(String wallpaperId) {
    final wp = CyberWallpaper.getById(wallpaperId);
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: wp.gradientColors,
      ),
      image: DecorationImage(
        image: AssetImage(wp.assetPath),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.72),
          BlendMode.darken,
        ),
      ),
    );
  }

  static Color getWallpaperPrimaryColor(String wallpaperId) {
    return CyberWallpaper.getById(wallpaperId).primaryColor;
  }

  // Gradients
  static const LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0B0E20),
      Color(0xFF05060C),
    ],
  );

  static const LinearGradient cyberCyanGradient = LinearGradient(
    colors: [Color(0xFF00FFCC), Color(0xFF00B3FF)],
  );

  static const LinearGradient cyberPinkGradient = LinearGradient(
    colors: [Color(0xFFFF007F), Color(0xFF8000FF)],
  );

  // Box Shadows for Neon Glow
  static List<BoxShadow> neonGlow(Color color, {double blurRadius = 8.0, double spreadRadius = 1.0}) {
    return [
      BoxShadow(
        color: color.withOpacity(0.6),
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ),
      BoxShadow(
        color: color.withOpacity(0.2),
        blurRadius: blurRadius * 2,
        spreadRadius: spreadRadius * 1.5,
      ),
    ];
  }

  // Text Styles
  static TextStyle get terminalTitle => GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: primaryCyan,
    letterSpacing: 1.5,
    shadows: const [
      Shadow(
        color: primaryCyan,
        blurRadius: 10,
      ),
    ],
  );

  static TextStyle get terminalBody => GoogleFonts.poppins(
    fontSize: 13,
    color: const Color(0xFFD0D7F2),
    letterSpacing: 0.5,
  );

  static TextStyle get terminalAccent => GoogleFonts.poppins(
    fontSize: 13,
    color: secondaryMagenta,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );

  static TextStyle get terminalMuted => GoogleFonts.poppins(
    fontSize: 11,
    color: const Color(0xFF6B728E),
    letterSpacing: 0.3,
  );
}
