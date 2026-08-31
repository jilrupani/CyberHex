import 'package:flutter/material.dart';
import '../theme/cyber_theme.dart';
import '../utils/app_strings.dart';
import '../utils/game_storage.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  Color _themeColor = CyberTheme.primaryCyan;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final wallpaperId = await GameStorage.getSelectedWallpaper();
    setState(() {
      _themeColor = CyberTheme.getWallpaperPrimaryColor(wallpaperId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Cyber wallpaper background
          Positioned.fill(
            child: Image.asset(
              'assets/cyber_wallpaper.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFF0A0A10)),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.82),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top Header Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: _themeColor),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.privacyPolicy,
                        style: CyberTheme.terminalTitle.copyWith(fontSize: 20, color: _themeColor),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildCard(
                          title: "1. Data Collection & Encryption",
                          content:
                              "CyberHex operates on local node memory. We collect minimal telemetry such as user ratings and optional feedback submissions to improve system gameplay performance. Personal sensitive data is never gathered without consent.",
                        ),
                        const SizedBox(height: 14),
                        _buildCard(
                          title: "2. Firebase & Cloud Firestore Usage",
                          content:
                              "When submitting user feedback or bug reports, data is transmitted to secured Cloud Firestore servers under strict encryption protocols. The collected data is strictly utilized for debugging and network enhancement.",
                        ),
                        const SizedBox(height: 14),
                        _buildCard(
                          title: "3. Third-Party Links & Services",
                          content:
                              "The application may include options to rate us via official application store links (Google Play Store). We encourage users to review third-party privacy statements when navigating externally.",
                        ),
                        const SizedBox(height: 14),
                        _buildCard(
                          title: "4. User Rights & Data Protection",
                          content:
                              "You retain full authority to purge your saved local progress, credits, and unlocked configurations anytime from the System Settings menu.",
                        ),
                        const SizedBox(height: 14),
                        _buildCard(
                          title: "5. Contact & Inquiries",
                          content:
                              "For security queries or feedback regarding our privacy practices, transmit your message via the Feedback Terminal in the Settings menu.",
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required String content}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CyberTheme.cardBackground.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _themeColor.withOpacity(0.4), width: 1.5),
        boxShadow: CyberTheme.neonGlow(_themeColor, blurRadius: 4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: _themeColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
