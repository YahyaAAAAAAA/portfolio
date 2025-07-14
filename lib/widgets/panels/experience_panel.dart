import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/utils/extensions/int_extensions.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/smooth_list.dart';

class ExperiencePanel extends StatefulWidget {
  const ExperiencePanel({super.key});

  @override
  State<ExperiencePanel> createState() => _ExperiencePanelState();
}

class _ExperiencePanelState extends State<ExperiencePanel> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPanelPaddingMedium),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SmoothList(
          controller: _scrollController,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            children: [
              FadeInLeft(
                duration: Duration(milliseconds: k500mill),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: null,
                    child: LabelMediumText('Experience'),
                  ),
                ),
              ),

              20.height,

              SizedBox(
                height: 100,
                child: HorizontalSlidingWidgetSimple(
                  duration: Duration(seconds: 15),
                  spacing: 30,
                  //technical skills
                  children: [
                    Container(
                      width: 150,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

    // Start the animation and repeat it
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
          return CustomPaint(
            painter: SlidingPainter(
              children: widget.children,
              progress: _animation.value,
              spacing: widget.spacing,
              itemWidth: widget.itemWidth,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class SlidingPainter extends CustomPainter {
  final List<Widget> children;
  final double progress;
  final double spacing;
  final double itemWidth;

  SlidingPainter({
    required this.children,
    required this.progress,
    required this.spacing,
    required this.itemWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (children.isEmpty) return;

    final totalItemWidth = itemWidth + spacing;
    final totalWidth = children.length * totalItemWidth;

    // Calculate the offset based on progress
    final offset = -progress * totalWidth;

    for (int i = 0; i < children.length; i++) {
      final itemOffset = offset + (i * totalItemWidth);

      // Draw the item if it's visible on screen
      if (itemOffset + itemWidth >= 0 && itemOffset <= size.width) {
        canvas.save();
        canvas.translate(itemOffset, 0);

        // Here you would need to render the widget
        // This is a simplified approach - in practice you'd need to
        // use a RenderObjectWidget or convert widgets to CustomPaint

        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Flexible implementation using Stack and Positioned widgets
class HorizontalSlidingWidgetSimple extends StatefulWidget {
  final List<Widget> children;
  final Duration duration;
  final double spacing;
  final double itemWidth;

  const HorizontalSlidingWidgetSimple({
    super.key,
    required this.children,
    this.duration = const Duration(seconds: 10),
    this.spacing = 20.0,
    this.itemWidth = 200.0,
  });

  @override
  State<HorizontalSlidingWidgetSimple> createState() =>
      _HorizontalSlidingWidgetSimpleState();
}

class _HorizontalSlidingWidgetSimpleState
    extends State<HorizontalSlidingWidgetSimple>
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

    // Create multiple cycles for infinite scrolling
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
