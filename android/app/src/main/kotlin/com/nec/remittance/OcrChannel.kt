package com.nec.remittance

import android.content.Context
import android.net.Uri
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.text.TextRecognition
import com.google.mlkit.vision.text.latin.TextRecognizerOptions
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.io.File

object OcrChannel {
    private const val CHANNEL = "general.ocr"

    fun setup(messenger: BinaryMessenger, context: Context) {
        val recognizer = TextRecognition.getClient(TextRecognizerOptions.DEFAULT_OPTIONS)

        MethodChannel(messenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                // Full OCR — used after capture
                "extractText" -> {
                    val path = call.argument<String>("imagePath")
                    if (path == null) { result.success(""); return@setMethodCallHandler }
                    try {
                        val image = InputImage.fromFilePath(context, Uri.fromFile(File(path)))
                        recognizer.process(image)
                            .addOnSuccessListener { text -> result.success(text.text) }
                            .addOnFailureListener { result.success("") }
                    } catch (e: Exception) { result.success("") }
                }

                // Lightweight presence check via file — used for iOS parity
                "detectText" -> {
                    val path = call.argument<String>("imagePath")
                    if (path == null) { result.success(false); return@setMethodCallHandler }
                    try {
                        val image = InputImage.fromFilePath(context, Uri.fromFile(File(path)))
                        recognizer.process(image)
                            .addOnSuccessListener { text -> result.success(text.text.isNotEmpty()) }
                            .addOnFailureListener { result.success(false) }
                    } catch (e: Exception) { result.success(false) }
                }

                // Lightweight presence check via raw NV21 bytes — live frame detection
                "detectFromBytes" -> {
                    val bytes = call.argument<ByteArray>("bytes")
                    val width = call.argument<Int>("width")
                    val height = call.argument<Int>("height")
                    if (bytes == null || width == null || height == null) {
                        result.success(false); return@setMethodCallHandler
                    }
                    try {
                        val image = InputImage.fromByteArray(
                            bytes, width, height, 0,
                            InputImage.IMAGE_FORMAT_NV21
                        )
                        recognizer.process(image)
                            .addOnSuccessListener { text -> result.success(text.text.isNotEmpty()) }
                            .addOnFailureListener { result.success(false) }
                    } catch (e: Exception) { result.success(false) }
                }

                else -> result.notImplemented()
            }
        }
    }
}