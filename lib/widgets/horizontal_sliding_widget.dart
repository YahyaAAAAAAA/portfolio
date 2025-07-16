import 'package:flutter/material.dart';

class HorizontalSlidingWidget extends StatefulWidget {
  final List<Widget> children;
  final Duration duration;
  final double spacing;
  final double itemWidth;

  const HorizontalSlidingWidget({
    super.key,
    required this.children,
    this.duration = const Duration(seconds: 10),
    this.spacing = 20.0,
    this.itemWidth = 200.0,
  });

  @override
  State<HorizontalSlidingWidget> createState() =>
      _HorizontalSlidingWidgetState();
}

class _HorizontalSlidingWidgetState extends State<HorizontalSlidingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(children: _buildPositionedChildren());
        },
      ),
    );
  }

  List<Widget> _buildPositionedChildren() {
    List<Widget> positioned = [];
    final totalItemWidth = widget.itemWidth + widget.spacing;
    final totalWidth = widget.children.length * totalItemWidth;

    //multiple cycles for infinite scrolling
    for (int cycle = 0; cycle < 3; cycle++) {
      for (int i = 0; i < widget.children.length; i++) {
        final basePosition = (cycle * totalWidth) + (i * totalItemWidth);
        final currentPosition = basePosition - (_animation.value * totalWidth);

        positioned.add(
          Positioned(
            left: currentPosition,
            top: 0,
            child: SizedBox(width: widget.itemWidth, child: widget.children[i]),
          ),
        );
      }
    }

    return positioned;
  }
}
