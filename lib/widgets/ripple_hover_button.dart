import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';

class RippleHoverButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Color baseColor;
  final Color rippleColor;
  final double width;
  final double height;
  final Widget child;
  final double rippleRadius;

  const RippleHoverButton({
    super.key,
    required this.child,
    this.onPressed,
    this.baseColor = Colors.transparent,
    this.rippleColor = const Color(0xFF3b0f7c),
    this.width = 200,
    this.height = 50,
    this.rippleRadius = 0.5,
  });

  @override
  State<RippleHoverButton> createState() => _RippleHoverButtonState();
}

class _RippleHoverButtonState extends State<RippleHoverButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  Offset _mousePosition = Offset.zero;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 0),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHover(PointerHoverEvent event) {
    setState(() {
      _mousePosition = event.localPosition;
    });
  }

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _isHovered = true;
      _mousePosition = event.localPosition;
    });
    _animationController.forward();
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _isHovered = false;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: RipplePainter(
                isHovered: _isHovered,
                mousePosition: _mousePosition,
                animation: _animation.value,
                baseColor: widget.baseColor,
                rippleColor: widget.rippleColor,
                rippleRadius: widget.rippleRadius,
              ),
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kOuterBorderRadius),
                  border: Border.all(color: context.theme.dividerColor),
                ),
                child: widget.child,
              ),
            );
          },
        ),
      ),
    );
  }
}

class RipplePainter extends CustomPainter {
  final bool isHovered;
  final Offset mousePosition;
  final double animation;
  final Color baseColor;
  final Color rippleColor;
  final double rippleRadius;

  RipplePainter({
    required this.isHovered,
    required this.mousePosition,
    required this.animation,
    required this.baseColor,
    required this.rippleColor,
    required this.rippleRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final borderRadius = BorderRadius.circular(kOuterBorderRadius);
    final rrect = borderRadius.toRRect(rect);

    // Draw base button
    final basePaint =
        Paint()
          ..color = baseColor
          ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, basePaint);

    // Draw ripple effect if hovered
    if (isHovered && animation > 0) {
      // Calculate maximum radius needed to cover the button
      final maxRadius = _calculateMaxRadius(size, mousePosition);
      final currentRadius = maxRadius * animation;

      // Create radial gradient
      final gradient = RadialGradient(
        center: Alignment.center,
        radius: rippleRadius,
        colors: [
          rippleColor.withValues(alpha: 0.6),
          rippleColor.withValues(alpha: 0.3),
          rippleColor.withValues(alpha: 0.1),
          Colors.transparent,
        ],
        stops: [0.0, 0.3, 0.7, 1.0],
      );

      // Create paint with gradient
      final ripplePaint =
          Paint()
            ..shader = gradient.createShader(
              Rect.fromCircle(center: mousePosition, radius: currentRadius),
            )
            ..style = PaintingStyle.fill;

      // Clip to button shape and draw ripple
      canvas.save();
      canvas.clipRRect(rrect);
      canvas.drawCircle(mousePosition, currentRadius, ripplePaint);
      canvas.restore();
    }

    // Draw border
    final borderPaint =
        Paint()
          ..color = baseColor.withValues(alpha: 0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;
    canvas.drawRRect(rrect, borderPaint);
  }

  double _calculateMaxRadius(Size size, Offset center) {
    // Calculate distance to all corners and return the maximum
    final distances = [
      (center - Offset(0, 0)).distance,
      (center - Offset(size.width, 0)).distance,
      (center - Offset(0, size.height)).distance,
      (center - Offset(size.width, size.height)).distance,
    ];
    return distances.reduce((a, b) => a > b ? a : b);
  }

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) {
    return oldDelegate.isHovered != isHovered ||
        oldDelegate.mousePosition != mousePosition ||
        oldDelegate.animation != animation;
  }
}
