import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';

/// A wrapper widget that adds a ripple effect to any child widget
class RippleMouseTrail extends StatefulWidget {
  final Widget child;
  final Color? rippleColor;
  final double rippleRadius;
  final bool enabled;
  final bool isOnTop;
  final MouseCursor cursor;
  final Color baseColor;

  const RippleMouseTrail({
    super.key,
    required this.child,
    this.rippleColor,
    this.rippleRadius = 1,
    this.enabled = true,
    this.isOnTop = false,
    this.cursor = MouseCursor.defer,
    this.baseColor = Colors.transparent,
  });

  @override
  State<RippleMouseTrail> createState() => _RippleMouseTrailState();
}

class _RippleMouseTrailState extends State<RippleMouseTrail>
    with TickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;
  Offset _mousePosition = Offset.zero;
  late AnimationController _animationController;
  late Animation<double> _animation;
  Size? _widgetSize;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1).animate(
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
    // Only exit if not pressed (dragging)
    if (!_isPressed) {
      setState(() {
        _isHovered = false;
      });
      _animationController.reverse();
    }
  }

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
      _mousePosition = event.localPosition;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
    // Check if we're still hovering after release
    if (!_isHovered) {
      _animationController.reverse();
    }
  }

  void _onPointerMove(PointerMoveEvent event) {
    setState(() {
      _mousePosition = event.localPosition;
    });

    // Check if mouse is still within widget bounds when pressed
    if (_isPressed && _widgetSize != null) {
      final isWithinBounds =
          event.localPosition.dx >= 0 &&
          event.localPosition.dx <= _widgetSize!.width &&
          event.localPosition.dy >= 0 &&
          event.localPosition.dy <= _widgetSize!.height;

      if (!isWithinBounds && _isHovered) {
        setState(() {
          _isHovered = false;
        });
        _animationController.reverse();
      } else if (isWithinBounds && !_isHovered) {
        setState(() {
          _isHovered = true;
        });
        _animationController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _widgetSize = Size(constraints.maxWidth, constraints.maxHeight);
        return Listener(
          onPointerDown: _onPointerDown,
          onPointerUp: _onPointerUp,
          onPointerMove: _onPointerMove,
          child: MouseRegion(
            onHover: _onHover,
            onEnter: _onEnter,
            onExit: _onExit,
            cursor: widget.cursor,
            child: Stack(
              children: [
                if (widget.enabled && widget.isOnTop) widget.child,
                buildEffect(),
                if (widget.enabled && !widget.isOnTop) widget.child,
              ],
            ),
          ),
        );
      },
    );
  }

  Positioned buildEffect() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: RipplePainter(
              isHovered: _isHovered || _isPressed,
              mousePosition: _mousePosition,
              animation: _animation.value,
              baseColor: widget.baseColor,
              rippleColor: widget.rippleColor ?? context.theme.splashColor,
              rippleRadius: widget.rippleRadius,
            ),
          );
        },
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
          rippleColor.withValues(alpha: 0.05),
          Colors.transparent,
          Colors.transparent,
        ],
        // stops: [0.0, 0.3, 0.7, 1.0, 1, 1, 1, 1],
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
          ..color = baseColor.withValues(alpha: 0)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;
    canvas.drawRRect(rrect, borderPaint);
  }

  double _calculateMaxRadius(Size size, Offset center) {
    // Calculate distance to all corners and return the maximum
    final distances = [
      (center - const Offset(0, 0)).distance,
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
