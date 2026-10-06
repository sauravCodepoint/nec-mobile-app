import 'dart:io';
import 'dart:isolate';

import 'package:image/image.dart' as img;
import '../native/video_compress_service.dart';

/// Compresses images and videos before upload.
///
/// Image: decoded in a separate isolate, resized to ≤ 1280 px, re-encoded at
/// JPEG 85 — keeps document text crisp while halving typical file size.
///
/// Video: uses the platform's hardware encoder (AVFoundation / MediaCodec)
/// via [VideoCompressService] — caps the frame at 720 p and re-encodes to
/// H.264/AAC at a lower bitrate, typically reducing a 5-second clip from
/// ~15 MB to ~1–3 MB.
///
/// Both methods fall back to the original file on any error so the upload
/// never fails due to a compression problem.
class MediaCompressor {
  // ── Image ──────────────────────────────────────────────────────────────────

  /// Returns a compressed copy of [file] as a JPEG, or [file] itself on error.
  /// The caller is responsible for deleting the returned file after upload when
  /// `returnedFile.path != file.path`.
  static Future<File> compressImage(File file) async {
    try {
      final outPath = await Isolate.run(() => _processImage(file.path));
      if (outPath != null) return File(outPath);
    } catch (_) {}
    return file;
  }

  // Static so the Dart runtime can send it across isolate boundaries.
  static Future<String?> _processImage(String path) async {
    final bytes = await File(path).readAsBytes();
    final source = img.decodeImage(bytes);
    if (source == null) return null;

    img.Image out = source;
    const maxDim = 1280;
    if (source.width > maxDim || source.height > maxDim) {
      out = source.width >= source.height
          ? img.copyResize(source, width: maxDim)
          : img.copyResize(source, height: maxDim);
    }

    final encoded = img.encodeJpg(out, quality: 85);
    final stem = path.split('/').last.replaceAll(RegExp(r'\.[^.]+$'), '');
    final outPath = '${File(path).parent.path}/${stem}_c.jpg';
    await File(outPath).writeAsBytes(encoded);
    return outPath;
  }

  // ── Video ──────────────────────────────────────────────────────────────────

  /// Returns a compressed copy of [file], or [file] itself on error.
  /// The caller is responsible for deleting the returned file after upload when
  /// `returnedFile.path != file.path`.
  static Future<File> compressVideo(File file) async {
    try {
      final outPath = await VideoCompressService.compress(file.path);
      if (outPath != null) {
        final compressed = File(outPath);
        if (compressed.existsSync()) {
          // A short, already-modest clip can come out larger than it went in;
          // upload the original in that case and drop the transcode.
          if (compressed.lengthSync() < file.lengthSync()) return compressed;
          await compressed.delete();
        }
      }
    } catch (_) {}
    return file;
  }
}
