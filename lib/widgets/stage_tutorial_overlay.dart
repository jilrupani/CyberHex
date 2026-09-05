import 'dart:async';
import 'package:flutter/material.dart';
import '../models/tutorial_step_model.dart';
import '../theme/cyber_theme.dart';

class StageTutorialOverlay extends StatefulWidget {
  final List<TutorialStep> steps;
  final Offset? targetOffset;
  final int currentStepIndex;
  final ValueChanged<int> onStepChanged;
  final VoidCallback onDismiss;

  const StageTutorialOverlay({
    super.key,
    required this.steps,
    required this.targetOffset,
    required this.currentStepIndex,
    required this.onStepChanged,
    required this.onDismiss,
  });

  @override
  State<StageTutorialOverlay> createState() => _StageTutorialOverlayState();
}

class _StageTutorialOverlayState extends State<StageTutorialOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _bounceAnimation;
  Timer? _autoStepTimer;
  bool _isAutoPlaying = true;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0.0, end: 14.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    _startAutoPlayTimer();
  }

  void _startAutoPlayTimer() {
    _autoStepTimer?.cancel();
    if (_isAutoPlaying) {
      _autoStepTimer = Timer.periodic(const Duration(milliseconds: 3800), (timer) {
        if (!mounted) return;
        _nextStep();
      });
    }
  }

  @override
  void dispose() {
    _autoStepTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (widget.currentStepIndex < widget.steps.length - 1) {
      widget.onStepChanged(widget.currentStepIndex + 1);
    } else {
      _autoStepTimer?.cancel();
      widget.onDismiss();
    }
  }

  void _prevStep() {
    if (widget.currentStepIndex > 0) {
      widget.onStepChanged(widget.currentStepIndex - 1);
    }
  }

  void _toggleAutoPlay() {
    setState(() {
      _isAutoPlaying = !_isAutoPlaying;
    });
    if (_isAutoPlaying) {
      _startAutoPlayTimer();
    } else {
      _autoStepTimer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.steps.isEmpty || widget.currentStepIndex >= widget.steps.length) {
      return const SizedBox.shrink();
    }

    final step = widget.steps[widget.currentStepIndex];
    final screenSize = MediaQuery.of(context).size;
    final target = widget.targetOffset ?? Offset(screenSize.width / 2, screenSize.height / 2);

    // Compute pointer position
    final isTargetNearTop = target.dy < 250.0;
    final pointerLeft = (target.dx - 18.0).clamp(12.0, screenSize.width - 70.0);
    final pointerTop = (target.dy - 14.0).clamp(12.0, screenSize.height - 120.0);

    return Stack(
      children: [
        // Subtle darkened backdrop to focus user attention during demonstration
        Positioned.fill(
          child: Container(
            color: Colors.black.withValues(alpha: 0.45),
          ),
        ),

        // Animated Pure Hand Pointer Icon
        AnimatedPositioned(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          left: pointerLeft,
          top: pointerTop,
          child: AnimatedBuilder(
            animation: _bounceAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _bounceAnimation.value),
                child: const IgnorePointer(
                  child: Icon(
                    Icons.touch_app_rounded,
                    color: CyberTheme.accentAmber,
                    size: 46,
                  ),
                ),
              );
            },
          ),
        ),

        // Cyber Instruction Demo Card (English Descriptions)
        Positioned(
          left: 18,
          right: 18,
          top: isTargetNearTop ? (target.dy + 75.0).clamp(60.0, screenSize.height - 240.0) : 60.0,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: CyberTheme.cardBackground.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: CyberTheme.primaryCyan,
                  width: 2.0,
                ),
                boxShadow: CyberTheme.neonGlow(
                  CyberTheme.primaryCyan,
                  blurRadius: 18,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Status Bar: Demo Badge & Progress
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: CyberTheme.accentAmber.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: CyberTheme.accentAmber),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.slideshow, color: CyberTheme.accentAmber, size: 13),
                                    SizedBox(width: 4),
                                    Text(
                                      "DEMO",
                                      style: TextStyle(
                                        color: CyberTheme.accentAmber,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Step ${widget.currentStepIndex + 1} of ${widget.steps.length}",
                                style: const TextStyle(
                                  color: CyberTheme.primaryCyan,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Auto-Play Toggle & Skip Button
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                            icon: Icon(
                              _isAutoPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                              color: CyberTheme.primaryCyan,
                              size: 22,
                            ),
                            onPressed: _toggleAutoPlay,
                            tooltip: _isAutoPlaying ? "Pause Auto Demo" : "Play Auto Demo",
                          ),
                          const SizedBox(width: 4),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              _autoStepTimer?.cancel();
                              widget.onDismiss();
                            },
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Step Title (English)
                  Text(
                    step.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Step Explanation Description (English)
                  Text(
                    step.description,
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Bottom Action Navigation Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.currentStepIndex > 0)
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: _prevStep,
                          icon: const Icon(Icons.arrow_back, size: 15, color: Colors.white70),
                          label: const Text("Previous", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        )
                      else
                        const SizedBox.shrink(),

                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CyberTheme.primaryCyan,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _nextStep,
                        icon: Icon(
                          widget.currentStepIndex == widget.steps.length - 1
                              ? Icons.play_arrow_rounded
                              : Icons.arrow_forward_rounded,
                          size: 16,
                        ),
                        label: Text(
                          widget.currentStepIndex == widget.steps.length - 1
                              ? "Start Playing!"
                              : "Next Step",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
