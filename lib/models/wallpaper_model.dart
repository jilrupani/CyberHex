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
      name: 'Hexagon Cyber Mesh',
      description: 'Futuristic glass hexagon network with cyan and magenta glowing accents.',
      cost: 0,
      assetPath: 'assets/cyber_wallpaper_1.png',
      primaryColor: Color(0xFF00FFCC),
      accentColor: Color(0xFFFF007F),
      gradientColors: [Color(0xFF0B0E20), Color(0xFF05060C)],
    ),
    CyberWallpaper(
      id: 'neon_magenta',
      name: 'Quantum CPU Mainframe',
      description: 'Ultra-high-tech processor chips with golden illuminated core and circuit traces.',
      cost: 200,
      assetPath: 'assets/cyber_wallpaper_2.png',
      primaryColor: Color(0xFFFFB700),
      accentColor: Color(0xFF00B3FF),
      gradientColors: [Color(0xFF1E1405), Color(0xFF0A0702)],
    ),
    CyberWallpaper(
      id: 'emerald_code',
      name: 'Golden Core Microchip',
      description: 'Macro sci-fi golden microchip processor with teal glowing bus lanes.',
      cost: 350,
      assetPath: 'assets/cyber_wallpaper_3.png',
      primaryColor: Color(0xFFFF007F),
      accentColor: Color(0xFF00FFCC),
      gradientColors: [Color(0xFF1B1105), Color(0xFF080401)],
    ),
    CyberWallpaper(
      id: 'amber_alert',
      name: 'Global Data Network',
      description: 'Holographic cyber earth digital stream with data nodes and global telemetry.',
      cost: 500,
      assetPath: 'assets/cyber_wallpaper_4.png',
      primaryColor: Color(0xFF00B3FF),
      accentColor: Color(0xFF39FF14),
      gradientColors: [Color(0xFF051320), Color(0xFF02070C)],
    ),
    CyberWallpaper(
      id: 'abyss_void',
      name: 'Security Matrix Vault',
      description: 'Cryptographic green encrypted security padlock matrix with code vortex.',
      cost: 750,
      assetPath: 'assets/cyber_wallpaper_5.png',
      primaryColor: Color(0xFF39FF14),
      accentColor: Color(0xFF00FF66),
      gradientColors: [Color(0xFF051B0D), Color(0xFF020904)],
    ),
  ];

  static CyberWallpaper getById(String id) {
    return availableWallpapers.firstWhere(
      (wp) => wp.id == id,
      orElse: () => availableWallpapers.first,
    );
  }
}
