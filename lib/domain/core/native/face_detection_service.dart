import 'dart:typed_data';

import 'package:flutter/services.dart';

class FaceDetectionService {
  static const _channel = MethodChannel('general.face_detection');

  /// Detects a face in a raw camera frame.
  ///
  /// [bytes] — first plane bytes from [CameraImage].
  /// [width] / [height] — frame dimensions.
  /// [format] — 'bgra8888' (iOS) or 'nv21' (Android).
  static Future<bool> detectFaceInBytes({
    required Uint8List bytes,
    required int width,
    required int height,
    required String format,
  }) async {
    try {
      return await _channel.invokeMethod<bool>('detectFaceInBytes', {
            'bytes': bytes,
            'width': width,
            'height': height,
            'format': format,
          }) ??
          false;
    } catch (_) {
      return false;
    }
  }

  /// Detects a face in a JPEG image file (e.g. a video frame from video_thumbnail).
  static Future<bool> detectFaceInFile(String filePath) async {
    try {
      return await _channel.invokeMethod<bool>('detectFaceInFile', {
            'filePath': filePath,
          }) ??
          false;
    } catch (_) {
      return false;
    }
  }
}