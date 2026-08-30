import 'package:flutter/material.dart';

class CyberWallpaper {
  final String id;
  final String name;
  final String description;
  final int cost;
  final String assetPath;
  final Color primaryColor;
  final Color accentColor;
  final List<Color> gradientColors;

  const CyberWallpaper({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.assetPath,
    required this.primaryColor,
    required this.accentColor,
    required this.gradientColors,
  });

  static const List<CyberWallpaper> availableWallpapers = [
    CyberWallpaper(
      id: 'matrix_cyan',
      name: 'Matrix Cyan Grid',
      description: 'Classic cyberpunk glowing cyan grid texture.',
      cost: 0,
      assetPath: 'assets/cyber_wallpaper.png',
      primaryColor: Color(0xFF00FFCC),
      accentColor: Color(0xFF00B3FF),
      gradientColors: [Color(0xFF0B0E20), Color(0xFF05060C)],
    ),
    CyberWallpaper(
      id: 'neon_magenta',
      name: 'Neon Magenta Syndicate',
      description: 'Vibrant neon magenta and synthwave violet atmosphere.',
      cost: 200,
      assetPath: 'assets/cyber_wallpaper.png',
      primaryColor: Color(0xFFFF007F),
      accentColor: Color(0xFF8000FF),
      gradientColors: [Color(0xFF1E051A), Color(0xFF0A020E)],
    ),
    CyberWallpaper(
      id: 'emerald_code',
      name: 'Emerald Security Grid',
      description: 'Terminal hacker green matrix code aesthetic.',
      cost: 350,
      assetPath: 'assets/cyber_wallpaper.png',
      primaryColor: Color(0xFF39FF14),
      accentColor: Color(0xFF00FF66),
      gradientColors: [Color(0xFF051B0D), Color(0xFF020904)],
    ),
    CyberWallpaper(
      id: 'amber_alert',
      name: 'Amber Warning Protocol',
      description: 'High-threat tactical alert amber interface.',
      cost: 500,
      assetPath: 'assets/cyber_wallpaper.png',
      primaryColor: Color(0xFFFFB700),
      accentColor: Color(0xFFFF5500),
      gradientColors: [Color(0xFF201305), Color(0xFF0C0702)],
    ),
    CyberWallpaper(
      id: 'abyss_void',
      name: 'Deep Abyss Void',
      description: 'Stealth black ultra-minimalist cyber theme.',
      cost: 750,
      assetPath: 'assets/cyber_wallpaper.png',
      primaryColor: Color(0xFF90A4AE),
      accentColor: Color(0xFF00FFCC),
      gradientColors: [Color(0xFF08090D), Color(0xFF020204)],
    ),
  ];

  static CyberWallpaper getById(String id) {
    return availableWallpapers.firstWhere(
      (wp) => wp.id == id,
      orElse: () => availableWallpapers.first,
    );
  }
}
