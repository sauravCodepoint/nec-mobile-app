package com.nec.remittance

import android.content.Context
import android.graphics.Bitmap
import android.media.MediaMetadataRetriever
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

object VideoFrameChannel {
    private const val CHANNEL = "general.video_frame"

    fun setup(messenger: BinaryMessenger, @Suppress("UNUSED_PARAMETER") context: Context) {
        MethodChannel(messenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "extractFrame" -> {
                    val videoPath = call.argument<String>("videoPath")
                    val timeMs    = call.argument<Int>("timeMs") ?: 0
                    val maxHeight = call.argument<Int>("maxHeight") ?: 480
                    val quality   = call.argument<Int>("quality") ?: 85

                    if (videoPath == null) { result.success(null); return@setMethodCallHandler }

                    try {
                        val retriever = MediaMetadataRetriever()
                        retriever.setDataSource(videoPath)
                        // getFrameAtTime takes microseconds
                        var bitmap = retriever.getFrameAtTime(
                            timeMs * 1_000L,
                            MediaMetadataRetriever.OPTION_CLOSEST_SYNC
                        )
                        retriever.release()

                        if (bitmap == null) { result.success(null); return@setMethodCallHandler }

                        if (bitmap.height > maxHeight) {
                            val scale = maxHeight.toFloat() / bitmap.height
                            bitmap = Bitmap.createScaledBitmap(
                                bitmap,
                                (bitmap.width * scale).toInt(),
                                maxHeight,
                                true
                            )
                        }

                        val out = ByteArrayOutputStream()
                        bitmap.compress(Bitmap.CompressFormat.JPEG, quality, out)
                        result.success(out.toByteArray())
                    } catch (e: Exception) {
                        result.success(null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}