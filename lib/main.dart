import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:portfolio_3/models/panels_manager.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/utils/global_colors.dart';
import 'package:portfolio_3/widgets/grid_3d_wrapper.dart';
import 'package:portfolio_3/widgets/home_panel.dart';
import 'package:portfolio_3/widgets/noise_wrapper.dart';
import 'package:portfolio_3/widgets/custom_app_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'PPNeueMontreal',
        iconTheme: IconThemeData(color: GColors.white, size: kMediumIconSize),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: GColors.white, size: kMediumIconSize),
          toolbarTextStyle: TextStyle(
            fontFamily: 'PPNeueMontreal',
            fontSize: kSmallFontSize,
            fontWeight: FontWeight.w600,
            color: GColors.white,
          ),
        ),
        scaffoldBackgroundColor: GColors.black,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PanelsManager panelsManager = PanelsManager();
  bool logoToggle = false;

  @override
  Widget build(BuildContext context) {
    //i know this is bad, this is specifically when double tapping window title bar
    panelsManager.onToggleCheck(context);

    return NoiseWrapper(
      child: Scaffold(
        appBar: CustomAppBar(
          panelsEnabled: panelsManager.panelsEnabled,
          onPanelToggle:
              (index) =>
                  setState(() => panelsManager.togglePanel(context, index)),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              TextButton(
                onPressed: () => setState(() => logoToggle = !logoToggle),
                child: Text('Toggle Logo'),
              ),
              //first half
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
                height: context.height(),
                width:
                    panelsManager.panel3.enabled || panelsManager.panel4.enabled
                        ? context.width() / 2 - 15
                        : context.width() - 30,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          //top-left
                          HomePanel(
                            panel: panelsManager.panel0,
                            child: Text('Hello'),
                          ),
                          //top-right
                          HomePanel(
                            panel: panelsManager.panel1,
                            child: Grid3DWrapper(
                              child: Center(
                                child: InteractiveRevealWidget(
                                  width: double.infinity,
                                  height: double.infinity,
                                  // duration: Duration(milliseconds: 300),
                                  // //size transition
                                  // transitionBuilder:
                                  //     (child, animation) => ScaleTransition(
                                  //       scale: CurvedAnimation(
                                  //         parent: animation,
                                  //         curve: Curves.elasticInOut,
                                  //       ),
                                  //       child: FadeTransition(
                                  //         opacity: animation,
                                  //         child: child,
                                  //       ),
                                  //     ),
                                  revealChild: ModelViewer(
                                    backgroundColor: Colors.transparent,
                                    src: 'assets/images/liz.glb',
                                    alt: 'A 3D model of an astronaut',
                                    ar: true,
                                    // autoRotate: true,
                                    // animationName: 'CINEMA_4D_Main',
                                    disablePan: true,
                                    disableZoom: true,
                                    // autoPlay: true,
                                    disableTap: true,
                                    cameraControls: true,
                                    cameraOrbit: '-90deg',
                                    // rotationPerSecond: '700%',
                                    // autoRotateDelay: 0,
                                    interactionPrompt: InteractionPrompt.none,
                                  ),
                                  baseChild: Padding(
                                    padding: EdgeInsets.only(right: 30),
                                    child: Image.asset(
                                      'assets/images/liz2.png',
                                      width: 450,
                                      height: 450,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //bottom
                    HomePanel(
                      panel: panelsManager.panel2,
                      child: Text("Hello"),
                    ),
                  ],
                ),
              ),
              //second half
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
                height: context.height(),
                width:
                    panelsManager.panel3.enabled || panelsManager.panel4.enabled
                        ? context.width() / 2 - 15
                        : 0,
                child: Stack(
                  children: [
                    //top
                    HomePanel(
                      panel: panelsManager.panel3,
                      child: Text('Hello'),
                    ),
                    //bottom
                    HomePanel(
                      panel: panelsManager.panel4,
                      child: Text('Hello'),
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

class D20Dice extends StatefulWidget {
  const D20Dice({super.key});

  @override
  State<D20Dice> createState() => _D20DiceState();
}

class _D20DiceState extends State<D20Dice> with TickerProviderStateMixin {
  late AnimationController _controller;
  double _currentRotation = 0.0;
  bool _isAnimating = false;

  // Configurable variables
  double _animationSpeed = 1.0;
  double _diceSize = 200.0;
  double _rotationX = 1.0;
  double _rotationY = 0.7;
  Color _lightColor = Colors.deepPurple.shade200;
  Color _darkColor = Colors.deepPurple.shade800;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: (3000 / _animationSpeed).round()),
      vsync: this,
    );

    // Add listener for continuous smooth rotation
    _controller.addListener(() {
      if (_isAnimating) {
        setState(() {
          _currentRotation += 0.02 * _animationSpeed; // Continuous rotation
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    setState(() {
      _isAnimating = true;
    });
    _controller.repeat();
  }

  void _stopAnimation() {
    setState(() {
      _isAnimating = false;
    });
    _controller.stop();
  }

  void _updateAnimationSpeed(double speed) {
    setState(() {
      _animationSpeed = speed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurable D20 Dice'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ), //djioosaoidjodoijasaoijdaosijdoaijdoij
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Dice Display
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size(_diceSize, _diceSize),
                    painter: D20Painter(
                      _currentRotation,
                      _rotationX,
                      _rotationY,
                      _lightColor,
                      _darkColor,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Animation Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _isAnimating ? null : _startAnimation,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _isAnimating ? _stopAnimation : null,
                    icon: const Icon(Icons.stop),
                    label: const Text('Stop'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Configuration Controls
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Configuration',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Animation Speed
                      Text(
                        'Animation Speed: ${_animationSpeed.toStringAsFixed(1)}x',
                      ),
                      Slider(
                        value: _animationSpeed,
                        min: 0.1,
                        max: 5.0,
                        divisions: 49,
                        onChanged: _updateAnimationSpeed,
                      ),

                      // Dice Size
                      Text('Dice Size: ${_diceSize.toStringAsFixed(0)}'),
                      Slider(
                        value: _diceSize,
                        min: 100.0,
                        max: 300.0,
                        divisions: 20,
                        onChanged: (value) {
                          setState(() {
                            _diceSize = value;
                          });
                        },
                      ),

                      // Rotation X
                      Text(
                        'X Rotation Factor: ${_rotationX.toStringAsFixed(1)}',
                      ),
                      Slider(
                        value: _rotationX,
                        min: 0.0,
                        max: 2.0,
                        divisions: 20,
                        onChanged: (value) {
                          setState(() {
                            _rotationX = value;
                          });
                        },
                      ),

                      // Rotation Y
                      Text(
                        'Y Rotation Factor: ${_rotationY.toStringAsFixed(1)}',
                      ),
                      Slider(
                        value: _rotationY,
                        min: 0.0,
                        max: 2.0,
                        divisions: 20,
                        onChanged: (value) {
                          setState(() {
                            _rotationY = value;
                          });
                        },
                      ),

                      const SizedBox(height: 16),

                      // Color Controls
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text('Light Color'),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _colorButton(
                                      Colors.deepPurple.shade200,
                                      true,
                                    ),
                                    _colorButton(Colors.blue.shade200, true),
                                    _colorButton(Colors.red.shade200, true),
                                    _colorButton(Colors.green.shade200, true),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: [
                                const Text('Dark Color'),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _colorButton(
                                      Colors.deepPurple.shade800,
                                      false,
                                    ),
                                    _colorButton(Colors.blue.shade800, false),
                                    _colorButton(Colors.red.shade800, false),
                                    _colorButton(Colors.green.shade800, false),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _colorButton(Color color, bool isLight) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isLight) {
            _lightColor = color;
          } else {
            _darkColor = color;
          }
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color:
                (isLight ? _lightColor : _darkColor) == color
                    ? Colors.white
                    : Colors.transparent,
            width: 3,
          ),
        ),
      ),
    );
  }
}

class D20Painter extends CustomPainter {
  final double rotation;
  final double rotationX;
  final double rotationY;
  final Color lightColor;
  final Color darkColor;

  D20Painter(
    this.rotation,
    this.rotationX,
    this.rotationY,
    this.lightColor,
    this.darkColor,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..style = PaintingStyle.fill
          ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    // Create a 3D-like icosahedron representation
    // We'll draw visible triangular faces with different shades

    // Define the vertices of an icosahedron (simplified 2D projection)
    final vertices = _getIcosahedronVertices(center, radius, rotation);

    // Define faces (triangles) of the icosahedron
    final faces = _getIcosahedronFaces();

    // Sort faces by their z-depth (back to front)
    faces.sort((a, b) {
      final centerA = _getFaceCenter(vertices, a);
      final centerB = _getFaceCenter(vertices, b);
      return centerB.z.compareTo(centerA.z);
    });

    // Draw each face
    for (int i = 0; i < faces.length; i++) {
      final face = faces[i];
      final faceCenter = _getFaceCenter(vertices, face);

      // Skip faces that are facing away (back-face culling)
      if (faceCenter.z < 0) continue;

      // Calculate lighting based on face normal
      final brightness = (faceCenter.z + 1) / 2;
      final color = Color.lerp(darkColor, lightColor, brightness)!;

      paint.color = color;

      final path = Path();
      final v1 = vertices[face[0]];
      final v2 = vertices[face[1]];
      final v3 = vertices[face[2]];

      path.moveTo(v1.x, v1.y);
      path.lineTo(v2.x, v2.y);
      path.lineTo(v3.x, v3.y);
      path.close();

      canvas.drawPath(path, paint);

      // Draw face outline
      paint.color = Colors.black;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 1;
      canvas.drawPath(path, paint);
      paint.style = PaintingStyle.fill;
    }
  }

  List<Vertex3D> _getIcosahedronVertices(
    Offset center,
    double radius,
    double rotation,
  ) {
    final vertices = <Vertex3D>[];
    final phi = (1 + math.sqrt(5)) / 2; // Golden ratio

    // Generate icosahedron vertices
    final coords = [
      [-1, phi, 0],
      [1, phi, 0],
      [-1, -phi, 0],
      [1, -phi, 0],
      [0, -1, phi],
      [0, 1, phi],
      [0, -1, -phi],
      [0, 1, -phi],
      [phi, 0, -1],
      [phi, 0, 1],
      [-phi, 0, -1],
      [-phi, 0, 1],
    ];

    for (final coord in coords) {
      final x = coord[0] * radius * 0.3;
      final y = coord[1] * radius * 0.3;
      final z = coord[2] * radius * 0.3;

      // Apply continuous rotation with configurable factors
      final rotX =
          x * math.cos(rotation * rotationX) -
          z * math.sin(rotation * rotationX);
      final rotZ =
          x * math.sin(rotation * rotationX) +
          z * math.cos(rotation * rotationX);
      final rotY =
          y * math.cos(rotation * rotationY) -
          rotZ * math.sin(rotation * rotationY);
      final finalZ =
          y * math.sin(rotation * rotationY) +
          rotZ * math.cos(rotation * rotationY);

      vertices.add(Vertex3D(center.dx + rotX, center.dy + rotY, finalZ));
    }

    return vertices;
  }

  List<List<int>> _getIcosahedronFaces() {
    return [
      [0, 11, 5],
      [0, 5, 1],
      [0, 1, 7],
      [0, 7, 10],
      [0, 10, 11],
      [1, 5, 9],
      [5, 11, 4],
      [11, 10, 2],
      [10, 7, 6],
      [7, 1, 8],
      [3, 9, 4],
      [3, 4, 2],
      [3, 2, 6],
      [3, 6, 8],
      [3, 8, 9],
      [4, 9, 5],
      [2, 4, 11],
      [6, 2, 10],
      [8, 6, 7],
      [9, 8, 1],
    ];
  }

  Vertex3D _getFaceCenter(List<Vertex3D> vertices, List<int> face) {
    final v1 = vertices[face[0]];
    final v2 = vertices[face[1]];
    final v3 = vertices[face[2]];

    return Vertex3D(
      (v1.x + v2.x + v3.x) / 3,
      (v1.y + v2.y + v3.y) / 3,
      (v1.z + v2.z + v3.z) / 3,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Vertex3D {
  final double x, y, z;

  Vertex3D(this.x, this.y, this.z);
}

class InteractiveRevealWidget extends StatefulWidget {
  final Widget baseChild;
  final Widget revealChild;
  final double width;
  final double height;
  final double radius;

  const InteractiveRevealWidget({
    super.key,
    required this.baseChild,
    required this.revealChild,
    this.width = 400,
    this.height = 300,
    this.radius = 80,
  });

  @override
  _InteractiveRevealWidgetState createState() =>
      _InteractiveRevealWidgetState();
}

class _InteractiveRevealWidgetState extends State<InteractiveRevealWidget> {
  bool _paintMode = false;
  bool _isMouseInside = false;
  Offset _currentMousePos = Offset.zero;
  final List<PaintedArea> _paintedAreas = [];

  void _togglePaintMode() {
    setState(() {
      _paintMode = !_paintMode;
    });
  }

  void _clearPaint() {
    setState(() {
      _paintedAreas.clear();
    });
  }

  void _updateMousePosition(Offset localPosition) {
    // Check if mouse is within widget bounds
    if (localPosition.dx >= 0 &&
        localPosition.dx <= widget.width &&
        localPosition.dy >= 0 &&
        localPosition.dy <= widget.height) {
      setState(() {
        _isMouseInside = true;
        _currentMousePos = localPosition;

        if (_paintMode) {
          // Add current position to painted areas (avoid duplicates nearby)
          bool isDuplicate = _paintedAreas.any(
            (area) => (area.position - localPosition).distance < 30,
          );

          if (!isDuplicate) {
            _paintedAreas.add(
              PaintedArea(position: localPosition, radius: widget.radius),
            );
          }
        }
      });
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset localPosition = renderBox.globalToLocal(
      details.globalPosition,
    );
    _updateMousePosition(localPosition);
  }

  void _onPanEnd(DragEndDetails details) {
    if (!_paintMode) {
      setState(() {
        _isMouseInside = false;
      });
    }
  }

  void _onHover(PointerHoverEvent event) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset localPosition = renderBox.globalToLocal(event.position);
    _updateMousePosition(localPosition);
  }

  void _onExit(PointerExitEvent event) {
    if (!_paintMode) {
      setState(() {
        _isMouseInside = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main reveal widget
        MouseRegion(
          onHover: _onHover,
          onExit: _onExit,
          child: GestureDetector(
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: [
                    // Base child (always visible)
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: widget.baseChild,
                    ),
                    // Reveal child (clipped)
                    ClipPath(
                      clipper: RevealClipper(
                        paintedAreas: _paintedAreas,
                        currentMousePos:
                            _isMouseInside ? _currentMousePos : null,
                        radius: widget.radius,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: widget.revealChild,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Controls
        Positioned(
          top: 10,
          right: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Status indicator
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Paint Mode: ${_paintMode ? 'ON' : 'OFF'}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Toggle button
              ElevatedButton(
                onPressed: _togglePaintMode,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _paintMode ? Color(0xFF4ecdc4) : Color(0xFFff6b6b),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  _paintMode ? 'Disable Paint Mode' : 'Enable Paint Mode',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              // Clear button
              ElevatedButton(
                onPressed: _clearPaint,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 2,
                ),
                child: Text('Clear All', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PaintedArea {
  final Offset position;
  final double radius;

  PaintedArea({required this.position, required this.radius});
}

class RevealClipper extends CustomClipper<Path> {
  final List<PaintedArea> paintedAreas;
  final Offset? currentMousePos;
  final double radius;

  RevealClipper({
    required this.paintedAreas,
    this.currentMousePos,
    required this.radius,
  });

  @override
  Path getClip(Size size) {
    Path path = Path();

    // Add painted areas
    for (PaintedArea area in paintedAreas) {
      path.addOval(Rect.fromCircle(center: area.position, radius: area.radius));
    }

    // Add current mouse position if available
    if (currentMousePos != null) {
      path.addOval(Rect.fromCircle(center: currentMousePos!, radius: radius));
    }

    return path;
  }

  @override
  bool shouldReclip(RevealClipper oldClipper) {
    return paintedAreas != oldClipper.paintedAreas ||
        currentMousePos != oldClipper.currentMousePos;
  }
}
