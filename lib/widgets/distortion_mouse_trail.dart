import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'dart:math' as math;

import 'package:portfolio_3/utils/global_colors.dart';

/// A wrapper widget that adds circular noise/distortion trail effects around the mouse
class DistortionMouseTrail extends StatefulWidget {
  final Widget child;
  final Color noiseColor;
  final double circleRadius;
  final int noiseParticles;
  final double particleSize;
  final int startingAlpha;
  final int fadePerFrame;
  final double noiseIntensity;
  final bool enabled;

  const DistortionMouseTrail({
    super.key,
    required this.child,
    this.noiseColor = GColors.purple,
    this.circleRadius = 50.0,
    this.noiseParticles = 150,
    this.particleSize = 1.5,
    this.startingAlpha = 180,
    this.fadePerFrame = 8,
    this.noiseIntensity = 1.0,
    this.enabled = true,
  });

  @override
  _DistortionMouseTrailState createState() => _DistortionMouseTrailState();
}

class _DistortionMouseTrailState extends State<DistortionMouseTrail>
    with TickerProviderStateMixin {
  List<NoiseParticle> allParticles = [];
  late AnimationController _controller;
  Offset currentMousePosition = Offset.zero;
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 16), // ~60 FPS
      vsync: this,
    )..addListener(() {
      if (!widget.enabled) return;

      setState(() {
        // Update all particles - decrease opacity and apply noise movement
        for (var particle in allParticles) {
          particle.opacity = math.max(
            0,
            particle.opacity - widget.fadePerFrame,
          );

          // Add slight random movement to particles for more organic feel
          particle.position = Offset(
            particle.position.dx +
                (_random.nextDouble() - 0.5) * widget.noiseIntensity,
            particle.position.dy +
                (_random.nextDouble() - 0.5) * widget.noiseIntensity,
          );
        }

        // Remove particles with zero opacity
        allParticles.removeWhere((particle) => particle.opacity <= 0);
      });
    });

    if (widget.enabled) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(DistortionMouseTrail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled && !oldWidget.enabled) {
      _controller.repeat();
    } else if (!widget.enabled && oldWidget.enabled) {
      _controller.stop();
      setState(() {
        allParticles.clear();
      });
    }
  }

  void _onMouseMove(Offset position) {
    if (!widget.enabled) return;

    currentMousePosition = position;

    // Generate noise particles in a circle around the mouse
    List<NoiseParticle> newParticles = _generateNoiseParticles(position);
    allParticles.addAll(newParticles);

    // Limit total particles to prevent memory issues
    if (allParticles.length > widget.noiseParticles * 10) {
      allParticles.removeRange(
        0,
        allParticles.length - widget.noiseParticles * 10,
      );
    }
  }

  List<NoiseParticle> _generateNoiseParticles(Offset center) {
    List<NoiseParticle> particles = [];

    for (int i = 0; i < widget.noiseParticles; i++) {
      // Generate random angle for circular distribution
      double angle = _random.nextDouble() * 2 * math.pi;

      // Generate random radius within the circle (using square root for uniform distribution)
      double radius = math.sqrt(_random.nextDouble()) * widget.circleRadius;

      // Calculate position based on angle and radius
      double x = center.dx + radius * math.cos(angle);
      double y = center.dy + radius * math.sin(angle);

      // Add some initial random velocity for more dynamic effect
      double velocityX = (_random.nextDouble() - 0.5) * 2.0;
      double velocityY = (_random.nextDouble() - 0.5) * 2.0;

      particles.add(
        NoiseParticle(
          position: Offset(x + velocityX, y + velocityY),
          opacity: widget.startingAlpha,
          size: widget.particleSize + (_random.nextDouble() - 0.5) * 0.5,
          velocity: Offset(velocityX, velocityY),
        ),
      );
    }

    return particles;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kOuterBorderRadius),
      child: MouseRegion(
        onHover:
            widget.enabled
                ? (event) => _onMouseMove(event.localPosition)
                : null,
        child: Stack(
          children: [
            widget.child,
            if (widget.enabled)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: DistortionPainter(
                      particles: allParticles,
                      noiseColor: widget.noiseColor,
                      mousePosition: currentMousePosition,
                      circleRadius: widget.circleRadius,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class NoiseParticle {
  Offset position;
  int opacity;
  double size;
  Offset velocity;

  NoiseParticle({
    required this.position,
    required this.opacity,
    required this.size,
    required this.velocity,
  });
}

class DistortionPainter extends CustomPainter {
  final List<NoiseParticle> particles;
  final Color noiseColor;
  final Offset mousePosition;
  final double circleRadius;

  DistortionPainter({
    required this.particles,
    required this.noiseColor,
    required this.mousePosition,
    required this.circleRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Optional: Draw a subtle circle outline to show the distortion area
    // Uncomment this if you want to see the distortion boundary
    /*
    final circlePaint = Paint()
      ..color = noiseColor.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    
    canvas.drawCircle(mousePosition, circleRadius, circlePaint);
    */

    // Draw all noise particles
    for (var particle in particles) {
      final particlePaint =
          Paint()
            ..color = noiseColor.withOpacity(particle.opacity / 255.0)
            ..style = PaintingStyle.fill;

      // Draw particle as a small circle
      canvas.drawCircle(particle.position, particle.size, particlePaint);

      // Alternative: Draw as small rectangles for more "digital noise" feel
      // Uncomment this for a different effect:
      /*
      canvas.drawRect(
        Rect.fromCenter(
          center: particle.position,
          width: particle.size,
          height: particle.size,
        ),
        particlePaint,
      );
      */
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Example usage:
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DistortionMouseTrail(
        noiseColor: Colors.cyan,
        circleRadius: 100.0,
        noiseParticles: 200,
        particleSize: 2.0,
        startingAlpha: 150,
        fadePerFrame: 6,
        noiseIntensity: 1.5,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Distortion Trail',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Move your mouse around!',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
                SizedBox(height: 40),
                // Example of nested distortion effects
                DistortionMouseTrail(
                  noiseColor: Colors.red,
                  circleRadius: 60.0,
                  noiseParticles: 100,
                  particleSize: 1.0,
                  startingAlpha: 200,
                  fadePerFrame: 10,
                  noiseIntensity: 0.8,
                  child: Container(
                    width: 300,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Center(
                      child: Text(
                        'Hover for red distortion!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
