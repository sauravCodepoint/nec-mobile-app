import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/common/common_selectable_dto.dart';
import '../../domain/core/value_objects.dart';
import '../../domain/core/value_validators.dart' show kIdentityTypeCode;
import '../../domain/kyc/kyc_ocr_result.dart';
import '../../domain/kyc/value_validators.dart';
import '../../domain/login/login_id_identity_dto.dart';
import '../../domain/update_kyc/i_update_kyc_facade.dart';
import '../../domain/update_kyc/update_kyc_failure.dart';
import '../../domain/update_kyc/value_validators.dart';

part 'update_kyc_event.dart';
part 'update_kyc_state.dart';
part 'update_kyc_bloc.freezed.dart';

@injectable
class UpdateKycBloc extends Bloc<UpdateKycEvent, UpdateKycState> {
  final IUpdateKycFacade _facade;

  UpdateKycBloc(this._facade) : super(UpdateKycState.initial()) {
    on<_Initialized>(_onInitialized);
    on<_IdentityTypeChanged>(_onIdentityTypeChanged);
    on<_FrontDocumentPicked>(_onFrontDocumentPicked);
    on<_BackDocumentPicked>(_onBackDocumentPicked);
    on<_FrontDocumentRemoved>(_onFrontDocumentRemoved);
    on<_BackDocumentRemoved>(_onBackDocumentRemoved);
    on<_IdentityNumberChanged>(_onIdentityNumberChanged);
    on<_IssueDateChanged>(_onIssueDateChanged);
    on<_ExpiryDateChanged>(_onExpiryDateChanged);
    on<_RemarksChanged>(_onRemarksChanged);
    on<_OcrResultReceived>(_onOcrResultReceived);
    on<_SubmitPressed>(_onSubmitPressed);
  }

  // ── Identity types ───────────────────────────────────────────────────────────

  FutureOr<void> _onInitialized(
      _Initialized event,
      Emitter<UpdateKycState> emit,
      ) async {
    emit(UpdateKycState.initial().copyWith(isLoadingIdentityTypes: true));

    final result = await _facade.getIdentityTypes();

    result.fold(
          (failure) => emit(state.copyWith(
        isLoadingIdentityTypes: false,
        identityTypesFailureOption: some(failure),
      )),
          (dto) {
        final list = dto.data?.identityTypesList ?? [];
        CommonSelectableItem? preSelected;
        if (list.isNotEmpty) {
          final match = list.firstWhere(
                (e) =>
            e.code?.toUpperCase() ==
                event.initialIdTypeCode.toUpperCase(),
            orElse: () => list.first,
          );
          preSelected = CommonSelectableItem(
            titleName: (match.name ?? '').toUpperCase(),
            titleCode: match.code,
          );
        }
        final typeCode = preSelected?.titleCode ?? kIdentityTypeCode;
        final idNumber = event.initialIdNumber.isNotEmpty
            ? event.initialIdNumber
            : state.identityNumber.rawValue;
        emit(state.copyWith(
          isLoadingIdentityTypes: false,
          loginIdIdentityDto: dto,
          identityTypesFailureOption: none(),
          selectedIdentityType: preSelected,
          idTypeCode: typeCode,
          identityNumber: IdentityNumber(idNumber, typeCode),
        ));
      },
    );
  }

  void _onIdentityTypeChanged(
      _IdentityTypeChanged event,
      Emitter<UpdateKycState> emit,
      ) {
    final typeCode = event.selectedIdentityType.titleCode ?? kIdentityTypeCode;
    emit(state.copyWith(
      selectedIdentityType: event.selectedIdentityType,
      idTypeCode: typeCode,
      identityNumber: IdentityNumber(state.identityNumber.rawValue, typeCode),
    ));
  }

  // ── Documents ────────────────────────────────────────────────────────────────

  FutureOr<void> _onFrontDocumentPicked(
      _FrontDocumentPicked event,
      Emitter<UpdateKycState> emit,
      ) async {
    emit(state.copyWith(
      frontDocumentPath: event.path,
      frontDocEId: null,
      isFrontUploading: true,
      uploadFailureOption: none(),
    ));

    final result = await _facade.uploadFrontDocument(file: File(event.path));

    result.fold(
          (failure) => emit(state.copyWith(
        frontDocumentPath: null,
        isFrontUploading: false,
        uploadFailureOption: some(failure),
      )),
          (eId) => emit(state.copyWith(
        frontDocEId: eId,
        isFrontUploading: false,
        uploadFailureOption: none(),
      )),
    );
  }

  FutureOr<void> _onBackDocumentPicked(
      _BackDocumentPicked event,
      Emitter<UpdateKycState> emit,
      ) async {
    emit(state.copyWith(
      backDocumentPath: event.path,
      backDocEId: null,
      isBackUploading: true,
      uploadFailureOption: none(),
    ));

    final result = await _facade.uploadBackDocument(file: File(event.path));

    result.fold(
          (failure) => emit(state.copyWith(
        backDocumentPath: null,
        isBackUploading: false,
        uploadFailureOption: some(failure),
      )),
          (eId) => emit(state.copyWith(
        backDocEId: eId,
        isBackUploading: false,
        uploadFailureOption: none(),
      )),
    );
  }

  FutureOr<void> _onFrontDocumentRemoved(
      _FrontDocumentRemoved event,
      Emitter<UpdateKycState> emit,
      ) async {
    final eId = state.frontDocEId;
    final typeCode = state.selectedIdentityType?.titleCode ?? kIdentityTypeCode;

    if (eId == null) {
      emit(state.copyWith(
        frontDocumentPath: null,
        idTypeCode: typeCode,
        // Only clear the dates OCR filled from this document; the locked
        // ID number and any user-picked dates survive the deletion.
        issueDate: state.issueDateFromOcr ? IssueDate('') : state.issueDate,
        expiryDate: state.expiryDateFromOcr ? ExpiryDate('') : state.expiryDate,
        issueDateFromOcr: false,
        expiryDateFromOcr: false,
        showErrorMessages: false,
        uploadFailureOption: none(),
        deleteFailureOption: none(),
      ));
      return;
    }

    emit(state.copyWith(isFrontDeleting: true, deleteFailureOption: none()));

    final result = await _facade.deleteDocument(eId: eId);

    result.fold(
          (failure) => emit(state.copyWith(
        isFrontDeleting: false,
        deleteFailureOption: some(failure),
      )),
          (_) => emit(state.copyWith(
        isFrontDeleting: false,
        frontDocumentPath: null,
        frontDocEId: null,
        idTypeCode: typeCode,
        issueDate: state.issueDateFromOcr ? IssueDate('') : state.issueDate,
        expiryDate: state.expiryDateFromOcr ? ExpiryDate('') : state.expiryDate,
        issueDateFromOcr: false,
        expiryDateFromOcr: false,
        showErrorMessages: false,
        uploadFailureOption: none(),
        deleteFailureOption: none(),
      )),
    );
  }

  FutureOr<void> _onBackDocumentRemoved(
      _BackDocumentRemoved event,
      Emitter<UpdateKycState> emit,
      ) async {
    final eId = state.backDocEId;

    if (eId == null) {
      emit(state.copyWith(
        backDocumentPath: null,
        uploadFailureOption: none(),
        deleteFailureOption: none(),
      ));
      return;
    }

    emit(state.copyWith(isBackDeleting: true, deleteFailureOption: none()));

    final result = await _facade.deleteDocument(eId: eId);

    result.fold(
          (failure) => emit(state.copyWith(
        isBackDeleting: false,
        deleteFailureOption: some(failure),
      )),
          (_) => emit(state.copyWith(
        isBackDeleting: false,
        backDocumentPath: null,
        backDocEId: null,
        uploadFailureOption: none(),
        deleteFailureOption: none(),
      )),
    );
  }

  // ── Field edits ──────────────────────────────────────────────────────────────

  void _onIdentityNumberChanged(
      _IdentityNumberChanged event,
      Emitter<UpdateKycState> emit,
      ) {
    emit(state.copyWith(
      identityNumber: IdentityNumber(event.value, state.idTypeCode),
    ));
  }

  void _onIssueDateChanged(
      _IssueDateChanged event,
      Emitter<UpdateKycState> emit,
      ) {
    // A manual pick takes ownership of the field — it must no longer be
    // cleared when the scanned document is removed.
    emit(state.copyWith(
      issueDate: IssueDate(event.value),
      issueDateFromOcr: false,
    ));
  }

  void _onExpiryDateChanged(
      _ExpiryDateChanged event,
      Emitter<UpdateKycState> emit,
      ) {
    emit(state.copyWith(
      expiryDate: ExpiryDate(event.value),
      expiryDateFromOcr: false,
    ));
  }

  void _onRemarksChanged(
      _RemarksChanged event,
      Emitter<UpdateKycState> emit,
      ) {
    emit(state.copyWith(remarks: Remarks(event.value)));
  }

  void _onOcrResultReceived(
      _OcrResultReceived event,
      Emitter<UpdateKycState> emit,
      ) {
    final r = event.result;
    // ID type & number are locked to the member's profile on this screen, so
    // only the dates are OCR-fillable. Apply them unconditionally: the scanned
    // card was already validated (with an explicit user override) against the
    // profile back in _captureDocument, so re-gating on OCR card-type here just
    // silently dropped the dates the user had confirmed whenever the card-type
    // read disagreed with the selected type — the QC "dates not reflecting" bug.
    emit(state.copyWith(
      issueDate:
      r.issueDate != null ? IssueDate(r.issueDate) : state.issueDate,
      expiryDate:
      r.expiryDate != null ? ExpiryDate(r.expiryDate) : state.expiryDate,
      issueDateFromOcr: r.issueDate != null || state.issueDateFromOcr,
      expiryDateFromOcr: r.expiryDate != null || state.expiryDateFromOcr,
    ));
  }

  // ── Submit ───────────────────────────────────────────────────────────────────

  FutureOr<void> _onSubmitPressed(
      _SubmitPressed event,
      Emitter<UpdateKycState> emit,
      ) async {
    final docsReady =
        state.frontDocEId != null && state.backDocEId != null;
    final fieldsValid =
        state.identityNumber.isValid() &&
            state.issueDate.isValid() &&
            state.expiryDate.isValid();

    if (!docsReady || !fieldsValid) {
      emit(state.copyWith(showErrorMessages: true));
      return;
    }

    emit(state.copyWith(
      isSubmitting: true,
      submitFailureOrSuccessOption: none(),
    ));

    final result = await _facade.postUpdateKyc(
      idTypeCode: state.idTypeCode,
      idNumber: state.identityNumber.getOrCrash(),
      issueDate: state.issueDate.getOrCrash(),
      expiryDate: state.expiryDate.getOrCrash(),
      remarks: state.remarks.getOrCrash(),
      frontDocEId: state.frontDocEId!,
      backDocEId: state.backDocEId!,
    );

    emit(state.copyWith(
      isSubmitting: false,
      submitFailureOrSuccessOption: some(result),
    ));
  }
}