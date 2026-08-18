import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/cyber_theme.dart';
import '../utils/game_storage.dart';
import 'main_menu_screen.dart';

class OnboardingScreen extends StatefulWidget {
  final bool isReplay;
  const OnboardingScreen({super.key, this.isReplay = false});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  late AnimationController _animController;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  void _onNextPage() {
    HapticFeedback.mediumImpact();
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() async {
    HapticFeedback.heavyImpact();
    if (!widget.isReplay) {
      await GameStorage.setOnboardingCompleted(true);
    }
    if (mounted) {
      if (widget.isReplay) {
        Navigator.pop(context);
      } else {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const MainMenuScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    }
  }

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
            // Cyber Hex Ambient Background
            Positioned.fill(
              child: Opacity(
                opacity: 0.08,
                child: CustomPaint(
                  painter: AmbientHexPainter(),
                ),
              ),
            ),

            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header (Skip Button)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "MISSION_BRIEF // 0${_currentPage + 1}",
                          style: CyberTheme.terminalMuted.copyWith(fontWeight: FontWeight.bold),
                        ),
                        if (_currentPage < 3)
                          TextButton(
                            onPressed: _finishOnboarding,
                            child: const Text(
                              "// SKIP",
                              style: TextStyle(
                                fontFamily: 'Courier',
                                color: CyberTheme.secondaryMagenta,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        else
                          const SizedBox(height: 38), // placeholder to balance height
                      ],
                    ),
                  ),

                  // Slides Content
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (page) {
                        setState(() {
                          _currentPage = page;
                        });
                        HapticFeedback.selectionClick();
                      },
                      children: [
                        _buildSlide(
                          title: "WELCOME HACKER",
                          subtitle: "THE MISSION OVERVIEW",
                          description: "You are an elite Node Hacker operating in the deep shadows. Your goal is to infiltrate high-security corporate node networks, breach their firewalls, and extract critical core intelligence.",
                          child: _buildWelcomeGraphic(),
                        ),
                        _buildSlide(
                          title: "TRAVERSE NODES",
                          subtitle: "RAM RESOURCE MANAGEMENT",
                          description: "In CyberHex, you move by linking to adjacent nodes. Each hop consumes 1 MB of your RAM Energy. Plan your route carefully: if your RAM cache decays to zero, your connection drops and you fail.",
                          child: _buildTraversalGraphic(),
                        ),
                        _buildSlide(
                          title: "AVOID THREATS",
                          subtitle: "SECURITY DETECTION & ESCAPE",
                          description: "Beware! Stepping on Firewall nodes triggers immediate alarms (+25% threat speed). Watch out for security Drones patrolling the paths. Seek and enter the green Extraction Gate to escape and secure your loot.",
                          child: _buildThreatsGraphic(),
                        ),
                        _buildSlide(
                          title: "UPGRADE ARSENAL",
                          subtitle: "MAINFRAME UPGRADES",
                          description: "Redeem extracted DATA credits at the Terminal Shop to upgrade your rig. Expand your max RAM, install Jammers to slow down firewall tracing, or buy Decoys to hide from security patrol drone paths.",
                          child: _buildShopGraphic(),
                        ),
                      ],
                    ),
                  ),

                  // Footer Controls
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                    child: Column(
                      children: [
                        // Dots Indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) => _buildDot(index)),
                        ),
                        const SizedBox(height: 32),

                        // Action Button
                        GestureDetector(
                          onTap: _onNextPage,
                          child: Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              color: CyberTheme.cardBackground,
                              border: Border.all(
                                color: _currentPage == 3 ? CyberTheme.successGreen : CyberTheme.primaryCyan,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: CyberTheme.neonGlow(
                                _currentPage == 3 ? CyberTheme.successGreen : CyberTheme.primaryCyan,
                                blurRadius: 8,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _currentPage == 3 ? "ENTER NEURAL LINK" : "PROCEED PROTOCOL",
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _currentPage == 3 ? CyberTheme.successGreen : CyberTheme.primaryCyan,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide({
    required String title,
    required String subtitle,
    required String description,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Center(child: child),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2.0,
              shadows: [
                Shadow(color: CyberTheme.primaryCyan, blurRadius: 10),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontSize: 12,
              color: CyberTheme.secondaryMagenta,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                description,
                style: CyberTheme.terminalBody.copyWith(
                  height: 1.5,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    final isActive = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      width: isActive ? 24.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: isActive ? CyberTheme.primaryCyan : const Color(0xFF1F2438),
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: isActive ? CyberTheme.neonGlow(CyberTheme.primaryCyan, blurRadius: 4) : null,
      ),
    );
  }

  // Slide 1 Graphic: Cyber Logo / Core Node
  Widget _buildWelcomeGraphic() {
    return RotationTransition(
      turns: _rotationController,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(200, 200),
            painter: CyberRingPainter(color: CyberTheme.primaryCyan),
          ),
          RotationTransition(
            turns: ReverseAnimation(_rotationController),
            child: CustomPaint(
              size: const Size(150, 150),
              painter: CyberRingPainter(color: CyberTheme.secondaryMagenta),
            ),
          ),
          AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              final scale = 0.95 + 0.1 * _animController.value;
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CyberTheme.cardBackground,
                    border: Border.all(color: CyberTheme.primaryCyan, width: 2),
                    boxShadow: CyberTheme.neonGlow(CyberTheme.primaryCyan, blurRadius: 12),
                  ),
                  child: const Icon(
                    Icons.security,
                    color: CyberTheme.primaryCyan,
                    size: 40,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Slide 2 Graphic: Traversing hex grid showing RAM depletion
  Widget _buildTraversalGraphic() {
    return SizedBox(
      width: 250,
      height: 180,
      child: Stack(
        children: [
          // Hex grid lines
          Positioned.fill(
            child: CustomPaint(
              painter: TutorialHexPainter(
                playerIndex: (_animController.value * 2).floor().clamp(0, 1),
              ),
            ),
          ),
          // RAM Energy Bar overlay
          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "RAM ENERGY CACHE",
                      style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: CyberTheme.primaryCyan),
                    ),
                    AnimatedBuilder(
                      animation: _animController,
                      builder: (context, child) {
                        final val = 12 - (_animController.value * 4).round();
                        return Text(
                          "$val/12 MB",
                          style: const TextStyle(fontFamily: 'Courier', fontSize: 10, color: CyberTheme.primaryCyan, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                AnimatedBuilder(
                  animation: _animController,
                  builder: (context, child) {
                    final progress = 1.0 - (_animController.value * 0.33);
                    return Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: CyberTheme.primaryCyan.withOpacity(0.5)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.transparent,
                          valueColor: const AlwaysStoppedAnimation(CyberTheme.primaryCyan),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Slide 3 Graphic: Hazards (Red Warning/Drone) & Port (Green Gate)
  Widget _buildThreatsGraphic() {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        final alertPulse = _animController.value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Firewall node
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CyberTheme.cardBackground,
                    border: Border.all(
                      color: Color.lerp(CyberTheme.errorRed, Colors.red.shade900, alertPulse)!,
                      width: 2,
                    ),
                    boxShadow: CyberTheme.neonGlow(CyberTheme.errorRed, blurRadius: 4 + 8 * alertPulse),
                  ),
                  child: Icon(
                    Icons.gpp_bad_outlined,
                    color: Color.lerp(CyberTheme.errorRed, Colors.white, alertPulse),
                    size: 32,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "FIREWALL\n(+25% THREAT)",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Courier', fontSize: 9, color: CyberTheme.errorRed, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            // Drone Patrol node
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CyberTheme.cardBackground,
                    border: Border.all(
                      color: CyberTheme.accentAmber,
                      width: 2,
                    ),
                    boxShadow: CyberTheme.neonGlow(CyberTheme.accentAmber, blurRadius: 8),
                  ),
                  child: const Icon(
                    Icons.radar,
                    color: CyberTheme.accentAmber,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "SECURITY DRONE\n(AVOID PATH)",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Courier', fontSize: 9, color: CyberTheme.accentAmber, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            // Port node (Extraction Gate)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CyberTheme.cardBackground,
                    border: Border.all(
                      color: CyberTheme.successGreen,
                      width: 2,
                    ),
                    boxShadow: CyberTheme.neonGlow(CyberTheme.successGreen, blurRadius: 4 + 10 * alertPulse),
                  ),
                  child: Icon(
                    Icons.vpn_key,
                    color: Color.lerp(CyberTheme.successGreen, Colors.white, alertPulse),
                    size: 32,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "EXTRACTION\n(ESCAPE PORT)",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Courier', fontSize: 9, color: CyberTheme.successGreen, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Slide 4 Graphic: Upgrades Terminal Shop Mock
  Widget _buildShopGraphic() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildShopItemMock(Icons.battery_charging_full, "RAM OVERCLOCK", "+2 MAX RAM ENERGY", "ACTIVE"),
        const SizedBox(height: 12),
        _buildShopItemMock(Icons.settings_input_antenna, "SIGNAL JAMMER", "SLOWS FIREWALL SCANS", "UPGRADE"),
        const SizedBox(height: 12),
        _buildShopItemMock(Icons.radar, "DECOY SIGNATURE", "STALL PATROL DRONES", "LOCKED"),
      ],
    );
  }

  Widget _buildShopItemMock(IconData icon, String title, String benefit, String state) {
    final isLocked = state == "LOCKED";
    final isInstalled = state == "ACTIVE";
    
    return Container(
      width: 260,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: CyberTheme.cardBackground,
        border: Border.all(
          color: isInstalled
              ? CyberTheme.successGreen
              : isLocked
                  ? Colors.grey.shade800
                  : CyberTheme.primaryCyan,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isInstalled
                ? CyberTheme.successGreen
                : isLocked
                    ? Colors.grey
                    : CyberTheme.primaryCyan,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isLocked ? Colors.grey : Colors.white,
                  ),
                ),
                Text(
                  benefit,
                  style: TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 9,
                    color: isLocked ? Colors.grey.shade600 : CyberTheme.secondaryMagenta,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              state,
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: isInstalled
                    ? CyberTheme.successGreen
                    : isLocked
                        ? Colors.grey
                        : CyberTheme.primaryCyan,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for outer rotating cyber ring
class CyberRingPainter extends CustomPainter {
  final Color color;
  CyberRingPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Draw dashed tech arc
    const dashCount = 12;
    for (int i = 0; i < dashCount; i++) {
      if (i % 2 == 0) {
        final startAngle = (i * (360 / dashCount)) * pi / 180;
        const sweepAngle = (360 / dashCount * 0.7) * pi / 180;
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweepAngle,
          false,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CyberRingPainter oldDelegate) => oldDelegate.color != color;
}

// Ambient Hexagon Pattern Background Painter
class AmbientHexPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E2640)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const r = 25.0;
    for (double y = 0; y < size.height + r; y += r * 1.5) {
      for (double x = 0; x < size.width + r; x += r * sqrt(3)) {
        final center = Offset(x, y);
        final path = Path();
        for (int i = 0; i < 6; i++) {
          final angle = (i * 60) * pi / 180;
          final px = center.dx + r * cos(angle);
          final py = center.dy + r * sin(angle);
          if (i == 0) {
            path.moveTo(px, py);
          } else {
            path.lineTo(px, py);
          }
        }
        path.close();
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter to draw mini tutorial hex grid transition
class TutorialHexPainter extends CustomPainter {
  final int playerIndex; // 0 or 1
  TutorialHexPainter({required this.playerIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final paintNode = Paint()
      ..color = CyberTheme.cardBackground
      ..style = PaintingStyle.fill;

    final paintBorder = Paint()
      ..color = CyberTheme.primaryCyan.withOpacity(0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final double hexRadius = 26.0;
    final centers = [
      Offset(size.width / 2 - 40, size.height / 2),
      Offset(size.width / 2 + 40, size.height / 2),
    ];

    // Draw the two hexes
    for (int idx = 0; idx < 2; idx++) {
      final center = centers[idx];
      final path = Path();
      for (int i = 0; i < 6; i++) {
        final angle = (i * 60) * pi / 180;
        final px = center.dx + hexRadius * cos(angle);
        final py = center.dy + hexRadius * sin(angle);
        if (i == 0) {
          path.moveTo(px, py);
        } else {
          path.lineTo(px, py);
        }
      }
      path.close();
      canvas.drawPath(path, paintNode);
      
      // If player is on it, highlight it
      if (idx == playerIndex) {
        final highlightPaint = Paint()
          ..color = CyberTheme.primaryCyan
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke;
        canvas.drawPath(path, highlightPaint);
      } else {
        canvas.drawPath(path, paintBorder);
      }
    }

    // Draw connection line
    final linePaint = Paint()
      ..color = CyberTheme.primaryCyan.withOpacity(0.8)
      ..strokeWidth = 2.0;
    canvas.drawLine(centers[0], centers[1], linePaint);

    // Draw player node core
    final playerCenter = centers[playerIndex];
    final paintPlayer = Paint()
      ..color = CyberTheme.primaryCyan
      ..style = PaintingStyle.fill;
    canvas.drawCircle(playerCenter, 8.0, paintPlayer);

    // Label nodes
    final textPainterStart = TextPainter(
      text: const TextSpan(
        text: 'A',
        style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainterStart.paint(canvas, centers[0] - const Offset(3, 20));

    final textPainterEnd = TextPainter(
      text: const TextSpan(
        text: 'B',
        style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainterEnd.paint(canvas, centers[1] - const Offset(3, 20));
  }

  @override
  bool shouldRepaint(covariant TutorialHexPainter oldDelegate) => oldDelegate.playerIndex != playerIndex;
}
