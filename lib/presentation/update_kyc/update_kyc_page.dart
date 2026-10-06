import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/update_kyc/update_kyc_bloc.dart';
import '../../domain/common/common_selectable_dto.dart';
import '../../domain/update_kyc/update_kyc_failure.dart';
import '../../domain/core/failures.dart';
import '../../domain/core/value_objects.dart';
import '../../domain/kyc/kyc_ocr_result.dart';
import '../core/app_bar/app_app_bar.dart';
import '../core/button/app_button.dart';
import '../core/date_picker/app_date_picker_field.dart';
import '../core/notify/app_notify.dart';
import '../core/scaffold/app_scaffold.dart';
import '../core/text_form_field/app_text_form_field.dart';
import '../core/theme/app_theme_ext.dart';
import '../core/widgets/confirm_pop_scope.dart';
import '../routes/app_routes.gr.dart';
import '../core/kyc/document_card.dart';
import '../core/kyc/id_camera_page.dart';
import '../core/kyc/ocr_confirm_sheet.dart';
import '../core/kyc/progress_stepper.dart';
import '../core/kyc/requirements_bar.dart';
import '../core/kyc/section_header.dart';
import '../core/kyc/security_note.dart';

@RoutePage()
class UpdateKycPage extends HookWidget {
  const UpdateKycPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bloc = context.read<UpdateKycBloc>();

    // ── Text controllers ────────────────────────────────────────────────────
    final idTypeCtrl = useTextEditingController();
    final idNumberCtrl = useTextEditingController();

    // ── OCR result state ─────────────────────────────────────────────────────
    final ocrResult = useState<KycOcrResult?>(null);
    // The scanned document is validated against the locked profile ID. Front
    // and back are tracked independently (the back rarely carries a readable ID
    // number, so a shared state would let a back capture clear a real front-side
    // mismatch). `blocked` stops submission; `bypassed` keeps a soft warning.
    final frontCheck = useState<_IdPhotoCheck>(_IdPhotoCheck.ok);
    final backCheck = useState<_IdPhotoCheck>(_IdPhotoCheck.ok);
    final prevIdTypeRef = useRef<CommonSelectableItem?>(null);
    final prevFrontDocRef = useRef<String?>(null);
    final prevBackDocRef = useRef<String?>(null);

    // ── Page entrance animation ──────────────────────────────────────────────
    final entranceCtrl = useAnimationController(
      duration: const Duration(milliseconds: 950),
    );
    final aProgress = useMemoized(
          () => CurvedAnimation(
        parent: entranceCtrl,
        curve: const Interval(0.00, 0.55, curve: Curves.easeOutCubic),
      ),
    );
    final aSection1 = useMemoized(
          () => CurvedAnimation(
        parent: entranceCtrl,
        curve: const Interval(0.10, 0.62, curve: Curves.easeOutCubic),
      ),
    );
    final aFields = useMemoized(
          () => CurvedAnimation(
        parent: entranceCtrl,
        curve: const Interval(0.18, 0.68, curve: Curves.easeOutCubic),
      ),
    );
    final aNote = useMemoized(
          () => CurvedAnimation(
        parent: entranceCtrl,
        curve: const Interval(0.30, 0.80, curve: Curves.easeOutCubic),
      ),
    );
    final aButton = useMemoized(
          () => CurvedAnimation(
        parent: entranceCtrl,
        curve: const Interval(0.40, 0.90, curve: Curves.easeOutCubic),
      ),
    );

    useEffect(() {
      entranceCtrl.forward();
      return null;
    }, const []);

    useEffect(() {
      void onChanged() =>
          bloc.add(UpdateKycEvent.identityNumberChanged(idNumberCtrl.text));
      idNumberCtrl.addListener(onChanged);
      return () => idNumberCtrl.removeListener(onChanged);
    }, const []);

    // ── OCR application ──────────────────────────────────────────────────────
    // Only the dates are auto-filled. The scan is validated against the locked
    // profile ID at capture time (see [_captureDocument]) rather than here.
    void applyOcr(KycOcrResult r) {
      final prev = ocrResult.value;
      final merged = KycOcrResult(
        issueDate: r.issueDate ?? prev?.issueDate,
        expiryDate: r.expiryDate ?? prev?.expiryDate,
        cardType: r.cardType ?? prev?.cardType,
      );
      ocrResult.value = merged;
      bloc.add(UpdateKycEvent.ocrResultReceived(merged));
    }

    return MultiBlocListener(
      listeners: [
        // Document-path listener — isolated from the toast listener below so it
        // can fire on *every* path change (including a fresh pick) and keep the
        // prev-path refs accurate. A side's OCR badges and check are cleared
        // only once its path goes non-null -> null, i.e. after the delete
        // actually succeeds. The locked ID number is never touched.
        BlocListener<UpdateKycBloc, UpdateKycState>(
          listenWhen: (prev, curr) =>
          prev.frontDocumentPath != curr.frontDocumentPath ||
              prev.backDocumentPath != curr.backDocumentPath,
          listener: (context, state) {
            if (prevFrontDocRef.value != null &&
                state.frontDocumentPath == null) {
              ocrResult.value = null;
              frontCheck.value = _IdPhotoCheck.ok;
            }
            prevFrontDocRef.value = state.frontDocumentPath;

            if (prevBackDocRef.value != null &&
                state.backDocumentPath == null) {
              backCheck.value = _IdPhotoCheck.ok;
            }
            prevBackDocRef.value = state.backDocumentPath;
          },
        ),
        BlocListener<UpdateKycBloc, UpdateKycState>(
          listenWhen: (prev, curr) =>
          prev.selectedIdentityType != curr.selectedIdentityType ||
              prev.identityTypesFailureOption !=
                  curr.identityTypesFailureOption ||
              curr.uploadFailureOption != prev.uploadFailureOption ||
              curr.deleteFailureOption != prev.deleteFailureOption ||
              curr.submitFailureOrSuccessOption !=
                  prev.submitFailureOrSuccessOption,
          listener: (context, state) {
            if (state.selectedIdentityType != prevIdTypeRef.value) {
              prevIdTypeRef.value = state.selectedIdentityType;
              idTypeCtrl.text = state.selectedIdentityType?.titleName ?? '';
              idNumberCtrl.text = state.identityNumber.rawValue;
            }

            state.identityTypesFailureOption.fold(
                  () => null,
                  (failure) => AppNotify.toast(
                failure.maybeMap(
                  unableToFetchIdentityTypes: (f) => f.message,
                  serverError: (_) => 'errors.serverError'.tr(),
                  orElse: () => 'errors.unknownError'.tr(),
                ),
                type: AppToastType.info,
                position: AppToastPosition.top,
              ),
            );

            state.uploadFailureOption.fold(
                  () => null,
                  (failure) => AppNotify.toast(
                failure.when(
                  unableToFetchIdentityTypes: (m) => m,
                  frontUploadFailed: (m) => m,
                  backUploadFailed: (m) => m,
                  deleteFailed: (m) => m,
                  submitFailed: (m) => m,
                  serverError: () => 'kyc.errors.serverError'.tr(),
                ),
                type: AppToastType.error,
                position: AppToastPosition.top,
              ),
            );

            state.deleteFailureOption.fold(
                  () => null,
                  (failure) => AppNotify.toast(
                failure.when(
                  unableToFetchIdentityTypes: (m) => m,
                  frontUploadFailed: (m) => m,
                  backUploadFailed: (m) => m,
                  deleteFailed: (m) => m,
                  submitFailed: (m) => m,
                  serverError: () => 'kyc.errors.serverError'.tr(),
                ),
                type: AppToastType.error,
                position: AppToastPosition.top,
              ),
            );

            state.submitFailureOrSuccessOption.fold(
                  () => null,
                  (either) => either.fold(
                    (failure) => AppNotify.toast(
                  failure.when(
                    unableToFetchIdentityTypes: (m) => m,
                    frontUploadFailed: (m) => m,
                    backUploadFailed: (m) => m,
                    deleteFailed: (m) => m,
                    submitFailed: (m) => m,
                    serverError: () => 'kyc.errors.serverError'.tr(),
                  ),
                  type: AppToastType.error,
                  position: AppToastPosition.top,
                ),
                    (_) async {
                  await AppNotify.dialog(
                    title: 'kyc.submission.success.title'.tr(),
                    message: 'update_kyc.submission.success.message'.tr(),
                    type: AppDialogType.success,
                    buttonText: 'kyc.submission.success.button'.tr(),
                  );
                  if (context.mounted) {
                    context.router.replaceAll([MpinRoute()]);
                  }
                },
              ),
            );
          },
        ),
      ],
      child: BlocBuilder<UpdateKycBloc, UpdateKycState>(
        builder: (context, state) {
          final show = state.showErrorMessages;

          // Front/back verdicts folded into one, worst-case wins.
          final idCheck = _combineIdChecks(frontCheck.value, backCheck.value);
          final idBlocked = idCheck == _IdPhotoCheck.blocked;

          final docDone = state.frontDocEId != null && state.backDocEId != null;
          final detailsDone =
              state.identityNumber.isValid() &&
                  state.issueDate.isValid() &&
                  state.expiryDate.isValid();

          final isBusy =
              state.isFrontUploading ||
                  state.isFrontDeleting ||
                  state.isBackUploading ||
                  state.isBackDeleting ||
                  state.isSubmitting;

          void onSubmitTap() {
            bloc.add(UpdateKycEvent.identityNumberChanged(idNumberCtrl.text));
            // A scanned document that doesn't match the profile ID blocks the
            // update until the user retakes it or overrides the check.
            if (idBlocked) {
              AppNotify.toast(
                'kyc.ocr.mismatch.message'.tr(),
                type: AppToastType.warning,
                position: AppToastPosition.top,
              );
              return;
            }
            if (state.frontDocEId == null || state.backDocEId == null) {
              AppNotify.toast(
                'kyc.validation.missingDocuments'.tr(),
                type: AppToastType.warning,
                position: AppToastPosition.top,
              );
            }
            // Dispatch regardless — the bloc flips showErrorMessages, which
            // also lights up the error border on the missing document card.
            bloc.add(const UpdateKycEvent.submitPressed());
          }

          return ConfirmPopScope(
            title: 'kyc.exit.title'.tr(),
            message: 'kyc.exit.message'.tr(),
            type: AppDialogType.warning,
            onConfirm: () => context.router.replaceAll([const MainRoute()]),
            child: AppScaffold(
              isLoading: state.isLoadingIdentityTypes || state.isSubmitting,
              onTapOutside: () => FocusScope.of(context).unfocus(),
              appBar: AppAppBar(title: 'update_kyc.page.title'.tr()),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Progress stepper ────────────────────────────
                          _FadeSlide(
                            animation: aProgress,
                            child: KycProgressStepper(
                              steps: [
                                (
                                label: 'kyc.steps.document'.tr(),
                                icon: Icons.badge_outlined,
                                complete: docDone,
                                ),
                                (
                                label: 'kyc.steps.details'.tr(),
                                icon: Icons.edit_document,
                                complete: detailsDone,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32.h),

                          // ── Section 1: Document ─────────────────────────
                          _FadeSlide(
                            animation: aSection1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KycSectionHeader(
                                  step: 1,
                                  title: 'kyc.section.document.title'.tr(),
                                  subtitle: 'kyc.section.document.subtitle'
                                      .tr(),
                                  isComplete: docDone,
                                ),
                                SizedBox(height: 14.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: KycDocumentCard(
                                        label: 'kyc.document.front.label'.tr(),
                                        hint: 'kyc.document.front.hint'.tr(),
                                        icon: Icons.credit_card_outlined,
                                        filePath: state.frontDocumentPath,
                                        isLoading:
                                        state.isFrontUploading ||
                                            state.isFrontDeleting,
                                        hasError:
                                        show && state.frontDocEId == null,
                                        onPick: () => _captureDocument(
                                          context,
                                          isFront: true,
                                          onOcr: applyOcr,
                                          onIdCheck: (c) =>
                                          frontCheck.value = c,
                                        ),
                                        onRemove: () => bloc.add(
                                          const UpdateKycEvent.frontDocumentRemoved(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: KycDocumentCard(
                                        label: 'kyc.document.back.label'.tr(),
                                        hint: 'kyc.document.back.hint'.tr(),
                                        icon: Icons.flip_rounded,
                                        filePath: state.backDocumentPath,
                                        isLoading:
                                        state.isBackUploading ||
                                            state.isBackDeleting,
                                        hasError:
                                        show && state.backDocEId == null,
                                        onPick: () => _captureDocument(
                                          context,
                                          isFront: false,
                                          onOcr: applyOcr,
                                          onIdCheck: (c) => backCheck.value = c,
                                        ),
                                        onRemove: () => bloc.add(
                                          const UpdateKycEvent.backDocumentRemoved(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                KycRequirementsBar(
                                  items: [
                                    'kyc.requirements.document.format'.tr(),
                                    'kyc.requirements.document.size'.tr(),
                                    'kyc.requirements.document.quality'.tr(),
                                  ],
                                ),
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOutCubic,
                                  child: idCheck == _IdPhotoCheck.ok
                                      ? const SizedBox.shrink()
                                      : Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: _IdMismatchBanner(
                                      bypassed:
                                      idCheck ==
                                          _IdPhotoCheck.bypassed,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 28.h),

                          // ── Section 2: Details ──────────────────────────
                          _FadeSlide(
                            animation: aFields,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KycSectionHeader(
                                  step: 2,
                                  title: 'update_kyc.section.details.title'
                                      .tr(),
                                  subtitle:
                                  'update_kyc.section.details.subtitle'
                                      .tr(),
                                  isComplete: detailsDone,
                                ),
                                SizedBox(height: 14.h),

                                // ID Type
                                AppTextFormField(
                                  controller: idTypeCtrl,
                                  labelText: 'login.idType.label'.tr(),
                                  hintText: 'login.idType.placeholder'.tr(),
                                  enabled: false,
                                  readOnly: true,
                                  showCursor: false,
                                  // Locked but filled — keep the value as
                                  // readable as an editable field's.
                                  disabledTextColor: cs.onSurface,
                                  suffixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: cs.tertiary,
                                  ),
                                ),
                                SizedBox(height: 12.h),

                                // ID Number
                                AppTextFormField(
                                  controller: idNumberCtrl,
                                  labelText: 'kyc.field.idNumber.label'.tr(),
                                  hintText: 'kyc.field.idNumber.hint'.tr(),
                                  enabled: false,
                                  readOnly: true,
                                  showCursor: false,
                                  // Locked but filled — keep the value as
                                  // readable as an editable field's.
                                  disabledTextColor: cs.onSurface,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  suffixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: cs.tertiary,
                                  ),
                                  errorText: show
                                      ? _fieldError(state.identityNumber)
                                      : null,
                                ),
                                SizedBox(height: 12.h),

                                // Issue + Expiry dates
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppDatePickerField(
                                        value: state.issueDate.rawValue.isEmpty
                                            ? null
                                            : state.issueDate.rawValue,
                                        onChanged: (d) => bloc.add(
                                          UpdateKycEvent.issueDateChanged(d),
                                        ),
                                        labelText: 'kyc.field.issueDate.label'
                                            .tr(),
                                        maximumDate: DateTime.now(),
                                        suffixIcon:
                                        ocrResult.value?.issueDate != null
                                            ? _OcrBadge(color: cs.tertiary)
                                            : null,
                                        errorText: show
                                            ? _fieldError(state.issueDate)
                                            : null,
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: AppDatePickerField(
                                        value: state.expiryDate.rawValue.isEmpty
                                            ? null
                                            : state.expiryDate.rawValue,
                                        onChanged: (d) => bloc.add(
                                          UpdateKycEvent.expiryDateChanged(d),
                                        ),
                                        labelText: 'kyc.field.expiryDate.label'
                                            .tr(),
                                        suffixIcon:
                                        ocrResult.value?.expiryDate != null
                                            ? _OcrBadge(color: cs.tertiary)
                                            : null,
                                        errorText: show
                                            ? _fieldError(state.expiryDate)
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.h),

                                // Remarks
                                AppTextFormField(
                                  initialValue: state.remarks.rawValue,
                                  labelText: 'update_kyc.field.remarks.label'
                                      .tr(),
                                  hintText: 'update_kyc.field.remarks.hint'
                                      .tr(),
                                  maxLines: 3,
                                  onChanged: (v) => bloc.add(
                                    UpdateKycEvent.remarksChanged(v),
                                  ),
                                ),

                                // OCR auto-fill notice
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOutCubic,
                                  child:
                                  ocrResult.value != null &&
                                      ocrResult.value!.hasAnyData
                                      ? Padding(
                                    padding: EdgeInsets.only(top: 8.h),
                                    child: _OcrAutoFillNotice(
                                      color: cs.tertiary,
                                    ),
                                  )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 36.h),

                          // ── Security note ───────────────────────────────
                          _FadeSlide(
                            animation: aNote,
                            child: const KycSecurityNote(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── Submit button ───────────────────────────────────────
                  _FadeSlide(
                    animation: aButton,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ).add(EdgeInsets.only(bottom: 10.h)),
                      child: AppButton(
                        text: 'kyc.button.submit'.tr(),
                        isLoading: isBusy,
                        onTap: isBusy ? null : onSubmitTap,
                        sideWidget: Icon(
                          Icons.arrow_forward,
                          color: cs.primary,
                          size: 20.sp,
                        ),
                        sideWidgetPosition: SideWidgetPosition.right,
                        useSpaceBetween: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Fade + slide entrance animation wrapper ───────────────────────────────────

class _FadeSlide extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _FadeSlide({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (_, child) {
        final t = animation.value.clamp(0.0, 1.0);
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, 22.h * (1 - t)),
            child: child,
          ),
        );
      },
    );
  }
}

// ── OCR auto-fill notice ──────────────────────────────────────────────────────

class _OcrAutoFillNotice extends StatelessWidget {
  final Color color;
  const _OcrAutoFillNotice({required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.auto_awesome_rounded, color: color, size: 11.sp),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(
            'kyc.ocr.autofillNotice'.tr(),
            style: TextStyle(
              fontSize: 10.sp,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

// ── OCR badge ─────────────────────────────────────────────────────────────────

class _OcrBadge extends StatefulWidget {
  final Color color;
  const _OcrBadge({required this.color});

  @override
  State<_OcrBadge> createState() => _OcrBadgeState();
}

class _OcrBadgeState extends State<_OcrBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.elasticOut)).animate(_ctrl);
    _rotation = Tween<double>(
      begin: -0.4,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Transform.rotate(
        angle: _rotation.value,
        child: ScaleTransition(
          scale: _scale,
          child: Icon(
            Icons.auto_awesome_rounded,
            color: widget.color,
            size: 15,
          ),
        ),
      ),
    );
  }
}

// ── Document capture ──────────────────────────────────────────────────────────

Future<void> _captureDocument(
    BuildContext context, {
      required bool isFront,
      required void Function(KycOcrResult) onOcr,
      required void Function(_IdPhotoCheck) onIdCheck,
    }) async {
  final bloc = context.read<UpdateKycBloc>();

  final result = await KycIdCameraPage.show(context, isFront: isFront);
  if (result == null) return;

  bloc.add(
    isFront
        ? UpdateKycEvent.frontDocumentPicked(path: result.imagePath)
        : UpdateKycEvent.backDocumentPicked(path: result.imagePath),
  );

  // ── Validate the scanned ID against the locked profile credentials ─────────
  // The ID type/number are fixed from the member's profile, so a scan whose ID
  // reads differently means either the wrong document — or an OCR misread. We
  // let the user override rather than hard-block.
  // CPR is the only identity type, so the OCR card type can never disagree
  // with the locked one — only the scanned number is worth comparing.
  final st = bloc.state;
  final enteredNumber = st.identityNumber.rawValue;

  final scannedNumber = result.ocr.idNumber != null
      ? _sanitizeIdNumber(result.ocr.idNumber!)
      : null;

  final numberMismatch =
      scannedNumber != null &&
          scannedNumber.isNotEmpty &&
          enteredNumber.isNotEmpty &&
          scannedNumber != enteredNumber;

  if (numberMismatch) {
    if (!context.mounted) {
      onIdCheck(_IdPhotoCheck.blocked);
      return;
    }
    // Safe action (Retake) is the prominent button; overriding is the quieter
    // secondary one.
    final retake = await AppNotify.confirm(
      title: 'kyc.ocr.mismatch.title'.tr(),
      message: 'kyc.ocr.mismatch.confirmMessage'.tr(),
      confirmText: 'kyc.ocr.mismatch.retakeButton'.tr(),
      cancelText: 'kyc.ocr.mismatch.useAnywayButton'.tr(),
      type: AppDialogType.warning,
    );
    if (retake) {
      onIdCheck(_IdPhotoCheck.blocked);
      return;
    }
    onIdCheck(_IdPhotoCheck.bypassed);
  } else {
    onIdCheck(_IdPhotoCheck.ok);
  }

  final hasFormData =
      result.ocr.issueDate != null || result.ocr.expiryDate != null;
  if (!hasFormData || !context.mounted) return;

  // ID type/number are locked on this page — only the dates are OCR-fillable.
  final ocr = KycOcrResult(
    issueDate: result.ocr.issueDate,
    expiryDate: result.ocr.expiryDate,
    cardType: result.ocr.cardType,
  );

  final confirmed = await KycOcrConfirmSheet.show(context, result: ocr);
  if (confirmed) {
    onOcr(ocr);
  }
}

// ── Validation error messages ─────────────────────────────────────────────────

String? _fieldError(ValueObject<String> field) {
  return field.value.fold(
        (f) => f.when(
      empty: (_) => 'kyc.validation.error.required'.tr(),
      tooShort: (_, min) =>
          'kyc.validation.error.tooShort'.tr(namedArgs: {'min': '$min'}),
      tooLong: (_, max) =>
          'kyc.validation.error.tooLong'.tr(namedArgs: {'max': '$max'}),
      invalidFormat: (_, _) => 'kyc.validation.error.invalidFormat'.tr(),
      invalidDate: (_) => 'kyc.validation.error.invalidDate'.tr(),
      expiredDocument: (_) => 'kyc.validation.error.expiredDocument'.tr(),
      futureDate: (_) => 'kyc.validation.error.futureDate'.tr(),
      underage: (_, age) =>
          'kyc.validation.error.underage'.tr(namedArgs: {'age': '$age'}),
      invalidIdentityNumber: (_) =>
          'kyc.validation.error.invalidIdentityNumber'.tr(),
      invalidMobileNumber: (_) =>
          'kyc.validation.error.invalidMobileNumber'.tr(),
      invalidOtp: (_) => 'kyc.validation.error.invalidOtp'.tr(),
      invalidEmailAddress: (_) =>
          'kyc.validation.error.invalidEmailAddress'.tr(),
      sameAsCurrentMpin: (_) => 'kyc.validation.error.sameAsCurrentMpin'.tr(),
      invalidMpin: (_) => 'kyc.validation.error.invalidMpin'.tr(),
      repeatedDigits: (_) => 'kyc.validation.error.repeatedDigits'.tr(),
      sequentialDigits: (_) => 'kyc.validation.error.sequentialDigits'.tr(),
    ),
        (_) => null,
  );
}

// ── ID number sanitizer ───────────────────────────────────────────────────────

// Converts Arabic/Eastern-Arabic digits to Western and strips non-digit chars.
String _sanitizeIdNumber(String raw) {
  const arabic = '٠١٢٣٤٥٦٧٨٩';
  var s = raw;
  for (var i = 0; i < 10; i++) {
    s = s.replaceAll(arabic[i], '$i');
  }
  return s.replaceAll(RegExp(r'[^0-9]'), '');
}

// ── ID-photo check ────────────────────────────────────────────────────────────

// Outcome of matching the scanned ID document against the profile credentials.
enum _IdPhotoCheck { ok, blocked, bypassed }

// Folds the front and back verdicts into one, worst-case wins: a blocked side
// blocks the whole form, a bypassed side keeps the soft warning, and only when
// neither side is flagged is the banner hidden.
_IdPhotoCheck _combineIdChecks(_IdPhotoCheck front, _IdPhotoCheck back) {
  if (front == _IdPhotoCheck.blocked || back == _IdPhotoCheck.blocked) {
    return _IdPhotoCheck.blocked;
  }
  if (front == _IdPhotoCheck.bypassed || back == _IdPhotoCheck.bypassed) {
    return _IdPhotoCheck.bypassed;
  }
  return _IdPhotoCheck.ok;
}

// ── ID-mismatch banner ────────────────────────────────────────────────────────

class _IdMismatchBanner extends StatelessWidget {
  // When true the user overrode the mismatch — render a softer warning instead
  // of a hard error, reminding them a wrong ID will be rejected.
  final bool bypassed;
  const _IdMismatchBanner({required this.bypassed});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final accent = bypassed
        ? context.appColors.warning
        : context.appColors.error;
    final fill = bypassed
        ? context.appColors.warningSubtle
        : context.appColors.errorSubtle;
    final title = bypassed
        ? 'kyc.ocr.mismatch.bypassedTitle'.tr()
        : 'kyc.ocr.mismatch.title'.tr();
    final message = bypassed
        ? 'kyc.ocr.mismatch.bypassedMessage'.tr()
        : 'kyc.ocr.mismatch.message'.tr();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: accent.withValues(alpha: 0.35), width: 0.8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            bypassed
                ? Icons.warning_amber_rounded
                : Icons.error_outline_rounded,
            color: accent,
            size: 18.w,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  message,
                  style: TextStyle(
                    color: cs.onSurface.withValues(alpha: 0.85),
                    fontSize: 11.sp,
                    height: 1.3,
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
