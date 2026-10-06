import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dashed_border.dart';
import '../theme/app_theme_ext.dart';

class KycVideoCard extends StatelessWidget {
  /// Local file path — null after the video has been uploaded and the file
  /// deleted from device storage.
  final String? videoPath;

  /// Persists even after upload for thumbnail display.
  final String? thumbnailPath;

  final bool isUploading;
  final bool isDeleting;
  final VoidCallback onRecord;
  final VoidCallback onPlay;
  final VoidCallback onDelete;

  const KycVideoCard({
    super.key,
    required this.onRecord,
    required this.onPlay,
    required this.onDelete,
    this.videoPath,
    this.thumbnailPath,
    this.isUploading = false,
    this.isDeleting = false,
  });

  bool get _hasVideo => videoPath != null || thumbnailPath != null;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
          ),
          child: child,
        ),
      ),
      child: _hasVideo
          ? _VideoRecordedState(
              key: const ValueKey('recorded'),
              videoPath: videoPath,
              thumbnailPath: thumbnailPath,
              isUploading: isUploading,
              isDeleting: isDeleting,
              onPlay: onPlay,
              onDelete: onDelete,
            )
          : _VideoEmptyState(
              key: const ValueKey('empty'),
              onRecord: onRecord,
            ),
    );
  }
}

// ── Empty state with breathing pulse ─────────────────────────────────────────

class _VideoEmptyState extends StatefulWidget {
  final VoidCallback onRecord;
  const _VideoEmptyState({super.key, required this.onRecord});

  @override
  State<_VideoEmptyState> createState() => _VideoEmptyStateState();
}

class _VideoEmptyStateState extends State<_VideoEmptyState>
    with SingleTickerProviderStateMixin {
  late final AnimationController _breathe;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _breathe = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _pulse = CurvedAnimation(parent: _breathe, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _breathe.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return GestureDetector(
      onTap: widget.onRecord,
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (_, child) {
          final borderAlpha = 0.22 + 0.20 * _pulse.value;
          return KycDashedBorderBox(
            color: cs.tertiary.withValues(alpha: borderAlpha),
            borderRadius: 14.r,
            child: Container(
              decoration: BoxDecoration(
                color: context.appColors.containerBackground,
                borderRadius: BorderRadius.circular(14.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
              child: child,
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Left: icon + record badge ──────────────────────────────────
            _VideoIconColumn(pulse: _pulse),
            SizedBox(width: 18.w),
            // ── Right: instructions ────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'kyc.section.video.title'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  SizedBox(height: 10.h),
                  ...[
                    'kyc.video.card.instruction1'.tr(),
                    'kyc.video.card.instruction2'.tr(),
                    'kyc.video.card.instruction3'.tr(),
                  ].map(
                    (instruction) => Padding(
                      padding: EdgeInsets.only(bottom: 7.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 4.h),
                            width: 5.w,
                            height: 5.w,
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.tertiary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              instruction,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontSize: 11.sp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.6),
                                    height: 1.4,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  _RecordButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Separating these into sub-widgets so AnimatedBuilder doesn't rebuild them
class _VideoIconColumn extends StatelessWidget {
  final Animation<double> pulse;
  const _VideoIconColumn({required this.pulse});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: pulse,
      builder: (_, __) {
        final iconAlpha = 0.08 + 0.09 * pulse.value;
        final borderAlpha = 0.22 + 0.20 * pulse.value;
        return Column(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.tertiary.withValues(alpha: iconAlpha),
                border: Border.all(
                  color: cs.tertiary.withValues(alpha: borderAlpha),
                  width: 1.w,
                ),
              ),
              child: Icon(
                Icons.videocam_outlined,
                color: cs.tertiary,
                size: 26.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: context.appColors.brandFill,
                borderRadius: BorderRadius.circular(99.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.fiber_manual_record,
                    color: context.appColors.onBrandFill,
                    size: 8.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'kyc.video.card.durationBadge'.tr(),
                    style: TextStyle(
                      color: context.appColors.onBrandFill,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RecordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: cs.tertiary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(99.r),
        border: Border.all(
          color: cs.tertiary.withValues(alpha: 0.3),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.videocam_outlined, color: cs.tertiary, size: 11.sp),
          SizedBox(width: 4.w),
          Text(
            'kyc.video.card.recordButton'.tr(),
            style: TextStyle(
              color: cs.tertiary,
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Recorded state ────────────────────────────────────────────────────────────

class _VideoRecordedState extends StatelessWidget {
  final String? videoPath;
  final String? thumbnailPath;
  final bool isUploading;
  final bool isDeleting;
  final VoidCallback onPlay;
  final VoidCallback onDelete;

  const _VideoRecordedState({
    super.key,
    required this.onPlay,
    required this.onDelete,
    this.videoPath,
    this.thumbnailPath,
    this.isUploading = false,
    this.isDeleting = false,
  });

  bool get _isBusy => isUploading || isDeleting;
  bool get _isUploaded => videoPath == null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final label = videoPath != null
        ? File(videoPath!).uri.pathSegments.last
        : 'selfie_video.mp4';

    return Container(
      decoration: BoxDecoration(
        color: context.appColors.containerBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: context.appColors.success.withValues(alpha: 0.45),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: context.appColors.success.withValues(alpha: 0.06),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Thumbnail / preview ─────────────────────────────────────────
          GestureDetector(
            onTap: (_isUploaded || _isBusy) ? null : onPlay,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(13.r)),
              child: SizedBox(
                height: 160.h,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (thumbnailPath != null)
                      Image.file(File(thumbnailPath!), fit: BoxFit.cover)
                    else
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.grey.shade900, Colors.black87],
                          ),
                        ),
                      ),
                    // Bottom gradient
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.55),
                          ],
                          stops: const [0.3, 1.0],
                        ),
                      ),
                    ),
                    // Duration badge
                    Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 9.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(99.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 5.w,
                              height: 5.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              '0:05',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Status badge
                    Positioned(
                      top: 10.h,
                      left: 10.w,
                      child: _isBusy
                          ? Container(
                              padding: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                shape: BoxShape.circle,
                              ),
                              child: SizedBox(
                                width: 12.w,
                                height: 12.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                color: context.appColors.success,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _isUploaded
                                    ? Icons.cloud_done_rounded
                                    : Icons.check_rounded,
                                color: context.appColors.onSuccess,
                                size: 10.sp,
                              ),
                            ),
                    ),
                    // Play button
                    if (!_isUploaded && !_isBusy)
                      Center(
                        child: Container(
                          width: 54.w,
                          height: 54.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withValues(alpha: 0.5),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.85),
                              width: 2.w,
                            ),
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 28.sp,
                          ),
                        ),
                      ),
                    // Busy overlay
                    if (_isBusy)
                      Container(
                        color: Colors.black.withValues(alpha: 0.35),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 32.w,
                                height: 32.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                isDeleting
                                    ? 'kyc.video.card.deleting'.tr()
                                    : 'kyc.video.card.uploading'.tr(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // Tap-to-play hint
                    if (!_isUploaded && !_isBusy)
                      Positioned(
                        bottom: 10.h,
                        left: 0,
                        right: 0,
                        child: Text(
                          'kyc.video.card.recorded.tapToPlay'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // ── Info bar ────────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: context.appColors.success.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.videocam_rounded,
                    color: context.appColors.success,
                    size: 14.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface,
                        ),
                      ),
                      Text(
                        isDeleting
                            ? 'kyc.video.card.deleting'.tr()
                            : isUploading
                                ? 'kyc.video.card.uploading'.tr()
                                : _isUploaded
                                    ? 'kyc.video.card.recorded.uploaded'.tr()
                                    : 'kyc.video.card.recorded.recorded'.tr(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 10.sp,
                          color: _isBusy
                              ? cs.onSurface.withValues(alpha: 0.5)
                              : context.appColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                if (!_isUploaded && !_isBusy) ...[
                  GestureDetector(
                    onTap: onPlay,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: cs.tertiary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.play_circle_outline_rounded,
                            color: cs.tertiary,
                            size: 13.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'kyc.video.card.recorded.playButton'.tr(),
                            style: TextStyle(
                              color: cs.tertiary,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                ],
                GestureDetector(
                  onTap: _isBusy ? null : onDelete,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.appColors.statusFailed.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.delete_outline_rounded,
                          color: context.appColors.statusFailed,
                          size: 13.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'kyc.video.card.recorded.deleteButton'.tr(),
                          style: TextStyle(
                            color: context.appColors.statusFailed,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}