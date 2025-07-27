import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CircleMouseTrail extends StatefulWidget {
  final Widget child;
  final double circleSize;
  final Color circleColor;
  final double insideCircleSize;
  final Color insideCircleColor;
  final Duration animationDuration;
  final Duration insideCircleAnimationDuration;
  final bool enabled;
  final bool isFilled;

  const CircleMouseTrail({
    super.key,
    required this.child,
    this.circleSize = 20.0,
    this.circleColor = Colors.white,
    this.insideCircleSize = 5.0,
    this.insideCircleColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 300),
    this.insideCircleAnimationDuration = const Duration(milliseconds: 100),
    this.enabled = true,
    this.isFilled = false,
  });

  @override
  State<CircleMouseTrail> createState() => _CircleMouseTrailState();
}

class _CircleMouseTrailState extends State<CircleMouseTrail> {
  Offset _mousePosition = Offset.zero;
  bool _isHovering = false;

  void _updateMousePosition(Offset position) {
    setState(() {
      _mousePosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return Listener(
      onPointerMove: (PointerMoveEvent event) {
        _updateMousePosition(event.localPosition);
      },
      onPointerHover: (PointerHoverEvent event) {
        _updateMousePosition(event.localPosition);
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovering = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovering = false;
          });
        },
        child: Stack(
          children: [
            // The wrapped child widget
            widget.child,
            // Following circle overlay
            if (_isHovering)
              AnimatedPositioned(
                duration: widget.animationDuration,
                curve: Curves.easeOutCubic,
                left: _mousePosition.dx - (widget.circleSize / 2),
                top: _mousePosition.dy - (widget.circleSize / 2),
                child: IgnorePointer(
                  child: Container(
                    width: widget.circleSize,
                    height: widget.circleSize,
                    decoration: BoxDecoration(
                      color:
                          widget.isFilled
                              ? widget.circleColor.withValues(alpha: 0.5)
                              : widget.circleColor.withValues(alpha: 0),
                      shape: BoxShape.circle,
                      border: Border.all(color: widget.circleColor, width: 1),
                    ),
                  ),
                ),
              ),
            //inside circle
            if (_isHovering)
              AnimatedPositioned(
                duration: widget.insideCircleAnimationDuration,
                curve: Curves.easeOutCubic,
                left: _mousePosition.dx - (widget.insideCircleSize / 2),
                top: _mousePosition.dy - (widget.insideCircleSize / 2),
                child: IgnorePointer(
                  child: Container(
                    width: widget.insideCircleSize,
                    height: widget.insideCircleSize,
                    decoration: BoxDecoration(
                      color: widget.insideCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Example usage - wrap your entire app or any widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mouse Following Circle Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CircleMouseTrail(
        circleSize: 40.0,
        circleColor: Colors.red,
        animationDuration: const Duration(milliseconds: 120),
        child: Scaffold(
          appBar: AppBar(title: const Text('My App with Mouse Circle')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'This is your app content!',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Click me!'),
                ),
                const SizedBox(height: 20),
                Text(
                  'The circle follows your mouse everywhere!',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
