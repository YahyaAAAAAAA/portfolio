import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/widgets/wrappers/grid_3d_wrapper.dart';

class LogoPanel extends StatefulWidget {
  const LogoPanel({super.key});

  @override
  State<LogoPanel> createState() => _LogoPanelState();
}

class _LogoPanelState extends State<LogoPanel> with TickerProviderStateMixin {
  late AnimationController _opacityController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _opacityController = AnimationController(
      duration: Duration(milliseconds: k2000mill),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _opacityController, curve: Curves.bounceInOut),
    );
    _opacityController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Grid3DWrapper(
      child: Center(
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _opacityAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Image.asset(
                    'assets/images/logo_filled_shadow.png',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
            Image.asset(
              'assets/images/logo_inside_app_shadow.png',
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
