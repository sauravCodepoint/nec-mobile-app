import AVFoundation
import Flutter
import UIKit

class VideoFrameChannel {
    static func setup(binaryMessenger: FlutterBinaryMessenger) {
        let channel = FlutterMethodChannel(
            name: "general.video_frame",
            binaryMessenger: binaryMessenger
        )
        channel.setMethodCallHandler { call, result in
            switch call.method {
            case "extractFrame":
                guard let args = call.arguments as? [String: Any],
                      let videoPath = args["videoPath"] as? String
                else { result(nil); return }
                let timeMs    = args["timeMs"]    as? Int ?? 0
                let maxHeight = args["maxHeight"] as? Int ?? 480
                let quality   = args["quality"]   as? Int ?? 85
                Self.extractFrame(
                    videoPath: videoPath,
                    timeMs: timeMs,
                    maxHeight: maxHeight,
                    quality: quality,
                    result: result
                )
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    private static func extractFrame(
        videoPath: String,
        timeMs: Int,
        maxHeight: Int,
        quality: Int,
        result: @escaping FlutterResult
    ) {
        let url = URL(fileURLWithPath: videoPath)
        let asset = AVURLAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        // Respect device rotation encoded in the video track.
        generator.appliesPreferredTrackTransform = true
        // Allow ±0.5 s tolerance so the seek is fast even for sync-only frames.
        let tolerance = CMTime(seconds: 0.5, preferredTimescale: 600)
        generator.requestedTimeToleranceBefore = tolerance
        generator.requestedTimeToleranceAfter  = tolerance

        let time = CMTime(value: CMTimeValue(timeMs), timescale: 1_000)
        do {
            let cgImage = try generator.copyCGImage(at: time, actualTime: nil)
            var image   = UIImage(cgImage: cgImage)

            if Int(image.size.height) > maxHeight {
                let scale   = CGFloat(maxHeight) / image.size.height
                let newSize = CGSize(
                    width:  image.size.width * scale,
                    height: CGFloat(maxHeight)
                )
                let renderer = UIGraphicsImageRenderer(size: newSize)
                image = renderer.image { _ in image.draw(in: CGRect(origin: .zero, size: newSize)) }
            }

            guard let jpegData = image.jpegData(compressionQuality: CGFloat(quality) / 100.0) else {
                result(nil); return
            }
            result(FlutterStandardTypedData(bytes: jpegData))
        } catch {
            result(nil)
        }
    }
}