import 'package:flutter/services.dart';

/// Hardware-accelerated video transcoding over the platform's own encoder —
/// `AVAssetExportSession` on iOS, `androidx.media3` `Transformer` on Android.
///
/// Replaces the `video_compress` plugin, which never adopted Swift Package
/// Manager and was the last CocoaPods dependency left in the iOS build.
class VideoCompressService {
  static const _channel = MethodChannel('general.video_compress');

  /// Transcodes [videoPath] into a new H.264/AAC MP4 in the platform temp
  /// directory, scaled down to at most [maxHeight] pixels tall (never scaled
  /// up — a clip already below the target keeps its own resolution).
  ///
  /// [bitrate] is Android-only; on iOS the bitrate follows from the export
  /// preset that [maxHeight] selects, as `AVAssetExportSession` exposes no
  /// bitrate control.
  ///
  /// Returns the output path, or null on any error — including a missing
  /// native implementation or the [timeout] elapsing — leaving the source
  /// file untouched so the caller can fall back to it.
  static Future<String?> compress(
    String videoPath, {
    int maxHeight = 720,
    int bitrate = 2000000,
    Duration timeout = const Duration(seconds: 90),
  }) async {
    try {
      return await _channel.invokeMethod<String>('compress', {
        'videoPath': videoPath,
        'maxHeight': maxHeight,
        'bitrate': bitrate,
      }).timeout(timeout);
    } catch (_) {
      return null;
    }
  }
}
