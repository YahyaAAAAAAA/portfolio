import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'dart:ui';

import 'package:portfolio_3/utils/global_colors.dart';

/// A container that spawns animated portal effects at random positions
class PortalAnimationContainer extends StatefulWidget {
  final double width;
  final double height;
  final Color backgroundColor;

  const PortalAnimationContainer({
    super.key,
    this.width = 400,
    this.height = 300,
    this.backgroundColor = Colors.lightBlue,
  });

  @override
  State<PortalAnimationContainer> createState() =>
      _PortalAnimationContainerState();
}

class _PortalAnimationContainerState extends State<PortalAnimationContainer>
    with TickerProviderStateMixin {
  final List<PortalData> _portals = [];
  final Random _random = Random();
  Timer? _spawnTimer;

  @override
  void initState() {
    super.initState();
    _startSpawningPortals();
  }

  /// Starts the timer that periodically spawns new portals
  void _startSpawningPortals() {
    _spawnTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      _spawnPortal();
    });
  }

  /// Creates and spawns a new portal at a random position
  void _spawnPortal() {
    final portalData = PortalData(
      id: DateTime.now().millisecondsSinceEpoch,
      position: Offset(
        _random.nextDouble() * (widget.width - 80),
        _random.nextDouble() * (widget.height - 100),
      ),
      secondaryColor: Color(0xFF641C50).withValues(alpha: 0.3),
      primaryColor: const Color(0xFF0f0d20).withValues(alpha: 0.3),
      vsync: this,
    );

    setState(() {
      _portals.add(portalData);
    });

    // Start the portal animation and handle cleanup when done
    portalData.startAnimation(() {
      setState(() {
        _portals.removeWhere((portal) => portal.id == portalData.id);
      });
      portalData.dispose();
    });
  }

  /// Returns a random color from a predefined palette
  Color _getRandomColor() {
    final colors = [
      Colors.pink,
      Colors.purple,
      Colors.blue,
      Colors.cyan,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.red,
      Colors.indigo,
      Colors.teal,
    ];
    return colors[_random.nextInt(colors.length)];
  }

  @override
  void dispose() {
    _spawnTimer?.cancel();
    for (final portal in _portals) {
      portal.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Stack(
        children:
            _portals.map((portal) => PortalWidget(portalData: portal)).toList(),
      ),
    );
  }
}

/// Data class that holds portal properties and manages its animations
class PortalData {
  final int id;
  final Offset position;
  final Color primaryColor;
  final Color secondaryColor;
  late final AnimationController _animationController;
  late final Animation<double> _fadeInAnimation;
  late final Animation<double> _primaryScaleAnimation;
  late final Animation<double> _secondaryScaleAnimation;
  late final Animation<Color?> _colorTransitionAnimation;
  late final Animation<Offset> _driftAnimation;

  // Fade-out animations
  late final AnimationController _fadeOutController;
  late final Animation<double> _fadeOutAnimation;
  bool _isFadingOut = false;

  PortalData({
    required this.id,
    required this.position,
    required this.primaryColor,
    required this.secondaryColor,
    required TickerProvider vsync,
  }) {
    // Main animation controller for the portal lifecycle
    _animationController = AnimationController(
      duration: Duration(seconds: 6),
      vsync: vsync,
    );

    // Fade in animation (first 20% of lifecycle)
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.2, curve: Curves.easeIn),
      ),
    );

    // Primary portal scale animation
    _primaryScaleAnimation = Tween<double>(begin: 0.3, end: 2.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Secondary portal scale animation (starts at 10% of lifecycle for ring effect)
    _secondaryScaleAnimation = Tween<double>(begin: 0.0, end: 2.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1, 1.0, curve: Curves.easeOut),
      ),
    );

    // Remove color transition - portals maintain their colors
    _colorTransitionAnimation = ColorTween(
      begin: primaryColor,
      end: primaryColor,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.3, 0.7, curve: Curves.easeInOut),
      ),
    );

    // Subtle drift/movement animation
    final random = Random();
    final endX = position.dx + (random.nextDouble() - 0.5) * 100;
    final endY = position.dy + (random.nextDouble() - 0.5) * 60;

    _driftAnimation = Tween<Offset>(
      begin: position,
      end: Offset(endX, endY),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Fade-out controller for smooth portal disappearance
    _fadeOutController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: vsync,
    );
    _fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeOutController, curve: Curves.easeIn),
    );
  }

  /// Starts the portal animation sequence
  void startAnimation(VoidCallback onComplete) {
    _animationController.forward().then((_) {
      _isFadingOut = true;
      _fadeOutController.forward().then((_) {
        onComplete();
      });
    });
  }

  /// Disposes of animation controllers
  void dispose() {
    _animationController.dispose();
    _fadeOutController.dispose();
  }

  // Getters for accessing animations
  Animation<double> get fadeInAnimation => _fadeInAnimation;
  Animation<double> get fadeOutAnimation => _fadeOutAnimation;
  Animation<double> get primaryScaleAnimation => _primaryScaleAnimation;
  Animation<double> get secondaryScaleAnimation => _secondaryScaleAnimation;
  Animation<Color?> get colorTransitionAnimation => _colorTransitionAnimation;
  Animation<Offset> get driftAnimation => _driftAnimation;
  bool get isFadingOut => _isFadingOut;
}

/// Widget that renders an animated portal using PortalData
class PortalWidget extends StatelessWidget {
  final PortalData portalData;

  const PortalWidget({super.key, required this.portalData});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        portalData._animationController,
        portalData._fadeOutController,
      ]),
      builder: (context, child) {
        // Calculate combined opacity from fade in and fade out
        double opacity =
            portalData.isFadingOut
                ? portalData.fadeOutAnimation.value
                : portalData.fadeInAnimation.value;

        // Apply shrinking effect during fade out
        double scale =
            portalData.isFadingOut
                ? lerpDouble(
                      portalData.primaryScaleAnimation.value,
                      0.7,
                      1 - portalData.fadeOutAnimation.value,
                    ) ??
                    portalData.primaryScaleAnimation.value
                : portalData.primaryScaleAnimation.value;

        return Positioned(
          left: portalData.driftAnimation.value.dx,
          top: portalData.driftAnimation.value.dy,
          child: Opacity(
            opacity: opacity,
            child: Stack(
              children: [
                // Secondary portal layer (ring/border effect - rendered first)
                if (portalData.secondaryScaleAnimation.value > 0)
                  Transform.scale(
                    scale: portalData.secondaryScaleAnimation.value,
                    child: CustomPaint(
                      size: Size(80, 100),
                      painter: PortalPainter(
                        color: portalData.secondaryColor,
                        animationValue: portalData._animationController.value,
                      ),
                    ),
                  ),
                // Primary portal layer (main portal - rendered on top)
                Transform.scale(
                  scale: scale,
                  child: CustomPaint(
                    size: Size(80, 100),
                    painter: PortalPainter(
                      color: portalData.primaryColor,
                      animationValue: portalData._animationController.value,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Custom painter that draws organic, animated portal shapes
class PortalPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  PortalPainter({required this.color, this.animationValue = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8.0);

    final center = Offset(size.width / 2, size.height / 2);
    final random = Random(
      (color.value * 1000).toInt(),
    ); // Consistent seed for reproducible randomness

    // Portal size multiplier (0.1 to 0.6)
    final sizeMultiplier = random.nextDouble() * 0.1 + 0.6;

    // Create dynamic portal shape path
    final path = Path();

    // Base dimensions with randomness
    final baseWidth =
        size.width * (sizeMultiplier + random.nextDouble() * sizeMultiplier);
    final baseHeight =
        size.height * (sizeMultiplier + random.nextDouble() * sizeMultiplier);

    // Add organic distortion based on animation progress
    final wobbleIntensity = sin(animationValue * pi * 20) * 0.05;
    final twistIntensity = sin(animationValue * pi * 20) * 0.05;

    // Generate control points for irregular oval shape
    final controlPoints = <Offset>[];
    final numPoints = 2 + random.nextInt(2); // 8-12 control points

    for (int i = 0; i < numPoints; i++) {
      final angle = (i / numPoints) * 2 * pi;

      // Vary the radius for each point to create organic shape
      final radiusX = baseWidth * (0.8 + random.nextDouble() * 0.4);
      final radiusY = baseHeight * (0.8 + random.nextDouble() * 0.4);

      // Add random angle variation for organic appearance
      final angleVariation = (random.nextDouble() - 0.5) * 0.3;
      final finalAngle = angle + angleVariation + twistIntensity;

      // Calculate final position with wobble effect
      final x = center.dx + cos(finalAngle) * radiusX * (1 + wobbleIntensity);
      final y = center.dy + sin(finalAngle) * radiusY * (1 - wobbleIntensity);

      controlPoints.add(Offset(x, y));
    }

    // Create smooth curved path through control points
    if (controlPoints.isNotEmpty) {
      path.moveTo(controlPoints[0].dx, controlPoints[0].dy);

      for (int i = 1; i < controlPoints.length; i++) {
        final current = controlPoints[i];
        final previous = controlPoints[i - 1];
        final next = controlPoints[(i + 1) % controlPoints.length];

        // Create smooth bezier curves between points
        final controlPoint1 = Offset(
          previous.dx + (current.dx - previous.dx) * 0.5,
          previous.dy + (current.dy - previous.dy) * 0.5,
        );
        final controlPoint2 = Offset(
          current.dx - (next.dx - current.dx) * 0.3,
          current.dy - (next.dy - current.dy) * 0.3,
        );

        path.quadraticBezierTo(
          controlPoint1.dx,
          controlPoint1.dy,
          current.dx,
          current.dy,
        );
        path.quadraticBezierTo(
          controlPoint2.dx,
          controlPoint2.dy,
          current.dx,
          current.dy,
        );
      }

      // Close the path smoothly back to start
      final first = controlPoints[0];
      final last = controlPoints[controlPoints.length - 1];
      path.quadraticBezierTo(
        last.dx + (first.dx - last.dx) * 0.5,
        last.dy + (first.dy - last.dy) * 0.5,
        first.dx,
        first.dy,
      );

      path.close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is PortalPainter &&
        (oldDelegate.color != color ||
            oldDelegate.animationValue != animationValue);
  }
}
