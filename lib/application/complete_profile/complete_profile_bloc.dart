import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/common/common_selectable_dto.dart';
import '../../domain/complete_profile/value_validators.dart';
import '../../domain/complete_profile/complete_profile_failure.dart';
import '../../domain/common/common_member_field_dto.dart';
import '../../domain/complete_profile/i_complete_profile_facade.dart';

part 'complete_profile_event.dart';
part 'complete_profile_state.dart';
part 'complete_profile_bloc.freezed.dart';

@injectable
class CompleteProfileBloc
    extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  final ICompleteProfileFacade _facade;

  CompleteProfileBloc(this._facade) : super(CompleteProfileState.initial()) {
    on<_GetMemberFieldSettings>(_onGetMemberFieldSettings);
    on<_GetStates>(_onGetStates);
    on<_GetCities>(_onGetCities);
    on<_FieldChanged>(_onFieldChanged);
    on<_SelfieVideoConfirmed>(_onSelfieVideoConfirmed);
    on<_SelfieVideoRemoved>(_onSelfieVideoRemoved);
    on<_SubmitPressed>(_onSubmitPressed);
  }

  Future<void> _onGetMemberFieldSettings(
      _GetMemberFieldSettings event,
      Emitter<CompleteProfileState> emit,
      ) async {
    emit(CompleteProfileState.initial().copyWith(isLoading: true));

    final result = await _facade.getMemberFieldSettings();

    result.fold(
          (_) => emit(
        state.copyWith(
          isLoading: false,
          memberFieldSettingFailureOrSuccessOption: some(result),
        ),
      ),
          (dto) {
        final fields = dto.data?.allMemberFieldSettingList ?? [];
        final initialValues = <String, DynamicFieldInput>{};
        final lockedFromDefaults = <String>{};
        for (final f in fields) {
          final key = f.fieldName ?? '';
          if (key.isEmpty) continue;
          final trimmed = (f.defaultValue ?? '').trim();
          // Invisible fields are never rendered or validated, but a server
          // default is still carried into the submit payload.
          if (f.visible == false) {
            if (trimmed.isNotEmpty) {
              initialValues[key] = DynamicFieldInput(
                input: trimmed,
                mandatory: false,
                minLength: null,
                maxLength: null,
              );
            }
            continue;
          }
          // The backend field settings are authoritative for every visible
          // field — apply its length and regex constraints regardless of type
          // (mirrors the beneficiary form's _makeFieldInput).
          initialValues[key] = DynamicFieldInput(
            input: trimmed,
            mandatory: f.mandatory ?? false,
            minLength: f.minimumLength,
            maxLength: f.maximumLength,
            regexPattern: f.regexPattern,
          );
          if (trimmed.isNotEmpty) lockedFromDefaults.add(key);
        }
        final seeded = _applyDropdownDefaults(initialValues, fields);
        final comboOptions = _buildComboOptions(fields);
        // Server-disabled fields render read-only — but only when they
        // already carry a value, otherwise the user could never satisfy a
        // mandatory field.
        final lockedFromDisabled = <String>{
          for (final f in fields)
            if (f.fieldName != null &&
                f.enabled == false &&
                (seeded[f.fieldName]?.value.getOrElse(() => '') ?? '')
                    .isNotEmpty)
              f.fieldName!,
        };
        // Values the backend fetched from Malaa eKYC are authoritative
        // identity data — lock the field (only when it actually carries a
        // prefilled value) so verified identity data can't be edited.
        final lockedFromMalaa = <String>{
          for (final f in fields)
            if (f.fieldName != null &&
                f.isFromMalaa == true &&
                (seeded[f.fieldName]?.value.getOrElse(() => '') ?? '')
                    .isNotEmpty)
              f.fieldName!,
        };
        // A prefill can only lock a dropdown when it matches one of the
        // field's options. An unmatched prefill means the user still has to
        // pick — and the field must stay editable after they do, so the lock
        // decision is made once here, never against the live value.
        final lockedCandidates = lockedFromDefaults
            .union(lockedFromDisabled)
            .union(lockedFromMalaa);
        final lockedValidated = <String>{};
        for (final f in fields) {
          final key = f.fieldName ?? '';
          if (!lockedCandidates.contains(key)) continue;
          if (_isDropdownType(f.type)) {
            final value = seeded[key]?.value.getOrElse(() => '') ?? '';
            final hasMatch = (comboOptions[key] ?? []).any(
                  (item) => item.titleCode == value,
            );
            if (!hasMatch) continue;
          }
          lockedValidated.add(key);
        }
        emit(
          state.copyWith(
            isLoading: false,
            memberFieldSettingDto: dto,
            dynamicFieldValues: seeded,
            comboOptions: comboOptions,
            lockedFields: lockedValidated,
            memberFieldSettingFailureOrSuccessOption: some(result),
          ),
        );
        if (_findField(fields, 'statecode') != null) {
          add(const CompleteProfileEvent.getStates());
        }
      },
    );
  }

  Future<void> _onGetStates(
      _GetStates event,
      Emitter<CompleteProfileState> emit,
      ) async {
    final fields =
        state.memberFieldSettingDto?.data?.allMemberFieldSettingList ?? [];
    final stateField = _findField(fields, 'statecode');
    if (stateField == null) return;

    final result = await _facade.getStates();
    result.fold((_) {}, (dto) {
      final items = (dto.data?.stateList ?? [])
          .map((s) => CommonSelectableItem(titleCode: s.code, titleName: s.name))
          .toList();
      if (items.isEmpty) return;
      final stateKey = stateField.fieldName!;
      final updated = Map<String, List<CommonSelectableItem>>.from(
        state.comboOptions,
      );
      updated[stateKey] = items;
      // The state field's options weren't known at load time, so its prefill
      // lock was deferred to here. Lock only when the field still holds the
      // untouched backend default and that default is a real option — a value
      // the user picked themselves must never lock.
      final defaultValue = (stateField.defaultValue ?? '').trim();
      final current =
          state.dynamicFieldValues[stateKey]?.value.getOrElse(() => '') ?? '';
      final lockPrefill =
          defaultValue.isNotEmpty &&
              current == defaultValue &&
              items.any((item) => item.titleCode == current);
      emit(
        state.copyWith(
          comboOptions: updated,
          lockedFields: lockPrefill
              ? {...state.lockedFields, stateKey}
              : state.lockedFields,
        ),
      );
    });
  }

  Future<void> _onGetCities(
      _GetCities event,
      Emitter<CompleteProfileState> emit,
      ) async {
    final fields =
        state.memberFieldSettingDto?.data?.allMemberFieldSettingList ?? [];
    final cityField = _findField(fields, 'cityid');
    if (cityField == null) return;

    final cityFieldName = cityField.fieldName!;

    // Clear previous city options and reset the city selection before fetching.
    final clearedOptions = Map<String, List<CommonSelectableItem>>.from(
      state.comboOptions,
    )..remove(cityFieldName);

    final clearedValues = Map<String, DynamicFieldInput>.from(
      state.dynamicFieldValues,
    );
    clearedValues[cityFieldName] = DynamicFieldInput(
      input: '',
      mandatory: cityField.mandatory ?? false,
      minLength: cityField.minimumLength,
      maxLength: cityField.maximumLength,
      regexPattern: cityField.regexPattern,
    );

    emit(
      state.copyWith(
        isLoadingCities: true,
        comboOptions: clearedOptions,
        dynamicFieldValues: clearedValues,
      ),
    );

    final result = await _facade.getCities(event.stateCode);
    result.fold((_) => emit(state.copyWith(isLoadingCities: false)), (dto) {
      final items = (dto.data?.cityList ?? [])
          .map((c) => CommonSelectableItem(titleCode: c.code, titleName: c.name))
          .toList();
      final updated = Map<String, List<CommonSelectableItem>>.from(
        state.comboOptions,
      );
      if (items.isNotEmpty) updated[cityFieldName] = items;
      emit(state.copyWith(isLoadingCities: false, comboOptions: updated));
    });
  }

  MemberFieldSetting? _findField(
      List<MemberFieldSetting> fields,
      String normalizedTarget,
      ) {
    for (final f in fields) {
      final key = f.fieldName ?? '';
      if (key.toLowerCase().replaceAll(RegExp(r'[\s_]+'), '') ==
          normalizedTarget) {
        return f;
      }
    }
    return null;
  }

  // Dropdown options arrive inline on each field setting (dropdown_items),
  // keyed by the field's own name — no separate combo endpoint.
  Map<String, List<CommonSelectableItem>> _buildComboOptions(
      List<MemberFieldSetting> fields,
      ) {
    final result = <String, List<CommonSelectableItem>>{};
    for (final f in fields) {
      final key = f.fieldName ?? '';
      if (key.isEmpty) continue;
      final items = (f.dropdownItems ?? [])
          .map(
            (e) => CommonSelectableItem(titleCode: e.code, titleName: e.name),
      )
          .toList();
      if (items.isNotEmpty) result[key] = items;
    }
    return result;
  }

  // Seeds still-empty dropdowns with the option the API flags as is_default,
  // so a backend-provided default_value always wins over the generic default.
  Map<String, DynamicFieldInput> _applyDropdownDefaults(
      Map<String, DynamicFieldInput> values,
      List<MemberFieldSetting> fields,
      ) {
    final updated = Map<String, DynamicFieldInput>.from(values);
    for (final f in fields) {
      final key = f.fieldName ?? '';
      if (key.isEmpty || !updated.containsKey(key)) continue;
      if (updated[key]!.value.getOrElse(() => '').isNotEmpty) continue;
      final code = _defaultDropdownCode(f);
      if (code.isEmpty) continue;
      updated[key] = DynamicFieldInput(
        input: code,
        mandatory: f.mandatory ?? false,
        minLength: f.minimumLength,
        maxLength: f.maximumLength,
        regexPattern: f.regexPattern,
      );
    }
    return updated;
  }

  // The option the API flags as is_default, used when the field carries no
  // explicit default_value.
  String _defaultDropdownCode(MemberFieldSetting f) {
    for (final item in f.dropdownItems ?? const <MemberFieldDropdownItem>[]) {
      if (item.isDefault == true) return item.code ?? '';
    }
    return '';
  }

  void _onFieldChanged(
      _FieldChanged event,
      Emitter<CompleteProfileState> emit,
      ) {
    final updated = Map<String, DynamicFieldInput>.from(
      state.dynamicFieldValues,
    );
    updated[event.fieldName] = DynamicFieldInput(
      input: event.value,
      mandatory: event.field.mandatory ?? false,
      minLength: event.field.minimumLength,
      maxLength: event.field.maximumLength,
      regexPattern: event.field.regexPattern,
    );
    emit(state.copyWith(dynamicFieldValues: updated));

    // When the state field changes, fetch cities for the newly selected state.
    final normalized = event.fieldName.toLowerCase().replaceAll(
      RegExp(r'[\s_]+'),
      '',
    );
    if (normalized == 'statecode' && event.value.isNotEmpty) {
      add(CompleteProfileEvent.getCities(stateCode: event.value));
    }
  }

  // Mirrors AppGlobal.mapFieldType's dropdown cases (presentation layer).
  bool _isDropdownType(String? type) {
    final t = type?.toLowerCase().trim() ?? '';
    return t == 'dropdown' || t == 'subdropdown' || t == 'autofill';
  }

  String _formatValue(String value, String? type) {
    if (_isDateType(type) && value.isNotEmpty) return _toApiDate(value);
    return value;
  }

  bool _isDateType(String? type) {
    final t = type?.toLowerCase().trim() ?? '';
    return t == 'datepicker' || t == 'date' || t == 'datefield';
  }

  String _toApiDate(String ddmmyyyy) {
    final p = ddmmyyyy.split('/');
    if (p.length != 3) return ddmmyyyy;
    return '${p[2]}-${p[1].padLeft(2, '0')}-${p[0].padLeft(2, '0')}';
  }

  String _toSnakeCase(String key) {
    return key
        .replaceAllMapped(
      RegExp(r'([a-z0-9])([A-Z])'),
          (m) => '${m[1]}_${m[2]}',
    )
        .replaceAllMapped(
      RegExp(r'([A-Z]+)([A-Z][a-z])'),
          (m) => '${m[1]}_${m[2]}',
    )
        .toLowerCase();
  }

  Future<void> _onSelfieVideoConfirmed(
      _SelfieVideoConfirmed event,
      Emitter<CompleteProfileState> emit,
      ) async {
    emit(
      state.copyWith(
        selfieVideoPath: event.videoPath,
        selfieVideoThumbnailPath: event.thumbnailPath,
        selfieVideoEId: null,
        isSelfieVideoUploading: true,
        videoFailureOption: none(),
      ),
    );

    final result = await _facade.uploadSelfieVideo(file: File(event.videoPath));

    result.fold(
          (failure) => emit(
        state.copyWith(
          selfieVideoPath: null,
          selfieVideoThumbnailPath: null,
          isSelfieVideoUploading: false,
          videoFailureOption: some(failure),
        ),
      ),
          (eId) => emit(
        state.copyWith(
          selfieVideoPath: null,
          selfieVideoEId: eId,
          isSelfieVideoUploading: false,
          videoFailureOption: none(),
        ),
      ),
    );
  }

  Future<void> _onSelfieVideoRemoved(
      _SelfieVideoRemoved event,
      Emitter<CompleteProfileState> emit,
      ) async {
    final eId = state.selfieVideoEId;

    if (eId == null) {
      emit(
        state.copyWith(
          selfieVideoPath: null,
          selfieVideoThumbnailPath: null,
          videoFailureOption: none(),
        ),
      );
      return;
    }

    emit(
      state.copyWith(isSelfieVideoDeleting: true, videoFailureOption: none()),
    );

    final result = await _facade.deleteSelfieVideo(eId: eId);

    result.fold(
          (failure) => emit(
        state.copyWith(
          isSelfieVideoDeleting: false,
          videoFailureOption: some(failure),
        ),
      ),
          (_) => emit(
        state.copyWith(
          isSelfieVideoDeleting: false,
          selfieVideoPath: null,
          selfieVideoThumbnailPath: null,
          selfieVideoEId: null,
          videoFailureOption: none(),
        ),
      ),
    );
  }

  Future<void> _onSubmitPressed(
      _SubmitPressed event,
      Emitter<CompleteProfileState> emit,
      ) async {
    emit(state.copyWith(showErrorMessages: true));

    final hasErrors = state.dynamicFieldValues.values.any(
          (v) => v.value.isLeft(),
    );
    if (hasErrors) return;

    emit(
      state.copyWith(isSubmitting: true, submitFailureOrSuccessOption: none()),
    );

    final fieldTypeMap = {
      for (final f
      in state.memberFieldSettingDto?.data?.allMemberFieldSettingList ?? [])
        if (f.fieldName != null) f.fieldName!: f.type,
    };

    final data = <String, dynamic>{
      for (final entry in state.dynamicFieldValues.entries)
        _toSnakeCase(entry.key): _formatValue(
          entry.value.value.getOrElse(() => ''),
          fieldTypeMap[entry.key],
        ),
      if (state.selfieVideoEId != null)
        'doc_ref': [
          {'e_id': state.selfieVideoEId},
        ],
    };

    final result = await _facade.submitProfile(data);

    emit(
      state.copyWith(
        isSubmitting: false,
        submitFailureOrSuccessOption: some(result),
      ),
    );
  }
}
