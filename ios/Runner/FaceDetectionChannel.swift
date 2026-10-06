import Flutter
import UIKit
import Vision

class FaceDetectionChannel {
    static func setup(binaryMessenger: FlutterBinaryMessenger) {
        let channel = FlutterMethodChannel(
            name: "general.face_detection",
            binaryMessenger: binaryMessenger
        )
        channel.setMethodCallHandler { call, result in
            switch call.method {

            // Live camera frame — raw BGRA8888 bytes from Flutter camera plugin
            case "detectFaceInBytes":
                guard let args = call.arguments as? [String: Any],
                      let data = (args["bytes"] as? FlutterStandardTypedData)?.data,
                      let width = args["width"] as? Int,
                      let height = args["height"] as? Int
                else { result(false); return }
                Self.detectInBGRA(data: data, width: width, height: height, result: result)

            // Post-recording validation — JPEG file path (from VideoFrameChannel)
            case "detectFaceInFile":
                guard let args = call.arguments as? [String: Any],
                      let filePath = args["filePath"] as? String
                else { result(false); return }
                Self.detectInFile(filePath: filePath, result: result)

            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    // BGRA8888 bytes → CGImage → Vision face detection.
    // iOS front-camera frames arrive in landscape (sensor orientation = 90°).
    // Passing .rightMirrored tells Vision to rotate+mirror before analysing.
    private static func detectInBGRA(
        data: Data, width: Int, height: Int,
        result: @escaping FlutterResult
    ) {
        guard
            let provider = CGDataProvider(data: data as CFData),
            let cgImage = CGImage(
                width: width,
                height: height,
                bitsPerComponent: 8,
                bitsPerPixel: 32,
                bytesPerRow: width * 4,
                space: CGColorSpaceCreateDeviceRGB(),
                bitmapInfo: CGBitmapInfo(rawValue:
                    CGImageAlphaInfo.premultipliedFirst.rawValue |
                    CGBitmapInfo.byteOrder32Little.rawValue),
                provider: provider,
                decode: nil,
                shouldInterpolate: false,
                intent: .defaultIntent
            )
        else { result(false); return }

        let request = VNDetectFaceRectanglesRequest { req, error in
            guard error == nil,
                  let faces = req.results as? [VNFaceObservation]
            else { result(false); return }
            result(!faces.isEmpty)
        }

        let handler = VNImageRequestHandler(
            cgImage: cgImage,
            orientation: .rightMirrored, // front camera, portrait hold
            options: [:]
        )
        do { try handler.perform([request]) } catch { result(false) }
    }

    // File-based detection (JPEG from VideoFrameChannel frame extraction).
    private static func detectInFile(
        filePath: String,
        result: @escaping FlutterResult
    ) {
        guard let image = UIImage(contentsOfFile: filePath),
              let cgImage = image.cgImage
        else { result(false); return }

        let request = VNDetectFaceRectanglesRequest { req, error in
            guard error == nil,
                  let faces = req.results as? [VNFaceObservation]
            else { result(false); return }
            result(!faces.isEmpty)
        }

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do { try handler.perform([request]) } catch { result(false) }
    }
}