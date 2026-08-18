import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('generate cyberhex icon', () async {
    const size = 512.0;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, size, size));

    // Paint dark cyber background
    final bgPaint = Paint()..color = const Color(0xFF0F111A);
    canvas.drawRect(const Rect.fromLTWH(0, 0, size, size), bgPaint);

    // Draw tech background grid lines
    final gridPaint = Paint()
      ..color = const Color(0xFF1B1E30)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (double i = 0; i <= size; i += 64) {
      canvas.drawLine(Offset(i, 0), Offset(i, size), gridPaint);
      canvas.drawLine(Offset(0, i), Offset(size, i), gridPaint);
    }

    final center = Offset(size / 2, size / 2);

    // Draw glowing outer circles
    final circlePaint = Paint()
      ..color = const Color(0xFF00FFCC).withOpacity(0.08)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 210.0, circlePaint);
    
    // Draw neon outer hexagon
    final outerHexRadius = 180.0;
    final outerHexPath = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 - 30) * pi / 180;
      final x = center.dx + outerHexRadius * cos(angle);
      final y = center.dy + outerHexRadius * sin(angle);
      if (i == 0) {
        outerHexPath.moveTo(x, y);
      } else {
        outerHexPath.lineTo(x, y);
      }
    }
    outerHexPath.close();

    final outerHexGlow = Paint()
      ..color = const Color(0xFF00FFCC).withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10.0);
    canvas.drawPath(outerHexPath, outerHexGlow);

    final outerHexStroke = Paint()
      ..color = const Color(0xFF00FFCC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;
    canvas.drawPath(outerHexPath, outerHexStroke);

    // Draw neon inner hexagon
    final innerHexRadius = 130.0;
    final innerHexPath = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 - 30) * pi / 180;
      final x = center.dx + innerHexRadius * cos(angle);
      final y = center.dy + innerHexRadius * sin(angle);
      if (i == 0) {
        innerHexPath.moveTo(x, y);
      } else {
        innerHexPath.lineTo(x, y);
      }
    }
    innerHexPath.close();

    final innerHexGlow = Paint()
      ..color = const Color(0xFFFF007F).withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);
    canvas.drawPath(innerHexPath, innerHexGlow);

    final innerHexStroke = Paint()
      ..color = const Color(0xFFFF007F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawPath(innerHexPath, innerHexStroke);

    // Draw Hacker Core H-Symbol in center
    final hPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;

    // We'll draw a stylized "H" chip
    final hPath = Path();
    // Left column of H
    hPath.addRect(Rect.fromLTWH(center.dx - 45, center.dy - 50, 20, 100));
    // Right column of H
    hPath.addRect(Rect.fromLTWH(center.dx + 25, center.dy - 50, 20, 100));
    // Center bar of H
    hPath.addRect(Rect.fromLTWH(center.dx - 25, center.dy - 10, 50, 20));

    final hGlow = Paint()
      ..color = const Color(0xFFFF007F).withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12.0);
    canvas.drawPath(hPath, hGlow);
    canvas.drawPath(hPath, hPaint);

    // Draw circuit connector lines
    final circuitPaint = Paint()
      ..color = const Color(0xFF00FFCC)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    // Corner 1: top center
    canvas.drawLine(center + const Offset(0, -112), center + const Offset(0, -155), circuitPaint);
    // Corner 2: bottom center
    canvas.drawLine(center + const Offset(0, 112), center + const Offset(0, 155), circuitPaint);
    
    // Node dots
    final dotPaint = Paint()
      ..color = const Color(0xFF00FFCC)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center + const Offset(0, -155), 7.0, dotPaint);
    canvas.drawCircle(center + const Offset(0, 155), 7.0, dotPaint);

    // Convert to PNG image
    final picture = recorder.endRecording();
    final img = await picture.toImage(size.toInt(), size.toInt());
    final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);
    final buffer = pngBytes!.buffer.asUint8List();

    // Save image to assets/icon/icon.png
    final dir = Directory('assets/icon');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    final file = File('assets/icon/icon.png');
    await file.writeAsBytes(buffer);
    print('ICON GENERATED SUCCESS AT: ${file.absolute.path}');
  });
}
