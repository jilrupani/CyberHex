import 'dart:math';
import 'package:flutter/material.dart';
import '../models/game_models.dart';
import '../theme/cyber_theme.dart';

class HexGridPainter extends CustomPainter {
  final List<NodeModel> nodes;
  final HexCoords playerCoords;
  final HexCoords? droneCoords;
  final List<HexCoords> dronePatrolPath;
  final double hexSize;
  final Offset gridOffset;
  final HexCoords? selectedCoords;

  HexGridPainter({
    required this.nodes,
    required this.playerCoords,
    required this.droneCoords,
    this.dronePatrolPath = const [],
    required this.hexSize,
    required this.gridOffset,
    this.selectedCoords,
  });

  // Calculate pixel position from axial coordinates
  Offset hexToPixel(HexCoords coords) {
    final x = hexSize * (sqrt(3) * coords.q + sqrt(3) / 2 * coords.r) + gridOffset.dx;
    final y = hexSize * (3.0 / 2.0 * coords.r) + gridOffset.dy;
    return Offset(x, y);
  }

  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    const double dashWidth = 6.0;
    const double dashSpace = 4.0;
    final double distance = (p2 - p1).distance;
    if (distance == 0) return;
    final double dx = (p2.dx - p1.dx) / distance;
    final double dy = (p2.dy - p1.dy) / distance;
    double currentDist = 0.0;
    while (currentDist < distance) {
      final double endX = p1.dx + dx * min(currentDist + dashWidth, distance);
      final double endY = p1.dy + dy * min(currentDist + dashWidth, distance);
      canvas.drawLine(
        Offset(p1.dx + dx * currentDist, p1.dy + dy * currentDist),
        Offset(endX, endY),
        paint,
      );
      currentDist += dashWidth + dashSpace;
    }
  }

  // Draw a hexagon path at a given center
  Path getHexPath(Offset center, double radius) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 - 30) * pi / 180;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw connection lines between neighbor nodes
    final linePaint = Paint()
      ..color = const Color(0xFF1D2845)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final hackedLinePaint = Paint()
      ..color = CyberTheme.primaryCyan.withOpacity(0.5)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final Set<String> drawnConnections = {};

    for (var node in nodes) {
      final fromPixel = hexToPixel(node.coords);
      for (var neighborCoords in node.coords.neighbors) {
        // Find if neighbor exists in grid
        final hasNeighbor = nodes.any((n) => n.coords == neighborCoords);
        if (hasNeighbor) {
          final connectionKey = node.coords.hashCode < neighborCoords.hashCode
              ? '${node.coords}-${neighborCoords}'
              : '${neighborCoords}-${node.coords}';

          if (!drawnConnections.contains(connectionKey)) {
            drawnConnections.add(connectionKey);
            final toPixel = hexToPixel(neighborCoords);
            final neighborNode = nodes.firstWhere((n) => n.coords == neighborCoords);
            
            // If both nodes are hacked/visited, highlight the path
            if (node.isHacked && neighborNode.isHacked) {
              canvas.drawLine(fromPixel, toPixel, hackedLinePaint);
            } else {
              canvas.drawLine(fromPixel, toPixel, linePaint);
            }
          }
        }
      }
    }

    // 2. Draw nodes
    for (var node in nodes) {
      final center = hexToPixel(node.coords);
      final path = getHexPath(center, hexSize * 0.9);

      // Node background
      final fillPaint = Paint()
        ..color = node.isHacked
            ? CyberTheme.primaryCyan.withOpacity(0.06)
            : CyberTheme.cardBackground
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, fillPaint);

      // Node border
      Color borderColor = const Color(0xFF283655);
      double borderWidth = 2.0;

      if (node.type == NodeType.port) {
        borderColor = CyberTheme.secondaryMagenta;
        borderWidth = 3.0;
      } else if (node.type == NodeType.firewall) {
        borderColor = CyberTheme.errorRed;
        borderWidth = 2.5;
      } else if (node.type == NodeType.core && !node.isHacked) {
        borderColor = CyberTheme.successGreen;
        borderWidth = 2.5;
      } else if (node.coords == selectedCoords) {
        borderColor = Colors.white;
        borderWidth = 3.0;
      }

      final borderPaint = Paint()
        ..color = borderColor
        ..strokeWidth = borderWidth
        ..style = PaintingStyle.stroke;
      
      // Draw neon border glow if highlighted
      if (node.type == NodeType.port || (node.type == NodeType.core && !node.isHacked) || node.type == NodeType.firewall) {
        final glowPaint = Paint()
          ..color = borderColor.withOpacity(0.3)
          ..strokeWidth = borderWidth + 4
          ..style = PaintingStyle.stroke
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6.0);
        canvas.drawPath(path, glowPaint);
      }
      
      canvas.drawPath(path, borderPaint);

      // 3. Draw content inside nodes based on node type
      if (node.type == NodeType.core && !node.isHacked) {
        // Draw data core symbol (rotating square or circuit core)
        final corePaint = Paint()
          ..color = CyberTheme.successGreen
          ..style = PaintingStyle.fill;
        canvas.drawCircle(center, hexSize * 0.3, corePaint);

        // Core glow
        final coreGlow = Paint()
          ..color = CyberTheme.successGreen.withOpacity(0.4)
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);
        canvas.drawCircle(center, hexSize * 0.45, coreGlow);
        
        // Draw credit label
        final textPainter = TextPainter(
          text: TextSpan(
            text: '+${node.coreValue}',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(canvas, center - Offset(textPainter.width / 2, textPainter.height / 2));
      } else if (node.type == NodeType.port) {
        // Draw escape portal (concentric circles)
        final pPaint = Paint()
          ..color = CyberTheme.secondaryMagenta
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0;
        
        canvas.drawCircle(center, hexSize * 0.4, pPaint);
        canvas.drawCircle(center, hexSize * 0.25, pPaint..strokeWidth = 2.0);
        
        final centerDot = Paint()
          ..color = CyberTheme.secondaryMagenta
          ..style = PaintingStyle.fill;
        canvas.drawCircle(center, hexSize * 0.1, centerDot);
      } else if (node.type == NodeType.firewall) {
        // Draw firewall warning symbol
        final fPaint = Paint()
          ..color = CyberTheme.errorRed
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0;

        final fPath = Path();
        fPath.moveTo(center.dx, center.dy - hexSize * 0.4);
        fPath.lineTo(center.dx - hexSize * 0.35, center.dy + hexSize * 0.25);
        fPath.lineTo(center.dx + hexSize * 0.35, center.dy + hexSize * 0.25);
        fPath.close();
        canvas.drawPath(fPath, fPaint);

        // Draw an '!' inside
        final textPainter = TextPainter(
          text: const TextSpan(
            text: '!',
            style: TextStyle(
              color: CyberTheme.errorRed,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(canvas, center - Offset(textPainter.width / 2, textPainter.height * 0.6));
      } else if (node.type == NodeType.start) {
        // Start node indicator
        final sPaint = Paint()
          ..color = CyberTheme.primaryCyan.withOpacity(0.3)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(center, hexSize * 0.3, sPaint);
      }
    }

    // 3.5. Draw drone patrol path lines and markers
    if (dronePatrolPath.isNotEmpty && dronePatrolPath.length > 1) {
      final pathPaint = Paint()
        ..color = CyberTheme.accentAmber.withOpacity(0.25)
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      final pathMarkerPaint = Paint()
        ..color = CyberTheme.accentAmber.withOpacity(0.12)
        ..style = PaintingStyle.fill;

      // Draw dashed loop lines connecting the patrol nodes
      for (int i = 0; i < dronePatrolPath.length; i++) {
        final p1 = hexToPixel(dronePatrolPath[i]);
        final p2 = hexToPixel(dronePatrolPath[(i + 1) % dronePatrolPath.length]);
        _drawDashedLine(canvas, p1, p2, pathPaint);
      }

      // Draw node center markers to visualize path steps
      for (var coord in dronePatrolPath) {
        if (coord != droneCoords) {
          canvas.drawCircle(hexToPixel(coord), hexSize * 0.12, pathMarkerPaint);
        }
      }
    }

    // 4. Draw security drone if it exists
    if (droneCoords != null) {
      final dCenter = hexToPixel(droneCoords!);
      
      // Drone threat radar ring
      final radarPaint = Paint()
        ..color = CyberTheme.accentAmber.withOpacity(0.15)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(dCenter, hexSize * 0.9, radarPaint);

      // Radar glow border
      final radarBorder = Paint()
        ..color = CyberTheme.accentAmber
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(dCenter, hexSize * 0.9, radarBorder);

      // Inner Core
      final dPaint = Paint()
        ..color = CyberTheme.accentAmber
        ..style = PaintingStyle.fill;
      canvas.drawCircle(dCenter, hexSize * 0.35, dPaint);

      // Draw Drone Eye symbol
      final eyePaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.fill;
      canvas.drawCircle(dCenter, hexSize * 0.15, eyePaint);
    }

    // 5. Draw player node indicator
    final pCenter = hexToPixel(playerCoords);
    final pPaint = Paint()
      ..color = CyberTheme.primaryCyan
      ..style = PaintingStyle.fill;

    // Glowing core
    final pGlow = Paint()
      ..color = CyberTheme.primaryCyan.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12.0);
    canvas.drawCircle(pCenter, hexSize * 0.6, pGlow);

    // Draw stylized cross-hair cursor
    canvas.drawCircle(pCenter, hexSize * 0.3, pPaint);
    
    final crossPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;
    
    canvas.drawLine(pCenter + Offset(-hexSize * 0.2, 0), pCenter + Offset(hexSize * 0.2, 0), crossPaint);
    canvas.drawLine(pCenter + Offset(0, -hexSize * 0.2), pCenter + Offset(0, hexSize * 0.2), crossPaint);
  }

  @override
  bool shouldRepaint(covariant HexGridPainter oldDelegate) {
    return oldDelegate.nodes != nodes ||
        oldDelegate.playerCoords != playerCoords ||
        oldDelegate.droneCoords != droneCoords ||
        oldDelegate.dronePatrolPath != dronePatrolPath ||
        oldDelegate.hexSize != hexSize ||
        oldDelegate.gridOffset != gridOffset ||
        oldDelegate.selectedCoords != selectedCoords;
  }
}
