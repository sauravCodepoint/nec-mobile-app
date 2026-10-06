package com.nec.remittance

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        OcrChannel.setup(flutterEngine.dartExecutor.binaryMessenger, applicationContext)
        FaceDetectionChannel.setup(flutterEngine.dartExecutor.binaryMessenger, applicationContext)
        VideoFrameChannel.setup(flutterEngine.dartExecutor.binaryMessenger, applicationContext)
        VideoCompressChannel.setup(flutterEngine.dartExecutor.binaryMessenger, applicationContext)
    }
}
