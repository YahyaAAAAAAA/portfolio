import 'dart:math' as math;

import 'package:flutter/material.dart';

class MouseFollowingWrapper extends StatefulWidget {
  final Widget child;
  final double followIntensity;
  final Duration animationDuration;
  final bool enableScale;
  final double maxOffset;
  final Curve animationCurve;

  const MouseFollowingWrapper({
    super.key,
    required this.child,
    this.followIntensity = 0.3,
    this.animationDuration = const Duration(milliseconds: 200),
    this.enableScale = true,
    this.maxOffset = 20.0,
    this.animationCurve = Curves.easeOutCubic,
  });

  @override
  State<MouseFollowingWrapper> createState() => _MouseFollowingWrapperState();
}

class _MouseFollowingWrapperState extends State<MouseFollowingWrapper>
    with SingleTickerProviderStateMixin {
  Offset _mousePosition = Offset.zero;
  Offset _currentOffset = Offset.zero;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updatePosition(Offset mousePosition, Size widgetSize) {
    // Calculate widget center
    final widgetCenter = Offset(widgetSize.width / 2, widgetSize.height / 2);

    // Calculate the direction vector from widget center to mouse
    final dx = mousePosition.dx - widgetCenter.dx;
    final dy = mousePosition.dy - widgetCenter.dy;

    // Calculate distance
    final distance = math.sqrt(dx * dx + dy * dy);
    if (distance == 0) return;

    // Calculate normalized direction
    final normalizedDx = dx / distance;
    final normalizedDy = dy / distance;

    // Apply intensity and clamp to maximum offset
    final offsetX = (normalizedDx * widget.followIntensity * widget.maxOffset)
        .clamp(-widget.maxOffset, widget.maxOffset);
    final offsetY = (normalizedDy * widget.followIntensity * widget.maxOffset)
        .clamp(-widget.maxOffset, widget.maxOffset);

    final newOffset = Offset(offsetX, offsetY);

    // Calculate scale based on distance (subtle effect)
    final scale =
        widget.enableScale
            ? 1.0 + (newOffset.distance * 0.002).clamp(0.0, 0.05)
            : 1.0;

    // Animate to new position and scale
    _offsetAnimation = Tween<Offset>(
      begin: _currentOffset,
      end: newOffset,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: _scaleAnimation.value,
      end: scale,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _animationController.forward(from: 0);
    setState(() {
      _currentOffset = newOffset;
    });
  }

  void _resetPosition() {
    _offsetAnimation = Tween<Offset>(
      begin: _currentOffset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: _scaleAnimation.value,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _animationController.forward(from: 0);
    setState(() {
      _currentOffset = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onHover: (event) {
            _mousePosition = event.localPosition;
            _updatePosition(_mousePosition, constraints.biggest);
          },
          onExit: (event) {
            _resetPosition();
          },
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: _offsetAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: widget.child,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
