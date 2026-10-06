import Flutter
import UIKit
import Vision

class OcrChannel {
    static func setup(binaryMessenger: FlutterBinaryMessenger) {
        let channel = FlutterMethodChannel(
            name: "general.ocr",
            binaryMessenger: binaryMessenger
        )
        channel.setMethodCallHandler { call, result in
            guard let args = call.arguments as? [String: Any],
                  let imagePath = args["imagePath"] as? String
            else {
                result(FlutterMethodNotImplemented)
                return
            }
            switch call.method {
            case "extractText":
                Self.recognizeText(imagePath: imagePath, result: result)
            case "detectText":
                Self.detectTextPresence(imagePath: imagePath, result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    // Full OCR — used after capture
    private static func recognizeText(imagePath: String, result: @escaping FlutterResult) {
        guard let image = UIImage(contentsOfFile: imagePath),
              let cgImage = image.cgImage
        else { result(""); return }

        let request = VNRecognizeTextRequest { req, error in
            guard error == nil,
                  let observations = req.results as? [VNRecognizedTextObservation]
            else { result(""); return }
            let text = observations
                .compactMap { $0.topCandidates(1).first?.string }
                .joined(separator: "\n")
            result(text)
        }
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = false

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do { try handler.perform([request]) } catch { result("") }
    }

    // Lightweight presence check — used for live frame detection.
    //
    // Uses the text *recognizer* (not the deprecated rectangle detector),
    // matching Android's "is there actual recognizable text?" semantics — the
    // rectangle detector was far too flaky to reliably trip the aligned state.
    //
    // `.accurate` (not `.fast`): the EID *back* trips easily because its dense,
    // high-contrast MRZ is very OCR-friendly, but the glossy/holographic *front*
    // produces glare and sparser text that `.fast` kept missing. `.accurate`
    // reads low-contrast text far more reliably, and a lowered `minimumTextHeight`
    // lets the front's smaller fields register. It runs at most ~1×/sec (the Dart
    // side throttles frames), so the extra cost is fine.
    //
    // The live frame is the raw BGRA sensor buffer, which is landscape while the
    // device is held in portrait, so a card filling the guide is rotated 90°.
    // `.right` re-orients it upright before recognition. (The post-capture path
    // above takes an already-oriented JPEG, so it must NOT apply this.)
    private static func detectTextPresence(imagePath: String, result: @escaping FlutterResult) {
        guard let image = UIImage(contentsOfFile: imagePath),
              let cgImage = image.cgImage
        else { result(false); return }

        let request = VNRecognizeTextRequest { req, error in
            guard error == nil,
                  let observations = req.results as? [VNRecognizedTextObservation]
            else { result(false); return }
            let hasText = observations.contains { obs in
                guard let s = obs.topCandidates(1).first?.string else { return false }
                return !s.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }
            result(hasText)
        }
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = false
        request.minimumTextHeight = 0.01

        let handler = VNImageRequestHandler(
            cgImage: cgImage, orientation: .right, options: [:]
        )
        do { try handler.perform([request]) } catch { result(false) }
    }
}