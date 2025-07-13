import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';

class Grid3DWrapper extends StatefulWidget {
  final Widget? child;

  const Grid3DWrapper({super.key, this.child});

  @override
  State<Grid3DWrapper> createState() => _Grid3DWrapperState();
}

class _Grid3DWrapperState extends State<Grid3DWrapper>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500), // Complete cycle duration
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    // Start the animation and make it loop
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kOuterBorderRadius),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: Grid3DPainter(animationValue: _animation.value),
            child: widget.child,
          );
        },
      ),
    );
  }
}

class Grid3DPainter extends CustomPainter {
  final double animationValue;

  Grid3DPainter({this.animationValue = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final wallPaint =
        Paint()
          ..color = Colors.white.withValues(alpha: 0.1)
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    final floorPaint =
        Paint()
          ..color = Colors.white.withValues(alpha: 0.1)
          ..strokeWidth = 0.8
          ..style = PaintingStyle.stroke;

    final gridSize = 20.0;
    final floorStart = size.height * 0.6; // Where the floor begins
    final perspective = 4; // Reduced perspective factor for better containment

    // Calculate the horizontal offset for rightward movement
    final horizontalOffset =
        animationValue * gridSize * 2; // Move by 2 grid cells

    // Draw vertical wall lines (straight) with offset
    for (double x = 0; x <= size.width + gridSize; x += gridSize) {
      final path = Path();
      final adjustedX = (x - horizontalOffset) % (size.width + gridSize);
      path.moveTo(adjustedX, 0);
      path.lineTo(adjustedX, floorStart);
      canvas.drawPath(path, wallPaint);
    }

    // Draw horizontal wall lines (straight) with offset
    for (double y = 0; y <= floorStart; y += gridSize) {
      final path = Path();
      path.moveTo(0, y);
      path.lineTo(size.width, y);
      canvas.drawPath(path, floorPaint);
    }

    // Draw floor grid with perspective
    final floorGridSize = 20.0;
    final floorHeight = size.height - floorStart;

    // Horizontal floor lines (getting closer together as they go back) with offset
    for (double i = 0; i <= 8; i++) {
      final progress = i / 8;
      final y = floorStart + (floorHeight * progress * progress);

      // Calculate perspective offset - lines get narrower as they go back
      final perspectiveOffset = progress * size.width * perspective;

      // Ensure lines don't go outside bounds
      final startX = perspectiveOffset.clamp(0.0, size.width).toDouble();
      final endX =
          (size.width - perspectiveOffset).clamp(0.0, size.width).toDouble();

      final path = Path();

      path.moveTo(startX, y);
      path.lineTo(endX, y);
      canvas.drawPath(path, floorPaint);
    }

    // Vertical floor lines (converging to vanishing point) with offset
    final vanishingPointY = size.height;
    final vanishingPointX = size.width / 2;

    for (double x = 0; x <= size.width + floorGridSize; x += floorGridSize) {
      final path = Path();
      final adjustedX = (x - horizontalOffset) % (size.width + floorGridSize);
      path.moveTo(adjustedX, floorStart);

      // Calculate where this line should end up (converging toward center)
      final offsetFromCenter = adjustedX - vanishingPointX;
      final vanishingX = vanishingPointX + (offsetFromCenter * perspective);

      path.lineTo(vanishingX, vanishingPointY);
      canvas.drawPath(path, floorPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is Grid3DPainter &&
        oldDelegate.animationValue != animationValue;
  }
}
