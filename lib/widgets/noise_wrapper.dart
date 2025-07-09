import 'package:flutter/material.dart';

class NoiseWrapper extends StatelessWidget {
  final Widget child;
  final double? opacity;
  final bool? enabled;

  const NoiseWrapper({
    super.key,
    required this.child,
    this.opacity = 0.05,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (enabled!)
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: opacity!,
                child: Image.asset(
                  'assets/images/noise.gif',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
