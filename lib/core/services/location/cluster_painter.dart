import 'dart:ui' as ui;
import 'dart:typed_data' as typed_data;
import 'package:flutter/material.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';



class ClusterIconPainter {
  final int clusterSize;

  ClusterIconPainter(this.clusterSize);

  Future<ui.Image> _createClusterIcon() async {
    const int size = 100;
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder, Rect.fromLTRB(0, 0, size.toDouble(), size.toDouble()));
    final Paint paint = Paint()..color = AppColors.primaryColor;

    // Draw a circle
    canvas.drawCircle(
      const Offset(size / 2, size / 2),
      size / 2.0,
      paint,
    );

    // Draw the cluster size number
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..text = TextSpan(
      text: clusterSize.toString(),
      style: const TextStyle(fontSize: 40, color: Colors.white),
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size - textPainter.width) / 2,
        (size - textPainter.height) / 2,
      ),
    );

    // Finish recording
    final ui.Picture picture = recorder.endRecording();
    return picture.toImage(size, size);
  }

  Future<typed_data.Uint8List> getClusterIconBytes() async {
    final ui.Image image = await _createClusterIcon();
    final typed_data.ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw Exception('Failed to convert image to ByteData.');
    }
    return byteData.buffer.asUint8List();
  }
}
