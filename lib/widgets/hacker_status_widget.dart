import 'package:flutter/material.dart';
import '../theme/cyber_theme.dart';
import '../models/wallpaper_model.dart';

class HackerStatusWidget extends StatelessWidget {
  final int unlockedLevel;
  final int credits;
  final String activeWallpaperId;
  final Color themeColor;

  const HackerStatusWidget({
    super.key,
    required this.unlockedLevel,
    required this.credits,
    required this.activeWallpaperId,
    required this.themeColor,
  });

  String _getRankTitle(int level) {
    if (level >= 8) return "Legendary Netrunner";
    if (level >= 6) return "Ghost Syndicate Lead";
    if (level >= 4) return "Cyber Operative";
    if (level >= 2) return "Node Breaker";
    return "Script Kiddie";
  }

  @override
  Widget build(BuildContext context) {
    final rank = _getRankTitle(unlockedLevel);
    final activeThemeName = CyberWallpaper.getById(activeWallpaperId).name;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CyberTheme.cardBackground.withOpacity(0.9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: themeColor.withOpacity(0.4),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: themeColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: themeColor.withOpacity(0.5)),
            ),
            child: Icon(
              Icons.security,
              color: themeColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rank,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: themeColor,
                      ),
                    ),
                    Text(
                      "Clearance Lvl $unlockedLevel",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  "Theme: $activeThemeName",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
