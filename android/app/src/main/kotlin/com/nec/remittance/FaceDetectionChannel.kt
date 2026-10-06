package com.nec.remittance

import android.content.Context
import android.graphics.BitmapFactory
import android.graphics.ImageFormat
import android.graphics.Rect
import android.graphics.YuvImage
import android.net.Uri
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.face.FaceDetection
import com.google.mlkit.vision.face.FaceDetectorOptions
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.io.File

object FaceDetectionChannel {
    private const val CHANNEL = "general.face_detection"

    fun setup(messenger: BinaryMessenger, context: Context) {
        val options = FaceDetectorOptions.Builder()
            .setPerformanceMode(FaceDetectorOptions.PERFORMANCE_MODE_FAST)
            .setClassificationMode(FaceDetectorOptions.CLASSIFICATION_MODE_NONE)
            .setLandmarkMode(FaceDetectorOptions.LANDMARK_MODE_NONE)
            .build()
        val detector = FaceDetection.getClient(options)

        MethodChannel(messenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {

                // Live camera frame — raw NV21 bytes from Flutter camera plugin
                "detectFaceInBytes" -> {
                    val bytes = call.argument<ByteArray>("bytes")
                    val width = call.argument<Int>("width")
                    val height = call.argument<Int>("height")
                    if (bytes == null || width == null || height == null) {
                        result.success(false); return@setMethodCallHandler
                    }
                    try {
                        // NV21 → JPEG → InputImage (cleanest path for ML Kit)
                        val yuv = YuvImage(bytes, ImageFormat.NV21, width, height, null)
                        val stream = ByteArrayOutputStream()
                        yuv.compressToJpeg(Rect(0, 0, width, height), 70, stream)
                        val jpeg = stream.toByteArray()
                        val bitmap = BitmapFactory.decodeByteArray(jpeg, 0, jpeg.size)
                            ?: run { result.success(false); return@setMethodCallHandler }
                        val image = InputImage.fromBitmap(bitmap, 270) // front camera rotation
                        detector.process(image)
                            .addOnSuccessListener { faces -> result.success(faces.isNotEmpty()) }
                            .addOnFailureListener { result.success(false) }
                    } catch (e: Exception) { result.success(false) }
                }

                // Post-recording validation — JPEG file path (from VideoFrameChannel)
                "detectFaceInFile" -> {
                    val filePath = call.argument<String>("filePath")
                    if (filePath == null) { result.success(false); return@setMethodCallHandler }
                    try {
                        val image = InputImage.fromFilePath(
                            context,
                            Uri.fromFile(File(filePath))
                        )
                        detector.process(image)
                            .addOnSuccessListener { faces -> result.success(faces.isNotEmpty()) }
                            .addOnFailureListener { result.success(false) }
                    } catch (e: Exception) { result.success(false) }
                }

                else -> result.notImplemented()
            }
        }
    }
}