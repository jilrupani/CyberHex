import 'package:flutter/material.dart';
import '../theme/cyber_theme.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CyberTheme.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: CyberTheme.bgGradient,
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
                          "HACKING PROTOCOLS",
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
                            _buildSectionHeader("01. MISSION & GAMEPLAY OBJECTIVE"),
                            _buildInfoCard(
                              title: "What is CyberHex?",
                              description: "You play as an elite Node Hacker operating in the deep shadows. Your goal is to infiltrate high-security corporate node networks, breach their firewalls, harvest valuable data cores, and escape safely.",
                            ),
                            const SizedBox(height: 12),
                            _buildInfoCard(
                              title: "Step-by-Step Gameplay Flow",
                              description: "1. Select a Stage network target from the main menu.\n"
                                  "2. You start at the Start Node. The system highlights adjacent nodes that you can link to.\n"
                                  "3. Plan your route carefully: each node-to-node hop costs 1 MB of RAM.\n"
                                  "4. Capture Data Cores on the grid to accumulate credits.\n"
                                  "5. Evade patrol drones (moving along dotted lines) and avoid firewalls.\n"
                                  "6. Secure your escape by stepping on the magenta Extraction Port to complete the level.",
                            ),

                            const SizedBox(height: 24),
                            _buildSectionHeader("02. NODE & COLOR-WISE DIRECTORY"),
                            Text(
                              "Memorize the color codes to identify nodes instantly on the tactical map:",
                              style: CyberTheme.terminalMuted,
                            ),
                            const SizedBox(height: 12),

                            _buildNodeDirectoryItem(
                              color: CyberTheme.primaryCyan,
                              title: "Cyan Color (Hacker / Player Core)",
                              badgeText: "HACKER",
                              description: "Indicates your current active footprint in the network. A cyan target cursor showing where your system connection currently resides.",
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
                              title: "Green Color (Data Core)",
                              badgeText: "+DATA",
                              description: "Secured database containing system credits. Step on these green nodes to harvest their value (+50 to +300 Credits).",
                              iconWidget: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CyberTheme.successGreen,
                                  boxShadow: CyberTheme.neonGlow(CyberTheme.successGreen, blurRadius: 4),
                                ),
                                child: const Center(
                                  child: Text("+DATA", style: TextStyle(color: Colors.black, fontSize: 7, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            _buildNodeDirectoryItem(
                              color: CyberTheme.errorRed,
                              title: "Red Color (Firewall node)",
                              badgeText: "HAZARD",
                              description: "Secured corporate firewalls. Stepping on a red node instantly triggers alarm protocols, rising the Firewall Threat level by 25%.",
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
                              title: "Magenta Color (Extraction Port)",
                              badgeText: "ESCAPE",
                              description: "A concentric magenta gateway circle representing the network exit. Stepping here successfully extracts you and saves your credits.",
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
                              title: "Amber Color (Security Patrol Drone)",
                              badgeText: "AVOID",
                              description: "Patrolling node security system. Drones move along dotted amber lines each turn. If they crash into you, your connection is terminated.",
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
                            _buildSectionHeader("03. MAIN SETTINGS & STAGES DETAILS"),
                            _buildInfoCard(
                              title: "Total Game Stages (60 Levels)",
                              description: "The mainframe contains three classes of stages:\n"
                                  "• Stages 01 - 10: Handcrafted subnets introducing basic elements and patrol routes.\n"
                                  "• Stages 11 - 50: Procedural normal networks with varying complexity, bigger layouts, and multiple cores.\n"
                                  "• Stages 51 - 60: Hardcore mainframe nodes with extremely tight RAM (12-16 MB), high speed firewalls (28% to 32% threat growth rate), and dense firewall node placements.",
                            ),
                            const SizedBox(height: 12),
                            _buildInfoCard(
                              title: "Upgrades Terminal",
                              description: "Redeem your green data core credits to bypass strict security barriers:\n"
                                  "• RAM Overclock: Adds +2 MB of RAM limits per upgrade level.\n"
                                  "• Signal Jammer: Slows down firewall threat accumulation by 15% per upgrade level.\n"
                                  "• Decoy Signature: Deploys decoys so security drones ignore you for 3 moves.",
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
