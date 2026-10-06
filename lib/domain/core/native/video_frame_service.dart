import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class VideoFrameService {
  static const _channel = MethodChannel('general.video_frame');

  /// Extracts a JPEG frame at [timeMs] milliseconds from [videoPath], scales
  /// it to at most [maxHeight] pixels tall, and writes it to a temp file.
  /// Returns the file path, or null on any error.
  static Future<String?> extractFrame(
    String videoPath, {
    int timeMs = 0,
    int maxHeight = 480,
    int quality = 85,
  }) async {
    try {
      final bytes = await _channel.invokeMethod<Uint8List>('extractFrame', {
        'videoPath': videoPath,
        'timeMs': timeMs,
        'maxHeight': maxHeight,
        'quality': quality,
      });
      if (bytes == null) return null;
      final outPath =
          '${Directory.systemTemp.path}/vf_${videoPath.hashCode}_$timeMs.jpg';
      await File(outPath).writeAsBytes(bytes);
      return outPath;
    } catch (_) {
      return null;
    }
  }

  /// Extracts the first keyframe as a display thumbnail.
  static Future<String?> generateThumbnail(
    String videoPath, {
    int maxHeight = 600,
    int quality = 85,
  }) =>
      extractFrame(videoPath, timeMs: 0, maxHeight: maxHeight, quality: quality);
}