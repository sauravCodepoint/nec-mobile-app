import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../domain/core/di/injection.dart';
import '../../../domain/core/permission_handler/app_permission_handler.dart';
// Full-screen camera/video overlay: renders on a black surface in both themes,
// so it deliberately uses the fixed brand palette instead of theme tokens.
import '../colors/app_colors.dart';
import 'camera_init_error_view.dart';

/// Full-screen custom camera page.
///
/// Returns the captured image file path (String) via [Navigator.pop], or null
/// if the user cancels. Use [AppCameraPage.show] to push it.
class AppCameraPage extends StatefulWidget {
  final bool useFrontCamera;
  final String? hint;

  const AppCameraPage({
    super.key,
    this.useFrontCamera = false,
    this.hint,
  });

  static Future<String?> show(
      BuildContext context, {
        bool useFrontCamera = false,
        String? hint,
      }) {
    return Navigator.of(context).push<String?>(
      PageRouteBuilder(
        fullscreenDialog: true,
        pageBuilder: (context, animation, secondaryAnimation) => AppCameraPage(
          useFrontCamera: useFrontCamera,
          hint: hint,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 250),
      ),
    );
  }

  @override
  State<AppCameraPage> createState() => _AppCameraPageState();
}

class _AppCameraPageState extends State<AppCameraPage>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isFront = false;
  FlashMode _flashMode = FlashMode.off;
  bool _isCapturing = false;
  bool _isInitialized = false;
  bool _isInitializing = false;
  String? _initError;

  @override
  void initState() {
    super.initState();
    _isFront = widget.useFrontCamera;
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Resume always re-runs init so a permission granted in Settings
      // is picked up without forcing the user to re-tap anything.
      _initCamera();
    }
  }

  Future<void> _initCamera() async {
    // The OS permission prompt briefly backgrounds the app, which fires
    // AppLifecycleState.resumed when the user dismisses it. Without this
    // guard, the resume listener kicks off a second _initCamera() while
    // the first is still awaiting the prompt — both then reach the denial
    // branch and each shows its own settings dialog.
    if (_isInitializing) return;
    _isInitializing = true;

    setState(() {
      _isInitialized = false;
      _initError = null;
    });

    try {
      final granted = await getIt<AppPermissionHandler>().requestPermission(
        Permission.camera,
        title: 'core.permission.camera.title'.tr(),
        message: 'core.permission.camera.message'.tr(),
        restrictedMessage: 'core.permission.camera.restricted'.tr(),
      );
      if (!mounted) return;
      if (!granted) {
        setState(() => _initError = 'core.permission.camera.deniedBody'.tr());
        return;
      }

      _cameras = await availableCameras();
      if (!mounted) return;
      if (_cameras.isEmpty) {
        setState(() => _initError = 'core.camera.noCameraFound'.tr());
        return;
      }

      final description = _cameras.firstWhere(
        (c) => c.lensDirection ==
            (_isFront ? CameraLensDirection.front : CameraLensDirection.back),
        orElse: () => _cameras.first,
      );

      final ctrl = CameraController(
        description,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await ctrl.initialize();
      if (!mounted) {
        ctrl.dispose();
        return;
      }
      await ctrl.setFlashMode(_flashMode);

      _controller = ctrl;
      setState(() => _isInitialized = true);
    } catch (e) {
      if (mounted) setState(() => _initError = e.toString());
    } finally {
      _isInitializing = false;
    }
  }

  Future<void> _switchLens() async {
    _isFront = !_isFront;
    await _controller?.dispose();
    _controller = null;
    await _initCamera();
  }

  Future<void> _cycleFlash() async {
    final modes = [FlashMode.off, FlashMode.auto, FlashMode.always];
    final next = modes[(modes.indexOf(_flashMode) + 1) % modes.length];
    _flashMode = next;
    await _controller?.setFlashMode(next);
    setState(() {});
  }

  Future<void> _capture() async {
    final ctrl = _controller;
    if (ctrl == null || !ctrl.value.isInitialized || _isCapturing) return;

    setState(() => _isCapturing = true);
    try {
      final file = await ctrl.takePicture();
      if (mounted) Navigator.of(context).pop(file.path);
    } catch (_) {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandBlack,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Camera Preview ──────────────────────────────────────
          if (_isInitialized && _controller != null)
            _CameraPreviewFill(controller: _controller!)
          else if (_initError != null)
            CameraInitErrorView(
              message: _initError!,
              onRetry: _initCamera,
            )
          else
            const Center(
              child: CircularProgressIndicator(color: AppColors.brandYellow),
            ),

          // ── Top controls ────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _TopBar(
              flashMode: _flashMode,
              onClose: () => Navigator.of(context).pop(null),
              onFlash: _isInitialized ? _cycleFlash : null,
            ),
          ),

          // ── Hint label ──────────────────────────────────────────
          if (widget.hint != null)
            Positioned(
              bottom: 140.h,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    widget.hint!,
                    style: TextStyle(
                      color: AppColors.brandOffWhite,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
            ),

          // ── Bottom controls ─────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomBar(
              canCapture: _isInitialized && !_isCapturing,
              hasMultipleLenses: _cameras.length > 1,
              isFront: _isFront,
              onCapture: _capture,
              onSwitch: _isInitialized ? _switchLens : null,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Preview widget that fills and crops to the available space ─────────────

class _CameraPreviewFill extends StatelessWidget {
  final CameraController controller;
  const _CameraPreviewFill({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: 1,
            height: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
        ),
      ),
    );
  }
}

// ── Top bar ────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final FlashMode flashMode;
  final VoidCallback onClose;
  final VoidCallback? onFlash;

  const _TopBar({
    required this.flashMode,
    required this.onClose,
    this.onFlash,
  });

  IconData get _flashIcon => switch (flashMode) {
    FlashMode.off => Icons.flash_off_rounded,
    FlashMode.auto => Icons.flash_auto_rounded,
    FlashMode.always || FlashMode.torch => Icons.flash_on_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black87, Colors.transparent],
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8.h,
        left: 8.w,
        right: 8.w,
        bottom: 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _IconBtn(
            icon: Icons.close_rounded,
            onTap: onClose,
          ),
          if (onFlash != null)
            _IconBtn(
              icon: _flashIcon,
              onTap: onFlash!,
              active: flashMode != FlashMode.off,
            ),
        ],
      ),
    );
  }
}

// ── Bottom bar ─────────────────────────────────────────────────────────────

class _BottomBar extends StatelessWidget {
  final bool canCapture;
  final bool hasMultipleLenses;
  final bool isFront;
  final VoidCallback onCapture;
  final VoidCallback? onSwitch;

  const _BottomBar({
    required this.canCapture,
    required this.hasMultipleLenses,
    required this.isFront,
    required this.onCapture,
    this.onSwitch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black87, Colors.transparent],
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 24.h,
        top: 24.h,
        left: 32.w,
        right: 32.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Switch lens
          SizedBox(
            width: 56.w,
            child: hasMultipleLenses
                ? _IconBtn(
              icon: Icons.cameraswitch_rounded,
              size: 28.sp,
              onTap: onSwitch ?? () {},
            )
                : null,
          ),

          // Capture
          GestureDetector(
            onTap: canCapture ? onCapture : null,
            child: AnimatedOpacity(
              opacity: canCapture ? 1.0 : 0.4,
              duration: const Duration(milliseconds: 200),
              child: _CaptureButton(),
            ),
          ),

          // Spacer (balance)
          SizedBox(width: 56.w),
        ],
      ),
    );
  }
}

// ── Capture button ─────────────────────────────────────────────────────────

class _CaptureButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76.w,
      height: 76.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.brandYellow, width: 3),
        color: Colors.transparent,
      ),
      child: Center(
        child: Container(
          width: 60.w,
          height: 60.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.brandWhite,
          ),
        ),
      ),
    );
  }
}

// ── Generic icon button ────────────────────────────────────────────────────

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool active;
  final double? size;

  const _IconBtn({
    required this.icon,
    required this.onTap,
    this.active = false,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black45,
        ),
        child: Icon(
          icon,
          color: active ? AppColors.brandYellow : AppColors.brandWhite,
          size: size ?? 22.sp,
        ),
      ),
    );
  }
}