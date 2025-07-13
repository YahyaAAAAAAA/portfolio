import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/global_colors.dart';

/// A wrapper widget that adds grid-based mouse trail effects to any child widget
class GridMouseTrail extends StatefulWidget {
  final Widget child;
  final Color trailColor;
  final double cellSize;
  final int startingAlpha;
  final double probOfNeighbor;
  final int fadePerFrame;
  final bool enabled;

  const GridMouseTrail({
    super.key,
    required this.child,
    // this.trailColor = const Color(0xFF7A5C9E),
    this.trailColor = GColors.purple,
    this.cellSize = 15,
    this.startingAlpha = 100,
    this.probOfNeighbor = 0.3,
    this.fadePerFrame = 5,
    this.enabled = true,
  });

  @override
  State<GridMouseTrail> createState() => _GridMouseTrailState();
}

class _GridMouseTrailState extends State<GridMouseTrail>
    with TickerProviderStateMixin {
  List<GridCell> allNeighbors = [];
  int currentRow = -2;
  int currentCol = -2;
  late AnimationController _controller;
  int numRows = 0;
  int numCols = 0;
  Size? lastSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 16), // ~60 FPS
      vsync: this,
    )..addListener(() {
      if (!widget.enabled) return;

      setState(() {
        // Update all neighbors - decrease opacity
        for (var neighbor in allNeighbors) {
          neighbor.opacity = math.max(
            0,
            neighbor.opacity - widget.fadePerFrame,
          );
        }

        // Remove neighbors with zero opacity
        allNeighbors.removeWhere((neighbor) => neighbor.opacity <= 0);
      });
    });

    if (widget.enabled) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(GridMouseTrail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled && !oldWidget.enabled) {
      _controller.repeat();
    } else if (!widget.enabled && oldWidget.enabled) {
      _controller.stop();
      setState(() {
        allNeighbors.clear();
      });
    }
  }

  void _updateGridSize(Size size) {
    if (lastSize != size) {
      numRows = (size.height / widget.cellSize).ceil();
      numCols = (size.width / widget.cellSize).ceil();
      lastSize = size;
    }
  }

  void _onMouseMove(Offset position, Size size) {
    if (!widget.enabled) return;

    _updateGridSize(size);

    // Calculate the row and column of the cell that the mouse is currently over
    int row = (position.dy / widget.cellSize).floor();
    int col = (position.dx / widget.cellSize).floor();

    // Check if the mouse has moved to a different cell
    if (row != currentRow || col != currentCol) {
      currentRow = row;
      currentCol = col;

      // Add the current cell to the allNeighbors array so it gets faded out
      allNeighbors.add(
        GridCell(row: row, col: col, opacity: widget.startingAlpha),
      );

      // Add new neighbors to the allNeighbors array
      List<GridCell> newNeighbors = _getRandomNeighbors(row, col);
      allNeighbors.addAll(newNeighbors);
    }
  }

  List<GridCell> _getRandomNeighbors(int row, int col) {
    List<GridCell> neighbors = [];

    // Loop through the cells surrounding the given cell (row, col)
    for (int dRow = -1; dRow <= 1; dRow++) {
      for (int dCol = -1; dCol <= 1; dCol++) {
        // Calculate the neighboring cell's row and column indices
        int neighborRow = row + dRow;
        int neighborCol = col + dCol;

        // Check if the current cell in the loop is the given cell (row, col)
        bool isCurrentCell = dRow == 0 && dCol == 0;

        // Check if the neighboring cell is within the grid boundaries
        bool isInBounds =
            neighborRow >= 0 &&
            neighborRow < numRows &&
            neighborCol >= 0 &&
            neighborCol < numCols;

        // If the cell is not the given cell, is within bounds, and has the specified chance,
        // add the neighboring cell to the neighbors array
        if (!isCurrentCell &&
            isInBounds &&
            math.Random().nextDouble() < widget.probOfNeighbor) {
          neighbors.add(
            GridCell(row: neighborRow, col: neighborCol, opacity: 100),
          );
        }
      }
    }

    return neighbors;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _updateGridSize(size);

        return ClipRRect(
          borderRadius: BorderRadius.circular(kOuterBorderRadius),
          child: MouseRegion(
            onHover:
                widget.enabled
                    ? (event) => _onMouseMove(event.localPosition, size)
                    : null,
            child: Stack(
              children: [
                if (widget.enabled)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(
                        painter: GridTrailPainter(
                          allNeighbors: allNeighbors,
                          currentRow: currentRow,
                          currentCol: currentCol,
                          cellSize: widget.cellSize,
                          trailColor: widget.trailColor,
                          startingAlpha: widget.startingAlpha,
                          size: size,
                        ),
                      ),
                    ),
                  ),
                widget.child,
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class GridCell {
  final int row;
  final int col;
  int opacity;

  GridCell({required this.row, required this.col, required this.opacity});
}

class GridTrailPainter extends CustomPainter {
  final List<GridCell> allNeighbors;
  final int currentRow;
  final int currentCol;
  final double cellSize;
  final Color trailColor;
  final int startingAlpha;
  final Size size;

  GridTrailPainter({
    required this.allNeighbors,
    required this.currentRow,
    required this.currentCol,
    required this.cellSize,
    required this.trailColor,
    required this.startingAlpha,
    required this.size,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    // Draw all cells (including the current cell) with their respective opacities
    for (var neighbor in allNeighbors) {
      double neighborX = neighbor.col * cellSize;
      double neighborY = neighbor.row * cellSize;

      final neighborPaint =
          Paint()
            ..color = trailColor.withValues(alpha: neighbor.opacity / 255.0)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.8;

      canvas.drawRect(
        Rect.fromLTWH(neighborX, neighborY, cellSize, cellSize),
        neighborPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
