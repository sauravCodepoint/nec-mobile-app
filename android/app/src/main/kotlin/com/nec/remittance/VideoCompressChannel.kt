package com.nec.remittance

import android.content.Context
import android.media.MediaMetadataRetriever
import android.net.Uri
import android.os.Handler
import android.os.Looper
import androidx.annotation.OptIn
import androidx.media3.common.Effect
import androidx.media3.common.MediaItem
import androidx.media3.common.MimeTypes
import androidx.media3.common.util.UnstableApi
import androidx.media3.effect.Presentation
import androidx.media3.transformer.Composition
import androidx.media3.transformer.DefaultEncoderFactory
import androidx.media3.transformer.EditedMediaItem
import androidx.media3.transformer.Effects
import androidx.media3.transformer.ExportException
import androidx.media3.transformer.ExportResult
import androidx.media3.transformer.Transformer
import androidx.media3.transformer.VideoEncoderSettings
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.io.File

/**
 * Transcodes a recorded clip with androidx.media3's [Transformer], which drives
 * the device's MediaCodec hardware encoder. Replaces the `video_compress`
 * plugin. Every failure path replies `null` so Dart can fall back to the
 * original file.
 */
@OptIn(markerClass = [UnstableApi::class])
object VideoCompressChannel {
    private const val CHANNEL = "general.video_compress"

    fun setup(messenger: BinaryMessenger, context: Context) {
        MethodChannel(messenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "compress" -> {
                    val videoPath = call.argument<String>("videoPath")
                    val maxHeight = call.argument<Int>("maxHeight") ?: 720
                    val bitrate   = call.argument<Int>("bitrate") ?: 2_000_000

                    if (videoPath == null) {
                        result.success(null)
                    } else {
                        compress(context, videoPath, maxHeight, bitrate, result)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun compress(
        context: Context,
        videoPath: String,
        maxHeight: Int,
        bitrate: Int,
        result: MethodChannel.Result,
    ) {
        val source = File(videoPath)
        if (!source.exists()) { result.success(null); return }

        val output = File(context.cacheDir, "vc_${System.nanoTime()}.mp4")

        // Transformer must be built and started on a Looper thread, and it
        // delivers its callbacks there; the method channel also expects its
        // reply on the main thread.
        Handler(Looper.getMainLooper()).post {
            try {
                // Presentation scales to an exact height, up as well as down, so
                // only apply it when the clip is actually taller than the cap.
                val effects = displayHeight(videoPath)
                    ?.takeIf { it > maxHeight }
                    ?.let {
                        Effects(
                            emptyList(),
                            listOf<Effect>(Presentation.createForHeight(maxHeight)),
                        )
                    }
                    ?: Effects.EMPTY

                val editedItem = EditedMediaItem.Builder(MediaItem.fromUri(Uri.fromFile(source)))
                    .setEffects(effects)
                    .build()

                // Requesting non-default encoder settings is what makes
                // Transformer re-encode instead of transmuxing — transmuxing
                // would copy the samples through and save nothing.
                val encoderFactory = DefaultEncoderFactory.Builder(context)
                    .setRequestedVideoEncoderSettings(
                        VideoEncoderSettings.Builder().setBitrate(bitrate).build()
                    )
                    .setEnableFallback(true)
                    .build()

                var replied = false
                val transformer = Transformer.Builder(context)
                    .setVideoMimeType(MimeTypes.VIDEO_H264)
                    .setAudioMimeType(MimeTypes.AUDIO_AAC)
                    .setEncoderFactory(encoderFactory)
                    .addListener(object : Transformer.Listener {
                        override fun onCompleted(composition: Composition, exportResult: ExportResult) {
                            if (replied) return
                            replied = true
                            result.success(if (output.exists()) output.absolutePath else null)
                        }

                        override fun onError(
                            composition: Composition,
                            exportResult: ExportResult,
                            exception: ExportException,
                        ) {
                            if (replied) return
                            replied = true
                            output.delete()
                            result.success(null)
                        }
                    })
                    .build()

                transformer.start(editedItem, output.absolutePath)
            } catch (e: Throwable) {
                output.delete()
                result.success(null)
            }
        }
    }

    /** Frame height as displayed, i.e. with the track's rotation applied. */
    private fun displayHeight(path: String): Int? = try {
        val retriever = MediaMetadataRetriever()
        retriever.setDataSource(path)
        val width = retriever
            .extractMetadata(MediaMetadataRetriever.METADATA_KEY_VIDEO_WIDTH)?.toIntOrNull()
        val height = retriever
            .extractMetadata(MediaMetadataRetriever.METADATA_KEY_VIDEO_HEIGHT)?.toIntOrNull()
        val rotation = retriever
            .extractMetadata(MediaMetadataRetriever.METADATA_KEY_VIDEO_ROTATION)?.toIntOrNull() ?: 0
        retriever.release()
        when {
            width == null || height == null -> null
            rotation == 90 || rotation == 270 -> width
            else -> height
        }
    } catch (e: Exception) {
        null
    }
}
