import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/cyber_theme.dart';
import '../widgets/particle_emitter.dart';
import 'main_menu_screen.dart';
import 'onboarding_screen.dart';
import '../utils/game_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  final ParticleController _particleController = ParticleController();

  double _loadingProgress = 0.0;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _startLoadingSequence();
  }

  void _startLoadingSequence() {
    int step = 0;
    const totalSteps = 50;
    const intervalMs = 50;

    _progressTimer = Timer.periodic(const Duration(milliseconds: intervalMs), (timer) {
      if (!mounted) return;

      setState(() {
        step++;
        _loadingProgress = step / totalSteps;
      });

      // Emit subtle ambient cyber sparks
      if (step % 5 == 0) {
        final randomOffset = Offset(
          MediaQuery.of(context).size.width / 2 + (Random().nextDouble() * 160 - 80),
          MediaQuery.of(context).size.height / 2 + (Random().nextDouble() * 160 - 80),
        );
        _particleController.spawn(randomOffset, CyberTheme.primaryCyan, count: 4);
      }

      if (step >= totalSteps) {
        timer.cancel();
        _navigateToMainMenu();
      }
    });
  }

  void _navigateToMainMenu() {
    final completed = GameStorage.getOnboardingCompleted();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            completed ? const MainMenuScreen() : const OnboardingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
            // Particle layer
            Positioned.fill(
              child: ParticleEmitter(controller: _particleController),
            ),

            // Ambient background cyber lines
            Positioned.fill(
              child: Opacity(
                opacity: 0.12,
                child: CustomPaint(
                  painter: HexPatternBackgroundPainter(),
                ),
              ),
            ),

            // Central Content
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    // Cyber Hex Animated Central Badge
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer Rotating Tech Ring
                          RotationTransition(
                            turns: _rotationController,
                            child: CustomPaint(
                              size: const Size(170, 170),
                              painter: CyberRingPainter(color: CyberTheme.secondaryMagenta),
                            ),
                          ),

                          // Reverse Rotating Inner Ring
                          RotationTransition(
                            turns: ReverseAnimation(_rotationController),
                            child: CustomPaint(
                              size: const Size(130, 130),
                              painter: CyberRingPainter(color: CyberTheme.primaryCyan),
                            ),
                          ),

                          // Pulsing Core Icon
                          AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, child) {
                              final scale = 1.0 + 0.08 * _pulseController.value;
                              return Transform.scale(
                                scale: scale,
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: CyberTheme.cardBackground,
                                    border: Border.all(color: CyberTheme.primaryCyan, width: 2),
                                    boxShadow: CyberTheme.neonGlow(CyberTheme.primaryCyan, blurRadius: 16),
                                  ),
                                  child: const Icon(
                                    Icons.shield_outlined,
                                    color: CyberTheme.primaryCyan,
                                    size: 42,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // App Title
                    const Text(
                      "CyberHex",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 6.0,
                        shadows: [
                          Shadow(color: CyberTheme.primaryCyan, blurRadius: 16),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "System Initializing...",
                      style: TextStyle(
                        fontSize: 12,
                        color: CyberTheme.secondaryMagenta,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(flex: 2),



                    // Neon Progress Bar Indicator
                    Container(
                      width: screenSize.width * 0.75,
                      height: 10,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F0F12),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: CyberTheme.primaryCyan.withOpacity(0.4)),
                        boxShadow: CyberTheme.neonGlow(CyberTheme.primaryCyan, blurRadius: 4),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: LinearProgressIndicator(
                          value: _loadingProgress,
                          backgroundColor: Colors.transparent,
                          valueColor: const AlwaysStoppedAnimation<Color>(CyberTheme.primaryCyan),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Text(
                      "${(_loadingProgress * 100).toInt()}%",
                      style: const TextStyle(
                        fontSize: 12,
                        color: CyberTheme.primaryCyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(flex: 1),
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
class HexPatternBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E2640)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const r = 30.0;
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
