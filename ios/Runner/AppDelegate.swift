import Flutter
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Required by flutter_local_notifications so foreground notifications
    // are presented and taps are delivered back to Dart.
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    let ocrRegistrar = engineBridge.pluginRegistry.registrar(forPlugin: "OcrChannel")!
    OcrChannel.setup(binaryMessenger: ocrRegistrar.messenger())
    let faceRegistrar = engineBridge.pluginRegistry.registrar(forPlugin: "FaceDetectionChannel")!
    FaceDetectionChannel.setup(binaryMessenger: faceRegistrar.messenger())
    let frameRegistrar = engineBridge.pluginRegistry.registrar(forPlugin: "VideoFrameChannel")!
    VideoFrameChannel.setup(binaryMessenger: frameRegistrar.messenger())
    let deviceIdentityRegistrar = engineBridge.pluginRegistry.registrar(forPlugin: "DeviceIdentityChannel")!
    DeviceIdentityChannel.setup(binaryMessenger: deviceIdentityRegistrar.messenger())
    let videoCompressRegistrar = engineBridge.pluginRegistry.registrar(forPlugin: "VideoCompressChannel")!
    VideoCompressChannel.setup(binaryMessenger: videoCompressRegistrar.messenger())
  }
}
