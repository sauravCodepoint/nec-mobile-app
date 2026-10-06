import AVFoundation
import Flutter
import UIKit

class VideoCompressChannel {
    static func setup(binaryMessenger: FlutterBinaryMessenger) {
        let channel = FlutterMethodChannel(
            name: "general.video_compress",
            binaryMessenger: binaryMessenger
        )
        channel.setMethodCallHandler { call, result in
            switch call.method {
            case "compress":
                guard let args = call.arguments as? [String: Any],
                      let videoPath = args["videoPath"] as? String
                else { result(nil); return }
                let maxHeight = args["maxHeight"] as? Int ?? 720
                // `bitrate` is Android-only: AVAssetExportSession picks its own
                // bitrate from the preset and exposes no override.
                Self.compress(videoPath: videoPath, maxHeight: maxHeight, result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    private static func compress(
        videoPath: String,
        maxHeight: Int,
        result: @escaping FlutterResult
    ) {
        guard FileManager.default.fileExists(atPath: videoPath) else { result(nil); return }
        let asset = AVURLAsset(url: URL(fileURLWithPath: videoPath))

        // Export presets fit the frame inside the named box and never scale up,
        // so a clip already below the target passes through at its own size.
        let preset: String
        switch maxHeight {
        case ..<540: preset = AVAssetExportPreset640x480
        case ..<720: preset = AVAssetExportPreset960x540
        default:     preset = AVAssetExportPreset1280x720
        }

        guard let session = AVAssetExportSession(asset: asset, presetName: preset) else {
            result(nil); return
        }

        let outURL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent("vc_\(UUID().uuidString).mp4")
        session.outputURL = outURL
        session.outputFileType = .mp4
        session.shouldOptimizeForNetworkUse = true

        // exportAsynchronously/status are soft-deprecated in iOS 18 in favour of
        // the async `export(to:as:)`, which needs iOS 18; the deployment target
        // here is 15.0, so this stays the only available path.
        session.exportAsynchronously {
            let status = session.status
            // The completion handler runs on an arbitrary queue — hop to main so
            // the Flutter reply is delivered on the platform thread.
            DispatchQueue.main.async {
                if status == .completed, FileManager.default.fileExists(atPath: outURL.path) {
                    result(outURL.path)
                } else {
                    try? FileManager.default.removeItem(at: outURL)
                    result(nil)
                }
            }
        }
    }
}
