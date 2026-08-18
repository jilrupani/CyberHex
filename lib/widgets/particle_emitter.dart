import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ParticleModel {
  Offset position;
  Offset velocity;
  double size;
  double life; // from 1.0 down to 0.0
  final double decaySpeed;
  final Color color;
  final bool isGlow;

  ParticleModel({
    required this.position,
    required this.velocity,
    required this.size,
    required this.decaySpeed,
    required this.color,
    this.isGlow = false,
    this.life = 1.0,
  });

  void update() {
    position += velocity;
    // Apply slight friction/gravity
    velocity = Offset(velocity.dx * 0.98, velocity.dy * 0.98);
    life -= decaySpeed;
  }
}

class ParticleEmitter extends StatefulWidget {
  final ParticleController controller;

  const ParticleEmitter({super.key, required this.controller});

  @override
  State<ParticleEmitter> createState() => _ParticleEmitterState();
}

class _ParticleEmitterState extends State<ParticleEmitter> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  List<ParticleModel> _particles = [];

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      if (mounted && _particles.isNotEmpty) {
        setState(() {
          for (var p in _particles) {
            p.update();
          }
          _particles.removeWhere((p) => p.life <= 0);
        });
      }
    });
    _ticker.start();
    
    widget.controller.onSpawn = (position, color, count) {
      if (!mounted) return;
      final rand = Random();
      setState(() {
        for (int i = 0; i < count; i++) {
          final angle = rand.nextDouble() * 2 * pi;
          final speed = 1.0 + rand.nextDouble() * 4.0;
          _particles.add(
            ParticleModel(
              position: position,
              velocity: Offset(cos(angle) * speed, sin(angle) * speed),
              size: 2.0 + rand.nextDouble() * 5.0,
              decaySpeed: 0.015 + rand.nextDouble() * 0.02,
              color: color,
              isGlow: rand.nextBool(),
            ),
          );
        }
      });
    };
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: ParticlePainter(particles: _particles),
        child: Container(),
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<ParticleModel> particles;

  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final paint = Paint()
        ..color = p.color.withOpacity(p.life)
        ..style = PaintingStyle.fill;
      
      if (p.isGlow) {
        paint.maskFilter = MaskFilter.blur(BlurStyle.normal, p.size * 1.5);
        canvas.drawCircle(p.position, p.size * 2, paint);
      }
      
      final solidPaint = Paint()
        ..color = p.color.withOpacity(p.life)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(p.position, p.size, solidPaint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}

class ParticleController {
  void Function(Offset position, Color color, int count)? onSpawn;

  void spawn(Offset position, Color color, {int count = 15}) {
    onSpawn?.call(position, color, count);
  }
}
