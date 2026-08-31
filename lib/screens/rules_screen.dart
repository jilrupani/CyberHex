import 'package:flutter/material.dart';
import '../theme/cyber_theme.dart';
import '../utils/app_strings.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

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
            // Grid background lines
            Positioned.fill(
              child: Opacity(
                opacity: 0.08,
                child: CustomPaint(
                  painter: GridPatternPainter(),
                ),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Bar
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: CyberTheme.primaryCyan),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppStrings.hackingProtocols,
                          style: CyberTheme.terminalTitle.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Scrollable Rule Sheets
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildSectionHeader(AppStrings.rulesHeader01),
                            _buildInfoCard(
                              title: AppStrings.rulesCard1Title,
                              description: AppStrings.rulesCard1Desc,
                            ),
                            const SizedBox(height: 12),
                            _buildInfoCard(
                              title: AppStrings.rulesCard2Title,
                              description: AppStrings.rulesCard2Desc,
                            ),

                            const SizedBox(height: 24),
                            _buildSectionHeader(AppStrings.rulesHeader02),
                            Text(
                              AppStrings.rulesSection2Subtitle,
                              style: CyberTheme.terminalMuted,
                            ),
                            const SizedBox(height: 12),

                            _buildNodeDirectoryItem(
                              color: CyberTheme.primaryCyan,
                              title: AppStrings.nodeCyanTitle,
                              badgeText: AppStrings.nodeCyanBadge,
                              description: AppStrings.nodeCyanDesc,
                              iconWidget: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CyberTheme.primaryCyan,
                                  boxShadow: CyberTheme.neonGlow(CyberTheme.primaryCyan, blurRadius: 4),
                                ),
                                child: const Icon(Icons.close, color: Colors.black, size: 16),
                              ),
                            ),
                            _buildNodeDirectoryItem(
                              color: CyberTheme.successGreen,
                              title: AppStrings.nodeGreenTitle,
                              badgeText: AppStrings.nodeGreenBadge,
                              description: AppStrings.nodeGreenDesc,
                              iconWidget: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CyberTheme.successGreen,
                                  boxShadow: CyberTheme.neonGlow(CyberTheme.successGreen, blurRadius: 4),
                                ),
                                child: Center(
                                  child: Text(AppStrings.nodeGreenBadge, style: const TextStyle(color: Colors.black, fontSize: 7, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            _buildNodeDirectoryItem(
                              color: CyberTheme.errorRed,
                              title: AppStrings.nodeRedTitle,
                              badgeText: AppStrings.nodeRedBadge,
                              description: AppStrings.nodeRedDesc,
                              iconWidget: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                  border: Border.all(color: CyberTheme.errorRed, width: 2),
                                  boxShadow: CyberTheme.neonGlow(CyberTheme.errorRed, blurRadius: 4),
                                ),
                                child: const Icon(Icons.warning_amber_rounded, color: CyberTheme.errorRed, size: 16),
                              ),
                            ),
                            _buildNodeDirectoryItem(
                              color: CyberTheme.secondaryMagenta,
                              title: AppStrings.nodeMagentaTitle,
                              badgeText: AppStrings.nodeMagentaBadge,
                              description: AppStrings.nodeMagentaDesc,
                              iconWidget: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                  border: Border.all(color: CyberTheme.secondaryMagenta, width: 2.5),
                                  boxShadow: CyberTheme.neonGlow(CyberTheme.secondaryMagenta, blurRadius: 4),
                                ),
                                child: const Icon(Icons.vpn_key, color: CyberTheme.secondaryMagenta, size: 14),
                              ),
                            ),
                            _buildNodeDirectoryItem(
                              color: CyberTheme.accentAmber,
                              title: AppStrings.nodeAmberTitle,
                              badgeText: AppStrings.nodeAmberBadge,
                              description: AppStrings.nodeAmberDesc,
                              iconWidget: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CyberTheme.accentAmber,
                                  boxShadow: CyberTheme.neonGlow(CyberTheme.accentAmber, blurRadius: 4),
                                ),
                                child: const Icon(Icons.remove_red_eye_outlined, color: Colors.black, size: 14),
                              ),
                            ),

                            const SizedBox(height: 24),
                            _buildSectionHeader(AppStrings.rulesHeader03),
                            _buildInfoCard(
                              title: AppStrings.rulesSection3Card1Title,
                              description: AppStrings.rulesSection3Card1Desc,
                            ),
                            const SizedBox(height: 12),
                            _buildInfoCard(
                              title: AppStrings.rulesSection3Card2Title,
                              description: AppStrings.rulesSection3Card2Desc,
                            ),
                            const SizedBox(height: 24),
                          ],
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CyberTheme.terminalAccent.copyWith(letterSpacing: 2.0, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Container(
            height: 2,
            color: CyberTheme.secondaryMagenta,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String description}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CyberTheme.cardBackground,
        border: Border.all(color: const Color(0xFF1F2438), width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CyberTheme.terminalBody.copyWith(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: CyberTheme.terminalBody.copyWith(fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildNodeDirectoryItem({
    required Color color,
    required String title,
    required String badgeText,
    required String description,
    required Widget iconWidget,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CyberTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1F2438)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          iconWidget,
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: CyberTheme.terminalBody.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        border: Border.all(color: color, width: 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        badgeText,
                        style: TextStyle(
                          color: color,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: CyberTheme.terminalMuted.copyWith(fontSize: 11, height: 1.4),
                ),
              ],
            ),
          ),
        ],
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
