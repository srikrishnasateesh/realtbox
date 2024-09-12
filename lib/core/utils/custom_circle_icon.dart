import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Create a custom circle icon using Canvas
  Future<BitmapDescriptor> createCustomCircleIcon(double size, Color color) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = color;

    // Draw the circle
    canvas.drawCircle(
      Offset(size / 2, size / 2),
      size / 2,
      paint,
    );

    // Convert to image
    final ui.Image image = await pictureRecorder
        .endRecording()
        .toImage(size.toInt(), size.toInt());

    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageData = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(imageData);
  }