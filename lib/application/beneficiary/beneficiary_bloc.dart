import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/beneficiary/beneficiary_bank_branch_combo_list_dto.dart';
import '../../domain/beneficiary/beneficiary_bank_combo_list_dto.dart';
import '../../domain/beneficiary/beneficiary_bank_or_agent_list_dto.dart';
import '../../domain/beneficiary/beneficiary_by_id_dto.dart';
import '../../domain/beneficiary/beneficiary_country_list_dto.dart';
import '../../domain/beneficiary/beneficiary_currency_list_dto.dart';
import '../../domain/beneficiary/beneficiary_failure.dart';
import '../../domain/beneficiary/beneficiary_field_keys.dart';
import '../../domain/beneficiary/beneficiary_list_dto.dart';
import '../../domain/beneficiary/beneficiary_product_field_settings_dto.dart';
import '../../domain/beneficiary/beneficiary_purpose_of_transfer_dto.dart';
import '../../domain/beneficiary/beneficiary_source_of_fund_dto.dart';
import '../../domain/beneficiary/beneficiary_transfer_mode_list_dto.dart';
import '../../domain/beneficiary/i_beneficiary_facade.dart';
import '../../domain/beneficiary/value_validators.dart';
import '../../domain/common/common_combo_dto.dart';
import '../../domain/common/common_selectable_dto.dart';
import '../../domain/home/home_mandatory_field_check_dto.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/beneficiary/beneficiary_bank_branch_route_dto.dart';
import '../../domain/beneficiary/beneficiary_route_code_dto.dart';
import '../../presentation/core/country/app_country.dart';

part 'beneficiary_event.dart';
part 'beneficiary_state.dart';
part 'beneficiary_bloc.freezed.dart';

@injectable
class BeneficiaryBloc extends Bloc<BeneficiaryEvent, BeneficiaryState> {
  final IBeneficiaryFacade _beneficiaryFacade;

  BeneficiaryBloc(this._beneficiaryFacade) : super(BeneficiaryState.initial()) {
    on<_GetBeneficiaries>(_onGetBeneficiariesToState);
    on<_GetBeneficiaryById>(_onGetBeneficiaryByIdToState);
    on<_PrepareBeneficiaryForEdit>(_onPrepareBeneficiaryForEditToState);
    on<_PrepareBeneficiaryForAddFromHome>(
      _onPrepareBeneficiaryForAddFromHomeToState,
    );
    on<_GetBeneficiaryCountries>(_onGetBeneficiaryCountriesToState);
    on<_BeneficiaryCountrySelected>(_onBeneficiaryCountrySelectedToState);
    on<_GetBeneficiaryCurrencies>(_onGetBeneficiaryCurrenciesToState);
    on<_BeneficiaryCurrencySelected>(_onBeneficiaryCurrencySelectedToState);
    on<_GetBeneficiaryTransferTypes>(_onGetBeneficiaryTransferTypesToState);
    on<_BeneficiaryTransferTypeSelected>(
      _onBeneficiaryTransferTypeSelectedToState,
    );
    on<_GetBeneficiaryBanksOrAgents>(_onGetBeneficiaryBanksOrAgentsToState);
    on<_BeneficiaryBankOrAgentSelected>(
      _onBeneficiaryBankOrAgentSelectedToState,
    );
    on<_GetBeneficiaryProductFields>(_onGetBeneficiaryProductFieldsToState);
    on<_BeneficiaryProductFieldChanged>(
      _onBeneficiaryProductFieldChangedToState,
    );
    on<_ClearBeneficiaryProductFieldValue>(
      _onClearBeneficiaryProductFieldValueToState,
    );
    on<_GetBranchCombo>(_onGetBranchComboToState);
    on<_BeneficiaryPurposeOfTransactionSelected>(
      _onBeneficiaryPurposeOfTransactionSelectedToState,
    );
    on<_BeneficiarySourceOfFundSelected>(
      _onBeneficiarySourceOfFundSelectedToState,
    );
    on<_SaveOrUpdateBeneficiaryPressed>(
      _onSaveOrUpdateBeneficiaryPressedToState,
    );
    on<_BeneficiaryOtpChanged>(_onBeneficiaryOtpChangedToState);
    on<_BeneficiaryOtpSubmitted>(_onBeneficiaryOtpSubmittedToState);
    on<_ResendBeneficiaryOtp>(_onResendBeneficiaryOtpToState);
    on<_BeneficiaryBankComboChanged>(_onBeneficiaryBankComboChangedToState);
    on<_BeneficiaryBranchComboChanged>(_onBeneficiaryBranchComboChangedToState);
    on<_BeneficiaryRouteCodeChanged>(
      (event, emit) => _handleRouteCodeLookup(event.routeCode, emit),
      transformer: _debounce(const Duration(milliseconds: 500)),
    );
    // Dropdown selection uses the same lookup logic but fires immediately.
    on<_BeneficiaryRouteCodeSelected>(
      (event, emit) => _handleRouteCodeLookup(event.routeCode, emit),
    );
    on<_LoadFormSupportData>(_onLoadFormSupportDataToState);
    on<_DeleteBeneficiary>(_onDeleteBeneficiaryToState);
    on<_PaymentRequested>(_onPaymentRequested);
    on<_PaymentAgentSelected>(_onPaymentAgentSelected);
  }

  static const _bankCodeField = 'beneficiaryBankCode';
  static const _branchCodeField = 'beneficiaryBranchCode';
  static const _routeCodeField = 'routeCode';

  FutureOr<void> _onGetBeneficiariesToState(
    _GetBeneficiaries event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      BeneficiaryState.initial().copyWith(
        isLoading: true,
        isListLoading: true,
        // Carry the current list over while (re)loading so a refresh after an
        // add/edit keeps the records on screen and the UI can show a light
        // refresh cue instead of collapsing back to the first-load shimmer.
        beneficiaryListDto: state.beneficiaryListDto,
        beneficiaryFailureOrSuccessOption: none(),
      ),
    );

    final failureOrSuccess = await _beneficiaryFacade.getBeneficiaryList();

    failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          isListLoading: false,
          beneficiaryFailureOrSuccessOption: some(left(failure)),
        ),
      ),
      (data) => emit(
        state.copyWith(
          isLoading: false,
          isListLoading: false,
          beneficiaryListDto: data,
          beneficiaryFailureOrSuccessOption: some(right(data)),
        ),
      ),
    );
  }

  FutureOr<void> _onGetBeneficiaryByIdToState(
    _GetBeneficiaryById event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      BeneficiaryState.initial().copyWith(
        isLoading: true,
        isInitialLoading: true,
        // Carried through prepareBeneficiaryForEdit (state.copyWith) so the save
        // handlers know to continue to the summary. Reset by initial() on every
        // other edit/add entry point.
        proceedToSummaryAfterSave: event.proceedToSummaryAfterSave,
        beneficiaryListDto: state.beneficiaryListDto,
        beneficiaryByIdFailureOrSuccessOption: none(),
      ),
    );

    final failureOrSuccess = await _beneficiaryFacade.getBeneficiaryById(
      beneficiaryId: event.beneficiaryId ?? '',
    );

    failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          beneficiaryByIdFailureOrSuccessOption: some(left(failure)),
        ),
      ),
      (data) {
        emit(
          state.copyWith(
            isLoading: false,
            beneficiaryByIdDto: data,
            beneficiaryByIdFailureOrSuccessOption: some(right(data)),
          ),
        );
        final beneficiary = data.data?.beneficiaryById;
        if (beneficiary != null) {
          final beneficiaryCountryCode = beneficiary.beneficiaryCountryCode;
          final beneficiaryCurrencyCode = beneficiary.currencyCode;
          final beneficiaryTransferTypeCode = beneficiary.disbursalMode;
          // In the product-switch edit flow (Edit from the home mandatory-field
          // check) the bank/agent, product and service come from the corridor
          // the user selected on home — so getBeneficiaryProductFields fetches
          // the new product's dynamic fields and the update payload re-targets
          // it. A plain edit falls back to the beneficiary's saved values.
          final beneficiaryBankOrAgent =
              event.bankOrAgentOverride ??
              CommonSelectableItem(
                // The bank/agent selection is the product now: its code IS the
                // product code (never the bank code). The bank/agent name+code
                // fields come from the product's dynamic field settings. The
                // display name is only shown in the add-section, which is hidden
                // in edit mode, so the saved bank/agent name is a fine label.
                titleName:
                    beneficiary.beneficiaryBankName ??
                    beneficiary.beneficiaryAgentName,
                titleCode: beneficiary.productCode.toString(),
              );
          final purposeOfTransactionName = beneficiary.purposeName;
          final purposeOfTransactionCode = beneficiary.purposeOfTransaction;
          final sourceOfFundName = beneficiary.incomeSourceName;
          final sourceOfFundCode = beneficiary.sourceOfFund;
          add(
            BeneficiaryEvent.prepareBeneficiaryForEdit(
              beneficiaryCountry: CommonSelectableItem(
                titleCode: beneficiaryCountryCode,
              ),
              beneficiaryCurrency: CommonSelectableItem(
                trailingCode: beneficiaryCurrencyCode,
              ),
              beneficiaryTransferType: CommonSelectableItem(
                titleCode: beneficiaryTransferTypeCode,
              ),
              beneficiaryBankOrAgent: beneficiaryBankOrAgent,
              beneficiaryPurposeOfTransaction: CommonSelectableItem(
                titleCode: purposeOfTransactionCode,
                titleName: purposeOfTransactionName,
              ),
              beneficiarySourceOfFund: CommonSelectableItem(
                titleCode: sourceOfFundCode,
                titleName: sourceOfFundName,
              ),
            ),
          );
        }
      },
    );
  }

  FutureOr<void> _onPrepareBeneficiaryForEditToState(
    _PrepareBeneficiaryForEdit event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      state.copyWith(
        isEditing: true,
        beneficiaryListDto: state.beneficiaryListDto,
        selectedBeneficiaryCountry: event.beneficiaryCountry,
        selectedBeneficiaryCurrency: event.beneficiaryCurrency,
        selectedBeneficiaryTransferType: event.beneficiaryTransferType,
        selectedBeneficiaryBankOrAgent: event.beneficiaryBankOrAgent,
        selectedBeneficiaryPurposeOfTransaction:
            event.beneficiaryPurposeOfTransaction,
        selectedBeneficiarySourceOfFund: event.beneficiarySourceOfFund,
      ),
    );
    add(const BeneficiaryEvent.getBeneficiaryProductFields());
  }

  FutureOr<void> _onPrepareBeneficiaryForAddFromHomeToState(
    _PrepareBeneficiaryForAddFromHome event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      BeneficiaryState.initial().copyWith(
        isInitialLoading: true,
        isAddingFromHome: true,
        beneficiaryListDto: state.beneficiaryListDto,
        selectedBeneficiaryCountry: event.beneficiaryCountry,
        selectedBeneficiaryCurrency: event.beneficiaryCurrency,
        selectedBeneficiaryTransferType: event.beneficiaryTransferType,
        selectedBeneficiaryBankOrAgent: event.beneficiaryBankOrAgent,
      ),
    );
    add(const BeneficiaryEvent.getBeneficiaryProductFields());
  }

  FutureOr<void> _onGetBeneficiaryCountriesToState(
    _GetBeneficiaryCountries event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      BeneficiaryState.initial().copyWith(
        isLoading: true,
        isInitialLoading: true,
        beneficiaryListDto: state.beneficiaryListDto,
        beneficiaryFailureOrSuccessOption:
            state.beneficiaryFailureOrSuccessOption,
        beneficiaryCountryListFailureOrSuccessOption: none(),
      ),
    );

    final result = await _beneficiaryFacade.getBeneficiaryCountryList();

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          isInitialLoading: false,
          beneficiaryCountryListFailureOrSuccessOption: some(left(failure)),
        ),
      ),
      (data) {
        emit(
          state.copyWith(
            isLoading: false,
            isInitialLoading: state.isInitialLoading,
            beneficiaryCountryListDto: data,
            beneficiaryCountryListFailureOrSuccessOption: some(right(data)),
          ),
        );
        final list = data.data?.countryList ?? [];
        if (list.isNotEmpty && list.length == 1) {
          add(
            BeneficiaryEvent.beneficiaryCountrySelected(
              CommonSelectableItem(
                titleName: list.first.name?.toUpperCase() ?? '',
                titleCode: list.first.code,
                decimalPlaces: list.first.decimalPlace,
              ),
            ),
          );
        }
        if (list.length != 1) emit(state.copyWith(isInitialLoading: false));
      },
    );
  }

  FutureOr<void> _onBeneficiaryCountrySelectedToState(
    _BeneficiaryCountrySelected event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      BeneficiaryState.initial().copyWith(
        isInitialLoading: state.isInitialLoading,
        beneficiaryListDto: state.beneficiaryListDto,
        beneficiaryFailureOrSuccessOption:
            state.beneficiaryFailureOrSuccessOption,
        beneficiaryByIdDto: state.beneficiaryByIdDto,
        beneficiaryByIdFailureOrSuccessOption:
            state.beneficiaryByIdFailureOrSuccessOption,
        beneficiaryCountryListDto: state.beneficiaryCountryListDto,
        beneficiaryCountryListFailureOrSuccessOption:
            state.beneficiaryCountryListFailureOrSuccessOption,
        selectedBeneficiaryCountry: event.selectedBeneficiaryCountry,
      ),
    );

    add(const BeneficiaryEvent.getBeneficiaryCurrencies());
  }

  FutureOr<void> _onGetBeneficiaryCurrenciesToState(
    _GetBeneficiaryCurrencies event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      BeneficiaryState.initial().copyWith(
        isLoading: true,
        isInitialLoading: state.isInitialLoading,
        beneficiaryListDto: state.beneficiaryListDto,
        beneficiaryFailureOrSuccessOption:
            state.beneficiaryFailureOrSuccessOption,
        beneficiaryByIdDto: state.beneficiaryByIdDto,
        beneficiaryByIdFailureOrSuccessOption:
            state.beneficiaryByIdFailureOrSuccessOption,
        beneficiaryCountryListDto: state.beneficiaryCountryListDto,
        selectedBeneficiaryCountry: state.selectedBeneficiaryCountry,
        beneficiaryCountryListFailureOrSuccessOption:
            state.beneficiaryCountryListFailureOrSuccessOption,
        beneficiaryCurrenciesFailureOrSuccessOption: none(),
      ),
    );

    final requestedCountry = state.selectedBeneficiaryCountry?.titleCode ?? '';
    final result = await _beneficiaryFacade.getBeneficiaryCurrencyListByCountry(
      beneficiaryCountryCode: requestedCountry,
    );

    // Stale-response guard: the user may have re-selected the country while
    // this list was in flight. A slower earlier fetch must not overwrite the
    // currencies of the currently-selected country, so drop it if the
    // selection has moved on. The winning request emits normally.
    if ((state.selectedBeneficiaryCountry?.titleCode ?? '') !=
        requestedCountry) {
      return;
    }

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          isInitialLoading: false,
          beneficiaryCurrenciesFailureOrSuccessOption: some(left(failure)),
        ),
      ),
      (data) {
        emit(
          state.copyWith(
            isLoading: false,
            isInitialLoading: state.isInitialLoading,
            beneficiaryCurrencyListDto: data,
            beneficiaryCurrenciesFailureOrSuccessOption: some(right(data)),
          ),
        );

        final list = data.data?.currencyList ?? [];
        if (list.isNotEmpty && list.length == 1) {
          add(
            BeneficiaryEvent.beneficiaryCurrencySelected(
              CommonSelectableItem(
                titleName: list.first.currencyName?.toUpperCase() ?? '',
                titleCode: list.first.currencyCode,
                trailingCode: list.first.currencyCode,
              ),
            ),
          );
        }
        if (list.length != 1) emit(state.copyWith(isInitialLoading: false));
      },
    );
  }

  FutureOr<void> _onBeneficiaryCurrencySelectedToState(
    _BeneficiaryCurrencySelected event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      BeneficiaryState.initial().copyWith(
        isInitialLoading: state.isInitialLoading,
        beneficiaryListDto: state.beneficiaryListDto,
        beneficiaryFailureOrSuccessOption:
            state.beneficiaryFailureOrSuccessOption,
        beneficiaryByIdDto: state.beneficiaryByIdDto,
        beneficiaryByIdFailureOrSuccessOption:
            state.beneficiaryByIdFailureOrSuccessOption,
        beneficiaryCountryListDto: state.beneficiaryCountryListDto,
        selectedBeneficiaryCountry: state.selectedBeneficiaryCountry,
        beneficiaryCountryListFailureOrSuccessOption:
            state.beneficiaryCountryListFailureOrSuccessOption,
        beneficiaryCurrencyListDto: state.beneficiaryCurrencyListDto,
        beneficiaryCurrenciesFailureOrSuccessOption:
            state.beneficiaryCurrenciesFailureOrSuccessOption,
        selectedBeneficiaryCurrency: event.selectedBeneficiaryCurrency,
      ),
    );

    add(const BeneficiaryEvent.getBeneficiaryTransferTypes());
  }

  FutureOr<void> _onGetBeneficiaryTransferTypesToState(
    _GetBeneficiaryTransferTypes event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      BeneficiaryState.initial().copyWith(
        isLoading: true,
        isInitialLoading: state.isInitialLoading,
        beneficiaryListDto: state.beneficiaryListDto,
        beneficiaryFailureOrSuccessOption:
            state.beneficiaryFailureOrSuccessOption,
        beneficiaryByIdDto: state.beneficiaryByIdDto,
        beneficiaryByIdFailureOrSuccessOption:
            state.beneficiaryByIdFailureOrSuccessOption,
        beneficiaryCountryListDto: state.beneficiaryCountryListDto,
        selectedBeneficiaryCountry: state.selectedBeneficiaryCountry,
        beneficiaryCountryListFailureOrSuccessOption:
            state.beneficiaryCountryListFailureOrSuccessOption,
        beneficiaryCurrencyListDto: state.beneficiaryCurrencyListDto,
        selectedBeneficiaryCurrency: state.selectedBeneficiaryCurrency,
        beneficiaryCurrenciesFailureOrSuccessOption:
            state.beneficiaryCurrenciesFailureOrSuccessOption,
        beneficiaryTransferTypesFailureOrSuccessOption: none(),
      ),
    );

    final requestedCountry = state.selectedBeneficiaryCountry?.titleCode ?? '';
    final requestedCurrency =
        state.selectedBeneficiaryCurrency?.trailingCode ?? '';
    final result = await _beneficiaryFacade.getBeneficiaryTransferModeList(
      beneficiaryCountryCode: requestedCountry,
      beneficiaryCurrencyCode: requestedCurrency,
    );

    // Stale-response guard: drop this response if the country/currency
    // selection changed while it was in flight (see currencies handler).
    if ((state.selectedBeneficiaryCountry?.titleCode ?? '') !=
            requestedCountry ||
        (state.selectedBeneficiaryCurrency?.trailingCode ?? '') !=
            requestedCurrency) {
      return;
    }

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          isInitialLoading: false,
          beneficiaryTransferTypesFailureOrSuccessOption: some(left(failure)),
        ),
      ),
      (data) {
        emit(
          state.copyWith(
            isLoading: false,
            isInitialLoading: state.isInitialLoading,
            beneficiaryTransferModeListDto: data,
            beneficiaryTransferTypesFailureOrSuccessOption: some(right(data)),
          ),
        );

        final list = data.data?.transferModeList ?? [];
        if (list.isNotEmpty && list.length == 1) {
          add(
            BeneficiaryEvent.beneficiaryTransferTypeSelected(
              CommonSelectableItem(
                titleName: list.first.name?.toUpperCase() ?? '',
                titleCode: list.first.code,
              ),
            ),
          );
        }
        if (list.length != 1) emit(state.copyWith(isInitialLoading: false));
      },
    );
  }

  FutureOr<void> _onBeneficiaryTransferTypeSelectedToState(
    _BeneficiaryTransferTypeSelected event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      BeneficiaryState.initial().copyWith(
        isInitialLoading: state.isInitialLoading,
        beneficiaryListDto: state.beneficiaryListDto,
        beneficiaryFailureOrSuccessOption:
            state.beneficiaryFailureOrSuccessOption,
        beneficiaryByIdDto: state.beneficiaryByIdDto,
        beneficiaryByIdFailureOrSuccessOption:
            state.beneficiaryByIdFailureOrSuccessOption,
        beneficiaryCountryListDto: state.beneficiaryCountryListDto,
        selectedBeneficiaryCountry: state.selectedBeneficiaryCountry,
        beneficiaryCountryListFailureOrSuccessOption:
            state.beneficiaryCountryListFailureOrSuccessOption,
        beneficiaryCurrencyListDto: state.beneficiaryCurrencyListDto,
        selectedBeneficiaryCurrency: state.selectedBeneficiaryCurrency,
        beneficiaryCurrenciesFailureOrSuccessOption:
            state.beneficiaryCurrenciesFailureOrSuccessOption,
        beneficiaryTransferModeListDto: state.beneficiaryTransferModeListDto,
        beneficiaryTransferTypesFailureOrSuccessOption:
            state.beneficiaryTransferTypesFailureOrSuccessOption,
        selectedBeneficiaryTransferType: event.selectedBeneficiaryTransferType,
      ),
    );

    add(const BeneficiaryEvent.getBeneficiaryBanksOrAgents());
  }

  FutureOr<void> _onGetBeneficiaryBanksOrAgentsToState(
    _GetBeneficiaryBanksOrAgents event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      BeneficiaryState.initial().copyWith(
        isLoading: true,
        isInitialLoading: state.isInitialLoading,
        beneficiaryListDto: state.beneficiaryListDto,
        beneficiaryFailureOrSuccessOption:
            state.beneficiaryFailureOrSuccessOption,
        beneficiaryByIdDto: state.beneficiaryByIdDto,
        beneficiaryByIdFailureOrSuccessOption:
            state.beneficiaryByIdFailureOrSuccessOption,
        beneficiaryCountryListDto: state.beneficiaryCountryListDto,
        selectedBeneficiaryCountry: state.selectedBeneficiaryCountry,
        beneficiaryCountryListFailureOrSuccessOption:
            state.beneficiaryCountryListFailureOrSuccessOption,
        beneficiaryCurrencyListDto: state.beneficiaryCurrencyListDto,
        selectedBeneficiaryCurrency: state.selectedBeneficiaryCurrency,
        beneficiaryCurrenciesFailureOrSuccessOption:
            state.beneficiaryCurrenciesFailureOrSuccessOption,
        beneficiaryTransferModeListDto: state.beneficiaryTransferModeListDto,
        selectedBeneficiaryTransferType: state.selectedBeneficiaryTransferType,
        beneficiaryTransferTypesFailureOrSuccessOption:
            state.beneficiaryTransferTypesFailureOrSuccessOption,
        beneficiaryBankOrAgentListFailureOrSuccessOption: none(),
      ),
    );

    final requestedCountry = state.selectedBeneficiaryCountry?.titleCode ?? '';
    final requestedCurrency =
        state.selectedBeneficiaryCurrency?.trailingCode ?? '';
    final requestedTransferType =
        state.selectedBeneficiaryTransferType?.titleCode ?? '';
    final result = await _beneficiaryFacade.getBeneficiaryBankOrAgentList(
      beneficiaryCountryCode: requestedCountry,
      beneficiaryCurrencyCode: requestedCurrency,
      beneficiaryTransferTypeCode: requestedTransferType,
    );

    // Stale-response guard: this is the exact race from the home send-money
    // flow — the user picks one transfer type (slow bank/agent fetch), then
    // switches to another (fast fetch that resolves first). Without this guard
    // the slower earlier response would overwrite the correct list. Drop it if
    // the corridor selection has moved on.
    if ((state.selectedBeneficiaryCountry?.titleCode ?? '') !=
            requestedCountry ||
        (state.selectedBeneficiaryCurrency?.trailingCode ?? '') !=
            requestedCurrency ||
        (state.selectedBeneficiaryTransferType?.titleCode ?? '') !=
            requestedTransferType) {
      return;
    }

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          isInitialLoading: false,
          beneficiaryBankOrAgentListFailureOrSuccessOption: some(left(failure)),
        ),
      ),
      (data) {
        emit(
          state.copyWith(
            isLoading: false,
            isInitialLoading: state.isInitialLoading,
            beneficiaryBankOrAgentListDto: data,
            beneficiaryBankOrAgentListFailureOrSuccessOption: some(right(data)),
          ),
        );

        final list = data.data?.beneficiaryBankList ?? [];
        if (list.length == 1) {
          add(
            BeneficiaryEvent.beneficiaryBankOrAgentSelected(
              CommonSelectableItem(
                titleName: list.first.name?.toUpperCase() ?? '',
                titleCode: list.first.code.toString(),
              ),
            ),
          );
        }
        if (list.length != 1) emit(state.copyWith(isInitialLoading: false));
      },
    );
  }

  FutureOr<void> _onBeneficiaryBankOrAgentSelectedToState(
    _BeneficiaryBankOrAgentSelected event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      BeneficiaryState.initial().copyWith(
        isInitialLoading: state.isInitialLoading,
        beneficiaryListDto: state.beneficiaryListDto,
        beneficiaryFailureOrSuccessOption:
            state.beneficiaryFailureOrSuccessOption,
        beneficiaryByIdDto: state.beneficiaryByIdDto,
        beneficiaryByIdFailureOrSuccessOption:
            state.beneficiaryByIdFailureOrSuccessOption,
        beneficiaryCountryListDto: state.beneficiaryCountryListDto,
        selectedBeneficiaryCountry: state.selectedBeneficiaryCountry,
        beneficiaryCountryListFailureOrSuccessOption:
            state.beneficiaryCountryListFailureOrSuccessOption,
        beneficiaryCurrencyListDto: state.beneficiaryCurrencyListDto,
        selectedBeneficiaryCurrency: state.selectedBeneficiaryCurrency,
        beneficiaryCurrenciesFailureOrSuccessOption:
            state.beneficiaryCurrenciesFailureOrSuccessOption,
        beneficiaryTransferModeListDto: state.beneficiaryTransferModeListDto,
        selectedBeneficiaryTransferType: state.selectedBeneficiaryTransferType,
        beneficiaryTransferTypesFailureOrSuccessOption:
            state.beneficiaryTransferTypesFailureOrSuccessOption,
        beneficiaryBankOrAgentListDto: state.beneficiaryBankOrAgentListDto,
        beneficiaryBankOrAgentListFailureOrSuccessOption:
            state.beneficiaryBankOrAgentListFailureOrSuccessOption,
        selectedBeneficiaryBankOrAgent: event.selectedBeneficiaryBankOrAgent,
      ),
    );
    add(const BeneficiaryEvent.getBeneficiaryProductFields());
  }

  FutureOr<void> _onGetBeneficiaryProductFieldsToState(
    _GetBeneficiaryProductFields event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        beneficiaryProductSettingsFailureOrSuccessOption: none(),
      ),
    );

    final requestedCountry = state.selectedBeneficiaryCountry?.titleCode ?? '';
    final requestedCurrency =
        state.selectedBeneficiaryCurrency?.trailingCode ?? '';
    final requestedTransferType =
        state.selectedBeneficiaryTransferType?.titleCode ?? '';
    final requestedProductCode =
        state.selectedBeneficiaryBankOrAgent?.titleCode ?? '';
    final result = await _beneficiaryFacade.getBeneficiaryProductFieldSettings(
      beneficiaryCountryCode: requestedCountry,
      beneficiaryCurrencyCode: requestedCurrency,
      beneficiaryTransferTypeCode: requestedTransferType,
      productCode: requestedProductCode,
      // Edit mode: the eId tells the backend to prefill each field's
      // default_value with the beneficiary's saved values.
      eId: state.isEditing
          ? state.beneficiaryByIdDto?.data?.beneficiaryById?.eId
          : null,
    );

    // Stale-response guard: drop these field settings if the bank/agent (or any
    // upstream corridor selection) changed while the request was in flight, so
    // a slower earlier response can't rebuild the form for the wrong product.
    if ((state.selectedBeneficiaryCountry?.titleCode ?? '') !=
            requestedCountry ||
        (state.selectedBeneficiaryCurrency?.trailingCode ?? '') !=
            requestedCurrency ||
        (state.selectedBeneficiaryTransferType?.titleCode ?? '') !=
            requestedTransferType ||
        (state.selectedBeneficiaryBankOrAgent?.titleCode ?? '') !=
            requestedProductCode) {
      return;
    }

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          beneficiaryProductSettingsFailureOrSuccessOption: some(left(failure)),
        ),
      ),
      (data) {
        final fields = data.data?.allProductFieldSettingList?.beneficiary ?? [];

        final initialMap = <String, BeneficiaryDynamicInput>{};
        // Server-disabled fields render read-only — but only when they
        // already carry a value, otherwise the user could never satisfy a
        // mandatory field. (Same rule as registration/complete profile.)
        final lockedFields = <String>{};

        for (final field in fields) {
          final fieldName = field.fieldName ?? '';

          // Value is backend-prefilled through default_value in both modes: in
          // edit mode it carries the beneficiary's saved value, in add mode the
          // field's configured default. Add mode only: an empty default falls
          // back to the dropdown option flagged is_default.
          String value = (field.defaultValue ?? '').trim();
          if (value.isEmpty && !state.isEditing) {
            value = _defaultDropdownCode(field);
          }

          // Backend may return the branch as a composite "179481|065002" —
          // keep only the branch code, here at the single ingestion point, so
          // dropdown matching and the update payload always see the clean code.
          if (BeneficiaryFieldKeys.normalize(fieldName) ==
              BeneficiaryFieldKeys.branchCode) {
            value = value.split('|').last.trim();
          }

          // Dropdown fields with inline options: default_value is an option
          // code, so keep it only when it actually exists in this field's
          // dropdown_items — an unknown code shows nothing. Text/date and
          // cascade fields (no inline options) show the value directly.
          final inlineOptions =
              field.dropdownItems ?? const <BeneficiaryDropdownItem>[];
          if (value.isNotEmpty &&
              inlineOptions.isNotEmpty &&
              !inlineOptions.any((o) => (o.code ?? '').trim() == value)) {
            value = '';
          }

          // Invisible fields are never rendered or validated, but their
          // value still rides into the save payload.
          if (field.visible == false) {
            initialMap[fieldName] = BeneficiaryDynamicInput(
              input: value,
              mandatory: false,
              minLength: null,
              maxLength: null,
            );
            continue;
          }

          // Stored codes must keep their original case: dropdown options are
          // matched by exact code, and the value is echoed back to the API.
          initialMap[fieldName] = BeneficiaryDynamicInput(
            input: value,
            mandatory: field.mandatory ?? false,
            minLength: field.minimumLength,
            maxLength: field.maximumLength,
            regexPattern: field.regexPattern,
          );

          // An unmatched inline-dropdown prefill was already cleared above,
          // so a non-empty value here is safe to lock on.
          if (field.enabled == false && value.isNotEmpty) {
            lockedFields.add(fieldName);
          }
        }

        // Dropdown options arrive inline on each field setting
        // (dropdown_items), keyed by the normalized field name the dropdown
        // widget looks up. Cascade lists (bank/branch/route) stay API-driven.
        final comboLists = Map<String, List<ComboItem>>.from(state.comboLists);
        for (final field in fields) {
          final items = (field.dropdownItems ?? [])
              .map((e) => ComboItem(code: e.code ?? '', name: e.name ?? ''))
              .toList();
          if (items.isNotEmpty) {
            comboLists[BeneficiaryFieldKeys.normalize(field.fieldName)] = items;
          }
        }

        emit(
          state.copyWith(
            isLoading: false,
            isInitialLoading: !state.isEditing ? false : state.isInitialLoading,
            dynamicFieldValues: initialMap,
            initialDynamicFieldValues: initialMap,
            lockedFields: lockedFields,
            comboLists: comboLists,
            beneficiaryProductFieldSettingsDto: data,
            beneficiaryProductSettingsFailureOrSuccessOption: some(right(data)),
          ),
        );

        add(const BeneficiaryEvent.loadFormSupportData());
      },
    );
  }

  FutureOr<void> _onBeneficiaryProductFieldChangedToState(
    _BeneficiaryProductFieldChanged event,
    Emitter<BeneficiaryState> emit,
  ) async {
    final validated = BeneficiaryDynamicInput(
      input: event.value,
      mandatory: event.backendField.mandatory ?? false,
      minLength: event.backendField.minimumLength,
      maxLength: event.backendField.maximumLength,
      regexPattern: event.backendField.regexPattern,
    );

    emit(
      state.copyWith(
        saveBeneficiaryFailureOrSuccessOption: none(),
        dynamicFieldValues: {
          ...state.dynamicFieldValues,
          event.backendField.fieldName ?? '': validated,
        },
      ),
    );
  }

  FutureOr<void> _onClearBeneficiaryProductFieldValueToState(
    _ClearBeneficiaryProductFieldValue event,
    Emitter<BeneficiaryState> emit,
  ) async {
    final field = event.backendField;

    final cleared = BeneficiaryDynamicInput(
      input: '',
      mandatory: field.mandatory ?? false,
      minLength: field.minimumLength,
      maxLength: field.maximumLength,
      regexPattern: field.regexPattern,
    );

    emit(
      state.copyWith(
        saveBeneficiaryFailureOrSuccessOption: none(),
        dynamicFieldValues: {
          ...state.dynamicFieldValues,
          field.fieldName ?? '': cleared,
        },
      ),
    );
  }

  FutureOr<void> _onGetBranchComboToState(
    _GetBranchCombo event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        beneficiaryBankBranchComboListFailureOrSuccessOption: none(),
      ),
    );
    final result = await _beneficiaryFacade.getBeneficiaryBankBranchList(
      productCode: state.selectedBeneficiaryBankOrAgent?.titleCode ?? '',
      beneficiaryBankName: event.bankName ?? '',
      beneficiaryBankCode: event.bankCode ?? '',
      beneficiaryCountryCode: state.selectedBeneficiaryCountry?.titleCode ?? '',
      beneficiaryCurrencyCode:
          state.selectedBeneficiaryCurrency?.trailingCode ?? '',
      transferTypeModeCode:
          state.selectedBeneficiaryTransferType?.titleCode ?? '',
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          beneficiaryBankBranchComboListFailureOrSuccessOption: some(
            left(failure),
          ),
        ),
      ),
      (data) {
        final comboLists = <String, List<ComboItem>>{
          ...state.comboLists,
          BeneficiaryFieldKeys.branchCode:
              data.data?.beneficiaryBranchList
                  ?.map((e) => ComboItem(code: e.code ?? '', name: e.name ?? ''))
                  .toList() ??
              [],
        };
        // The branch list has landed: drop a stored branch code it doesn't
        // contain, along with the route code that hangs off it.
        final pruned = _pruneUnmatchedComboValues(
          state,
          comboLists,
          loadedKey: BeneficiaryFieldKeys.branchCode,
        );
        emit(
          state.copyWith(
            isLoading: false,
            // Keep track of which bank the branch list belongs to.
            // Used by beneficiaryBranchComboChanged to call getBeneficiaryRouteCode.
            selectedBankComboCode: event.bankCode ?? '',
            comboLists: comboLists,
            dynamicFieldValues: pruned.fields,
            lockedFields: pruned.lockedFields,
            beneficiaryBankBranchComboListFailureOrSuccessOption: some(
              right(data),
            ),
          ),
        );
      },
    );

    // If the call carried an expected branch (from IFSC reverse-fill), validate
    // it against the freshly loaded list and store only if found. Graceful
    // no-op if the branch isn't in the list. Runs in both modes: editing a
    // beneficiary's route code re-resolves its bank and branch exactly like
    // adding one does, and the edit-mode block below reads the branch back out
    // of state, so it has to be stored first.
    final expectedBranch = event.expectedBranchCode ?? '';
    if (expectedBranch.isNotEmpty) {
      final branchList = state.comboLists[BeneficiaryFieldKeys.branchCode] ?? [];
      final branchInList = branchList.any((b) => b.code == expectedBranch);
      final branchField = _fieldNameFor(
        state.dynamicFieldValues,
        BeneficiaryFieldKeys.branchCode,
      );
      if (branchInList && branchField != null) {
        final updated = Map<String, BeneficiaryDynamicInput>.from(
          state.dynamicFieldValues,
        );
        updated[branchField] = _makeFieldInput(
          state,
          branchField,
          expectedBranch,
        );
        emit(state.copyWith(dynamicFieldValues: updated));
      }
    }

    if (!state.isEditing) return;

    // Edit mode: route code is already pre-filled from the saved beneficiary.
    // Fetch the route code combo list so the dropdown can render it.
    // The stored branch code is already clean — composite "bank|branch" values
    // are split once at seeding in _onGetBeneficiaryProductFieldsToState.
    final branchCode =
        state.dynamicFieldValues[_branchCodeField]?.value.getOrElse(() => '') ??
        '';

    // Only fetch/show the route code when the product configures a routeCode field.
    final hasRouteCodeField = state.dynamicFieldValues.containsKey(
      _routeCodeField,
    );
    if (!hasRouteCodeField ||
        branchCode.isEmpty ||
        (event.bankCode ?? '').isEmpty) {
      emit(state.copyWith(isInitialLoading: false));
      return;
    }

    emit(state.copyWith(isRouteCodeLoading: true));

    final routeResult = await _beneficiaryFacade.getBeneficiaryRouteCode(
      productCode: state.selectedBeneficiaryBankOrAgent?.titleCode ?? '',
      beneficiaryBankCode: event.bankCode ?? '',
      beneficiaryBankBranchCode: branchCode,
      transferTypeModeCode:
          state.selectedBeneficiaryTransferType?.titleCode ?? '',
    );

    routeResult.fold(
      (failure) => emit(
        state.copyWith(isRouteCodeLoading: false, isInitialLoading: false),
      ),
      (dto) {
        final list = dto.data?.beneficiaryRouteCodeList ?? [];
        final comboLists = <String, List<ComboItem>>{
          ...state.comboLists,
          BeneficiaryFieldKeys.routeCode: list
              .map((e) => ComboItem(code: e.code ?? '', name: e.code ?? ''))
              .toList(),
        };
        // The route list has landed: drop the saved route code when this
        // bank/branch's list doesn't offer it.
        final pruned = _pruneUnmatchedComboValues(
          state,
          comboLists,
          loadedKey: BeneficiaryFieldKeys.routeCode,
        );
        final routeField = _fieldNameFor(
          pruned.fields,
          BeneficiaryFieldKeys.routeCode,
        );
        final hasRouteCode =
            routeField != null &&
            pruned.fields[routeField]!.value
                .getOrElse(() => '')
                .trim()
                .isNotEmpty;
        emit(
          state.copyWith(
            isRouteCodeLoading: false,
            isInitialLoading: false,
            isRouteCodeAutoFilled: hasRouteCode,
            beneficiaryRouteCodeDto: dto,
            comboLists: comboLists,
            dynamicFieldValues: pruned.fields,
            lockedFields: pruned.lockedFields,
          ),
        );
      },
    );
  }

  FutureOr<void> _onBeneficiaryPurposeOfTransactionSelectedToState(
    _BeneficiaryPurposeOfTransactionSelected event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedBeneficiaryPurposeOfTransaction:
            event.selectedPurposeOfTransaction,
      ),
    );
  }

  FutureOr<void> _onBeneficiarySourceOfFundSelectedToState(
    _BeneficiarySourceOfFundSelected event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedBeneficiarySourceOfFund: event.selectedSourceOfFund,
      ),
    );
  }

  FutureOr<void> _onSaveOrUpdateBeneficiaryPressedToState(
    _SaveOrUpdateBeneficiaryPressed event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      state.copyWith(
        isSubmitting: true,
        showErrorMessages: true,
        saveBeneficiaryFailureOrSuccessOption: none(),
      ),
    );

    final hasError = state.dynamicFieldValues.values.any(
      (field) => field.value.isLeft(),
    );
    if (hasError) {
      emit(state.copyWith(isSubmitting: false));
      return;
    }

    final failureOrSuccess = await _beneficiaryFacade.requestBeneficiaryOtp(
      beneficiary: _buildBeneficiaryPayload(state),
    );

    failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(
          isSubmitting: false,
          saveBeneficiaryFailureOrSuccessOption: some(left(failure)),
        ),
      ),
      (data) {
        if (data == 200) {
          // OTP sent — navigate to OTP screen. Start the resend cooldown.
          emit(
            state.copyWith(
              isSubmitting: false,
              otpResendCooldownUntil: DateTime.now().add(
                const Duration(seconds: 60),
              ),
              saveBeneficiaryFailureOrSuccessOption: some(right(data)),
            ),
          );
          return;
        }

        // No OTP required — server already persisted the record. Emit success;
        // the list and the summary both refresh from the backend on navigation,
        // so no record is built or upserted locally here.
        emit(
          state.copyWith(
            isSubmitting: false,
            saveBeneficiaryFailureOrSuccessOption: some(right(data)),
          ),
        );
      },
    );
  }

  FutureOr<void> _onBeneficiaryOtpChangedToState(
    _BeneficiaryOtpChanged event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      state.copyWith(
        beneficiaryOtp: BeneficiaryOtp(event.otpStr),
        saveBeneficiaryFailureOrSuccessOption: none(),
      ),
    );
  }

  FutureOr<void> _onBeneficiaryOtpSubmittedToState(
    _BeneficiaryOtpSubmitted event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      state.copyWith(
        isOtpSubmitting: true,
        showOtpErrorMessages: true,
        saveBeneficiaryFailureOrSuccessOption: none(),
        beneficiaryOtpFailureOrSuccessOption: none(),
      ),
    );

    if (!state.beneficiaryOtp.isValid()) {
      emit(state.copyWith(isOtpSubmitting: false));
      return;
    }

    final failureOrSuccess = await _beneficiaryFacade.verifyBeneficiaryOtp(
      otp: state.beneficiaryOtp,
      beneficiary: _buildBeneficiaryPayload(state),
    );

    failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(
          isOtpSubmitting: false,
          beneficiaryOtpFailureOrSuccessOption: some(left(failure)),
        ),
      ),
      // eId is the server-assigned id returned after successful OTP
      // verification. The list and the summary refresh from the backend on
      // navigation, so no record is built or upserted locally here.
      (eId) => emit(
        state.copyWith(
          isOtpSubmitting: false,
          beneficiaryOtpFailureOrSuccessOption: some(right(eId)),
        ),
      ),
    );
  }

  FutureOr<void> _onResendBeneficiaryOtpToState(
    _ResendBeneficiaryOtp event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      state.copyWith(
        isResendingOtp: true,
        resendBeneficiaryOtpFailureOrSuccessOption: none(),
      ),
    );

    final failureOrSuccess = await _beneficiaryFacade.requestBeneficiaryOtp(
      beneficiary: _buildBeneficiaryPayload(state),
    );

    failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(
          isResendingOtp: false,
          resendBeneficiaryOtpFailureOrSuccessOption: some(left(failure)),
        ),
      ),
      (data) => emit(
        state.copyWith(
          isResendingOtp: false,
          // Reset the cooldown on every successful resend.
          otpResendCooldownUntil: DateTime.now().add(
            const Duration(seconds: 60),
          ),
          resendBeneficiaryOtpFailureOrSuccessOption: some(right(data)),
        ),
      ),
    );
  }

  BeneficiaryDynamicInput _makeFieldInput(
    BeneficiaryState s,
    String fieldName,
    String value,
  ) {
    final field = s
        .beneficiaryProductFieldSettingsDto
        ?.data
        ?.allProductFieldSettingList
        ?.beneficiary
        ?.where((f) => f.fieldName == fieldName)
        .firstOrNull;
    return BeneficiaryDynamicInput(
      input: value,
      mandatory: field?.mandatory ?? false,
      minLength: field?.minimumLength,
      maxLength: field?.maximumLength,
      regexPattern: field?.regexPattern,
    );
  }

  // The option the API flags as is_default, used to seed add-mode dropdowns
  // that carry no default_value.
  static String _defaultDropdownCode(Beneficiary field) {
    for (final item
        in field.dropdownItems ?? const <BeneficiaryDropdownItem>[]) {
      if (item.isDefault == true) return item.code ?? '';
    }
    return '';
  }

  // The dynamicFieldValues key whose backend field_name normalizes to [key],
  // or null when the product doesn't configure that field. Backend casing and
  // spacing for these names is inconsistent, so never match the raw constant.
  static String? _fieldNameFor(
    Map<String, BeneficiaryDynamicInput> fields,
    String key,
  ) => fields.keys
      .where((name) => BeneficiaryFieldKeys.normalize(name) == key)
      .firstOrNull;

  // Cascade fields, parent -> child. Clearing one invalidates everything after
  // it, the same reset beneficiaryBankComboChanged already performs.
  static const _cascadeFieldKeys = [
    BeneficiaryFieldKeys.bankCode,
    BeneficiaryFieldKeys.branchCode,
    BeneficiaryFieldKeys.routeCode,
  ];

  // Cascade dropdown options (bank / branch / route) are fetched long after the
  // field values are seeded, so — unlike inline-option dropdowns, validated at
  // seeding in _onGetBeneficiaryProductFieldsToState — their stored code can
  // only be checked once the list lands. Call this at each list-arrival point
  // with [loadedKey] naming the list that just arrived: a code that list
  // doesn't contain is cleared, rather than rendering as a bare unresolvable
  // code the picker can't highlight, and its dependents are cleared with it.
  //
  // Only [loadedKey]'s own list is consulted. comboLists is carried across
  // product changes, so a sibling's entry may belong to a previous product and
  // must never decide whether another field's value survives. An empty list is
  // also left alone — it means the options haven't loaded (or the backend
  // returned none), and clearing there would wipe a saved value with nothing
  // for the user to re-pick from.
  ({Map<String, BeneficiaryDynamicInput> fields, Set<String> lockedFields})
  _pruneUnmatchedComboValues(
    BeneficiaryState s,
    Map<String, List<ComboItem>> comboLists, {
    required String loadedKey,
  }) {
    final unchanged = (
      fields: s.dynamicFieldValues,
      lockedFields: s.lockedFields,
    );

    final startIndex = _cascadeFieldKeys.indexOf(loadedKey);
    if (startIndex < 0) return unchanged;

    final loadedField = _fieldNameFor(s.dynamicFieldValues, loadedKey);
    if (loadedField == null) return unchanged;

    final code = s.dynamicFieldValues[loadedField]!.value
        .getOrElse(() => '')
        .trim();
    if (code.isEmpty) return unchanged;

    final options = comboLists[loadedKey] ?? const <ComboItem>[];
    if (options.isEmpty || options.any((o) => o.code.trim() == code)) {
      return unchanged;
    }

    final fields = Map<String, BeneficiaryDynamicInput>.from(
      s.dynamicFieldValues,
    );
    final locked = Set<String>.from(s.lockedFields);

    for (final key in _cascadeFieldKeys.skip(startIndex)) {
      final fieldName = _fieldNameFor(fields, key);
      if (fieldName == null) continue;
      fields[fieldName] = _makeFieldInput(s, fieldName, '');
      // A read-only field must never be left locked and empty — the user could
      // never satisfy it (same rule as the seeding path).
      locked.remove(fieldName);
    }

    return (fields: fields, lockedFields: locked);
  }

  // A route code the backend can't resolve invalidates the bank and branch it
  // was supposed to identify, so clear both — along with the branch option list
  // and selectedBankComboCode, which belong to the old bank — rather than
  // leaving a pairing on screen that no longer follows from the route code the
  // user is looking at. The route code itself is kept: it's what they just
  // typed, and its own lookup error tells them it didn't resolve.
  ({
    Map<String, BeneficiaryDynamicInput> fields,
    Map<String, List<ComboItem>> comboLists,
    Set<String> lockedFields,
  })
  _clearBankAndBranch(BeneficiaryState s) {
    final fields = Map<String, BeneficiaryDynamicInput>.from(
      s.dynamicFieldValues,
    );
    final locked = Set<String>.from(s.lockedFields);

    for (final key in const [
      BeneficiaryFieldKeys.bankCode,
      BeneficiaryFieldKeys.branchCode,
    ]) {
      final fieldName = _fieldNameFor(fields, key);
      if (fieldName == null) continue;
      fields[fieldName] = _makeFieldInput(s, fieldName, '');
      locked.remove(fieldName);
    }

    return (
      fields: fields,
      comboLists: {
        ...s.comboLists,
        BeneficiaryFieldKeys.branchCode: const <ComboItem>[],
        // The route options were fetched for the old bank/branch, so they can't
        // be offered either. The typed route code itself stays visible — an
        // empty list is never treated as grounds to clear a stored value.
        BeneficiaryFieldKeys.routeCode: const <ComboItem>[],
      },
      lockedFields: locked,
    );
  }

  FutureOr<void> _onBeneficiaryBankComboChangedToState(
    _BeneficiaryBankComboChanged event,
    Emitter<BeneficiaryState> emit,
  ) async {
    final updated = Map<String, BeneficiaryDynamicInput>.from(
      state.dynamicFieldValues,
    );
    // Store the bank only when the product configures a beneficiaryBankCode
    // field — for BANK TRANSFER products without one, this event still runs
    // to drive the branch cascade, but the code must not leak into the
    // dynamic values (and from there into the save payload).
    if (updated.containsKey(_bankCodeField)) {
      updated[_bankCodeField] = _makeFieldInput(
        state,
        _bankCodeField,
        event.bankCode,
      );
    }
    // A field cleared by the cascade must not stay locked: read-only and empty
    // is a state the user could never satisfy.
    final locked = Set<String>.from(state.lockedFields);
    for (final fieldName in [_branchCodeField, _routeCodeField]) {
      if (updated.containsKey(fieldName)) {
        updated[fieldName] = _makeFieldInput(state, fieldName, '');
        locked.remove(fieldName);
      }
    }
    emit(
      state.copyWith(
        dynamicFieldValues: updated,
        lockedFields: locked,
        isRouteCodeAutoFilled: false,
        beneficiaryRouteCodeFailureOrSuccessOption: none(),
        beneficiaryBankBranchRouteFailureOrSuccessOption: none(),
        comboLists: {
          ...state.comboLists,
          BeneficiaryFieldKeys.branchCode: [],
          BeneficiaryFieldKeys.routeCode: [],
        },
      ),
    );
    // Branch combo is fetched only when the product actually configures a
    // beneficiaryBranchCode field; otherwise the cascade ends at the bank.
    if (updated.containsKey(_branchCodeField)) {
      add(
        BeneficiaryEvent.getBranchCombo(
          event.bankCode,
          bankName: event.bankName,
        ),
      );
    }
  }

  FutureOr<void> _onBeneficiaryBranchComboChangedToState(
    _BeneficiaryBranchComboChanged event,
    Emitter<BeneficiaryState> emit,
  ) async {
    final updated = Map<String, BeneficiaryDynamicInput>.from(
      state.dynamicFieldValues,
    );
    updated[_branchCodeField] = _makeFieldInput(
      state,
      _branchCodeField,
      event.branchCode,
    );
    // Route code is only fetched/shown when the product actually configures a
    // routeCode field. Otherwise selecting a branch must not trigger the lookup.
    final hasRouteCodeField = updated.containsKey(_routeCodeField);
    final locked = Set<String>.from(state.lockedFields);
    if (hasRouteCodeField) {
      updated[_routeCodeField] = _makeFieldInput(state, _routeCodeField, '');
      // Cleared fields must not stay read-only — see the bank cascade above.
      locked.remove(_routeCodeField);
    }
    emit(
      state.copyWith(
        dynamicFieldValues: updated,
        lockedFields: locked,
        isRouteCodeLoading: hasRouteCodeField,
        isRouteCodeAutoFilled: false,
        beneficiaryRouteCodeFailureOrSuccessOption: none(),
      ),
    );

    // selectedBankComboCode is set by _onGetBranchComboToState, which runs for
    // both the add path (via beneficiaryBankComboChanged) and the edit path
    // (via getBranchCombo called from _onGetSourceOfFundsToState).
    final bankCode = state.selectedBankComboCode;
    if (!hasRouteCodeField || bankCode.isEmpty || event.branchCode.isEmpty) {
      emit(state.copyWith(isRouteCodeLoading: false));
      return;
    }

    final result = await _beneficiaryFacade.getBeneficiaryRouteCode(
      productCode: state.selectedBeneficiaryBankOrAgent?.titleCode ?? '',
      beneficiaryBankCode: bankCode,
      beneficiaryBankBranchCode: event.branchCode,
      transferTypeModeCode:
          state.selectedBeneficiaryTransferType?.titleCode ?? '',
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isRouteCodeLoading: false,
          beneficiaryRouteCodeFailureOrSuccessOption: some(left(failure)),
        ),
      ),
      (dto) {
        final list = dto.data?.beneficiaryRouteCodeList ?? [];
        final routeCode =
            list
                .firstWhere(
                  (e) => e.isDefault == true,
                  orElse: () => list.isNotEmpty
                      ? list.first
                      : const BeneficiaryRouteCodeList(),
                )
                .code ??
            '';
        final newFields = Map<String, BeneficiaryDynamicInput>.from(
          state.dynamicFieldValues,
        );
        if (newFields.containsKey(_routeCodeField)) {
          newFields[_routeCodeField] = _makeFieldInput(
            state,
            _routeCodeField,
            routeCode,
          );
        }
        emit(
          state.copyWith(
            dynamicFieldValues: newFields,
            isRouteCodeLoading: false,
            isRouteCodeAutoFilled: routeCode.isNotEmpty,
            beneficiaryRouteCodeDto: dto,
            comboLists: {
              ...state.comboLists,
              BeneficiaryFieldKeys.routeCode: list
                  .map((e) => ComboItem(code: e.code ?? '', name: e.code ?? ''))
                  .toList(),
            },
            beneficiaryRouteCodeFailureOrSuccessOption: some(right(dto)),
          ),
        );
      },
    );
  }

  // Shared logic for both text-input (debounced) and dropdown-selection (immediate)
  // IFSC/route-code paths. Validates the returned bank against the loaded bank list
  // before storing — prevents invisible stored values that don't match any dropdown item.
  // Branch code is intentionally NOT stored here; it is validated against the freshly
  // loaded branch list inside _onGetBranchComboToState via expectedBranchCode.
  FutureOr<void> _handleRouteCodeLookup(
    String routeCode,
    Emitter<BeneficiaryState> emit,
  ) async {
    final updated = Map<String, BeneficiaryDynamicInput>.from(
      state.dynamicFieldValues,
    );
    if (updated.containsKey(_routeCodeField)) {
      updated[_routeCodeField] = _makeFieldInput(
        state,
        _routeCodeField,
        routeCode,
      );
    }
    emit(
      state.copyWith(
        dynamicFieldValues: updated,
        isRouteCodeAutoFilled: false,
        isRouteLookupLoading: routeCode.isNotEmpty,
        beneficiaryBankBranchRouteFailureOrSuccessOption: none(),
      ),
    );

    if (routeCode.isEmpty) return;

    final result = await _beneficiaryFacade.getBeneficiaryBankBranchFromRoute(
      beneficiaryRouteCode: routeCode,
      productCode: state.selectedBeneficiaryBankOrAgent?.titleCode ?? '',
    );

    result.fold(
      (failure) {
        // Lookup failed: the bank/branch on screen were resolved from a
        // different route code and are now unverified, so drop them.
        final cleared = _clearBankAndBranch(state);
        emit(
          state.copyWith(
            isRouteLookupLoading: false,
            dynamicFieldValues: cleared.fields,
            lockedFields: cleared.lockedFields,
            comboLists: cleared.comboLists,
            selectedBankComboCode: '',
            beneficiaryBankBranchRouteFailureOrSuccessOption: some(
              left(failure),
            ),
          ),
        );
      },
      (dto) {
        final bankCode = dto.data?.beneficiaryBankDetails?.code ?? '';
        final bankName = dto.data?.beneficiaryBankDetails?.name ?? '';
        final branchCode = dto.data?.beneficiaryBranchDetails?.code ?? '';

        // Resolved, but the response names no bank — the route code identifies
        // nothing, so treat it exactly like a failed lookup.
        if (bankCode.isEmpty) {
          final cleared = _clearBankAndBranch(state);
          emit(
            state.copyWith(
              isRouteLookupLoading: false,
              dynamicFieldValues: cleared.fields,
              lockedFields: cleared.lockedFields,
              comboLists: cleared.comboLists,
              selectedBankComboCode: '',
              beneficiaryBankBranchRouteDto: dto,
              beneficiaryBankBranchRouteFailureOrSuccessOption: some(right(dto)),
            ),
          );
          return;
        }

        // The looked-up bank must be renderable in the bank dropdown so it can
        // be stored and shown. For BANK TRANSFER the list holds only the
        // synthesized agent entry; for other transfer types the full bank list
        // is loaded and the bank is usually present. Merge the looked-up bank
        // in when missing so route → bank/branch auto-fill works regardless of
        // transfer type.
        final bankList = state.comboLists[BeneficiaryFieldKeys.bankCode] ?? [];
        final bankInList = bankList.any((b) => b.code == bankCode);
        final mergedBankList = bankInList
            ? bankList
            : [...bankList, ComboItem(code: bankCode, name: bankName)];

        final newFields = Map<String, BeneficiaryDynamicInput>.from(
          state.dynamicFieldValues,
        );
        final locked = Set<String>.from(state.lockedFields);

        final bankField = _fieldNameFor(newFields, BeneficiaryFieldKeys.bankCode);
        final previousBankCode = bankField == null
            ? ''
            : newFields[bankField]!.value.getOrElse(() => '').trim();
        if (bankField != null) {
          newFields[bankField] = _makeFieldInput(state, bankField, bankCode);
        }

        // The stored branch was resolved for the previous bank, so it must not
        // survive into a different one; likewise when this route code names no
        // branch at all. Otherwise it is left alone and the expectedBranchCode
        // path below re-validates it against the freshly loaded list.
        final branchField = _fieldNameFor(
          newFields,
          BeneficiaryFieldKeys.branchCode,
        );
        if (branchField != null &&
            (branchCode.isEmpty || previousBankCode != bankCode)) {
          newFields[branchField] = _makeFieldInput(state, branchField, '');
          locked.remove(branchField);
        }

        emit(
          state.copyWith(
            dynamicFieldValues: newFields,
            lockedFields: locked,
            isRouteLookupLoading: false,
            beneficiaryBankBranchRouteDto: dto,
            comboLists: {
              ...state.comboLists,
              BeneficiaryFieldKeys.bankCode: mergedBankList,
            },
            beneficiaryBankBranchRouteFailureOrSuccessOption: some(right(dto)),
          ),
        );

        // Re-populate the branch dropdown for the auto-filled bank and pass the
        // expected branch code for post-load validation.
        // Circular-safe: getBranchCombo never fires beneficiaryBranchComboChanged,
        // so it cannot loop back into this lookup. In edit mode it additionally
        // refreshes the route option list for the resolved bank/branch, which
        // only replaces that list — never the route code the user typed.
        add(
          BeneficiaryEvent.getBranchCombo(
            bankCode,
            bankName: bankName,
            expectedBranchCode: branchCode,
          ),
        );
      },
    );
  }

  FutureOr<void> _onLoadFormSupportDataToState(
    _LoadFormSupportData event,
    Emitter<BeneficiaryState> emit,
  ) async {
    // Snapshot selectors before await so they stay consistent.
    final countryCode = state.selectedBeneficiaryCountry?.titleCode ?? '';
    final currencyCode = state.selectedBeneficiaryCurrency?.trailingCode ?? '';
    final productCode = state.selectedBeneficiaryBankOrAgent?.titleCode ?? '';
    final transferCode = state.selectedBeneficiaryTransferType?.titleCode ?? '';
    final isEditing = state.isEditing;
    final beneficiary = state.beneficiaryByIdDto?.data?.beneficiaryById;

    // The bank/branch dynamic fields load their combo lists only when the
    // product's field settings actually configure them.
    final hasBankField = state.dynamicFieldValues.containsKey(_bankCodeField);
    final hasBranchField = state.dynamicFieldValues.containsKey(
      _branchCodeField,
    );

    final (purposeResult, sourceResult) = await (
      _beneficiaryFacade.getBeneficiaryPurposeOfTransferList(
        productCode: productCode,
        beneficiaryCountryCode: countryCode,
      ),
      _beneficiaryFacade.getBeneficiarySourceFundList(productCode: productCode),
    ).wait;

    final bankResult = hasBankField
        ? await _beneficiaryFacade.getBeneficiaryBankComboList(
            beneficiaryCountryCode: countryCode,
            beneficiaryCurrencyCode: currencyCode,
            productCode: productCode,
            transferTypeModeCode: transferCode,
          )
        : null;

    // Stale-response guard: bail if the corridor/bank-agent selection moved on
    // while this support data was in flight (same race as the cascade fetches
    // above), so it can't overwrite the current product's form.
    if ((state.selectedBeneficiaryCountry?.titleCode ?? '') != countryCode ||
        (state.selectedBeneficiaryTransferType?.titleCode ?? '') !=
            transferCode ||
        (state.selectedBeneficiaryBankOrAgent?.titleCode ?? '') !=
            productCode) {
      return;
    }

    // The static per-field dropdown options already arrived inline with the
    // product field settings; only the bank list is layered in here.
    final comboLists = Map<String, List<ComboItem>>.from(state.comboLists);

    bankResult?.fold((_) {}, (bankData) {
      comboLists[BeneficiaryFieldKeys.bankCode] =
          (bankData.data?.beneficiaryBankList ?? [])
              .map((e) => ComboItem(code: e.code ?? '', name: e.name ?? ''))
              .toList();
    });

    // The bank list has landed: drop a stored bank code it doesn't contain,
    // along with the branch / route values that depend on it. Runs before the
    // edit-mode block below, which reads the bank back out of state to drive
    // the branch cascade — an unmatched bank must not start that cascade.
    final pruned = _pruneUnmatchedComboValues(
      state,
      comboLists,
      loadedKey: BeneficiaryFieldKeys.bankCode,
    );

    emit(
      state.copyWith(
        isLoading: false,
        comboLists: comboLists,
        dynamicFieldValues: pruned.fields,
        lockedFields: pruned.lockedFields,
        beneficiaryBankComboListFailureOrSuccessOption: bankResult != null
            ? some(bankResult)
            : state.beneficiaryBankComboListFailureOrSuccessOption,
        beneficiaryPurposeOfTransferDto: purposeResult.fold(
          (_) => state.beneficiaryPurposeOfTransferDto,
          (d) => d,
        ),
        beneficiaryPurposeOfTransactionFailureOrSuccessOption: some(
          purposeResult,
        ),
        beneficiarySourceOfFundDto: sourceResult.fold(
          (_) => state.beneficiarySourceOfFundDto,
          (d) => d,
        ),
        beneficiarySourceOfFundFailureOrSuccessOption: some(sourceResult),
      ),
    );

    if (isEditing) {
      final purposeName = beneficiary?.purposeName;
      final purposeCode = beneficiary?.purposeOfTransaction;
      final sourceName = beneficiary?.incomeSourceName;
      final sourceCode = beneficiary?.sourceOfFund;

      // The bank lives in the saved beneficiaryBankCode dynamic field (backend
      // prefills it via default_value), with the name resolved from the bank
      // combo list loaded above.
      final bankCode = state.dynamicFieldValues[_bankCodeField]?.value
          .getOrElse(() => '');
      final bankName = (comboLists[BeneficiaryFieldKeys.bankCode] ?? [])
          .where((b) => b.code == bankCode)
          .firstOrNull
          ?.name;

      // Purpose / source follow the same rule as the dynamic dropdowns: the
      // saved code survives only when the freshly loaded option list contains
      // it, and the label comes from that list so a stale saved name can't be
      // shown. getBeneficiaryById already seeded these before the lists
      // arrived, so an unmatched code is actively cleared, not just skipped.
      // An empty list means the request failed — keep the saved value rather
      // than emptying a field the user has nothing to re-pick from.
      final purposeList =
          state.beneficiaryPurposeOfTransferDto?.data?.purposeList ?? [];
      final matchedPurpose = purposeList
          .where((p) => (p.code ?? '').trim() == (purposeCode ?? '').trim())
          .firstOrNull;
      if ((purposeCode ?? '').isEmpty ||
          (purposeList.isNotEmpty && matchedPurpose == null)) {
        emit(state.copyWith(selectedBeneficiaryPurposeOfTransaction: null));
      } else {
        add(
          BeneficiaryEvent.beneficiaryPurposeOfTransactionSelected(
            CommonSelectableItem(
              titleName: matchedPurpose?.name ?? purposeName,
              titleCode: purposeCode,
            ),
          ),
        );
      }

      final sourceList =
          state.beneficiarySourceOfFundDto?.data?.incomeSourceList ?? [];
      final matchedSource = sourceList
          .where((s) => (s.code ?? '').trim() == (sourceCode ?? '').trim())
          .firstOrNull;
      if ((sourceCode ?? '').isEmpty ||
          (sourceList.isNotEmpty && matchedSource == null)) {
        emit(state.copyWith(selectedBeneficiarySourceOfFund: null));
      } else {
        add(
          BeneficiaryEvent.beneficiarySourceOfFundSelected(
            CommonSelectableItem(
              titleName: matchedSource?.name ?? sourceName,
              titleCode: sourceCode,
            ),
          ),
        );
      }
      if (hasBranchField && (bankCode ?? '').isNotEmpty) {
        add(BeneficiaryEvent.getBranchCombo(bankCode, bankName: bankName));
      } else {
        emit(state.copyWith(isInitialLoading: false));
      }
    } else {
      // Add mode: pre-select the purpose / source-of-fund option the backend
      // flags is_default, so the form opens on the intended choice.
      final defaultPurpose =
          (state.beneficiaryPurposeOfTransferDto?.data?.purposeList ?? [])
              .where((p) => p.isDefault == true)
              .firstOrNull;
      if (defaultPurpose != null && (defaultPurpose.code ?? '').isNotEmpty) {
        add(
          BeneficiaryEvent.beneficiaryPurposeOfTransactionSelected(
            CommonSelectableItem(
              titleName: defaultPurpose.name,
              titleCode: defaultPurpose.code,
            ),
          ),
        );
      }
      final defaultSource =
          (state.beneficiarySourceOfFundDto?.data?.incomeSourceList ?? [])
              .where((s) => s.isDefault == true)
              .firstOrNull;
      if (defaultSource != null && (defaultSource.code ?? '').isNotEmpty) {
        add(
          BeneficiaryEvent.beneficiarySourceOfFundSelected(
            CommonSelectableItem(
              titleName: defaultSource.name,
              titleCode: defaultSource.code,
            ),
          ),
        );
      }

      // Single-bank auto-selection consistent with other single-item dropdowns.
      bankResult?.fold((_) {}, (bankData) {
        final bankList = bankData.data?.beneficiaryBankList ?? [];
        if (bankList.length == 1) {
          add(
            BeneficiaryEvent.beneficiaryBankComboChanged(
              bankCode: bankList.first.code ?? '',
              bankName: bankList.first.name ?? '',
            ),
          );
        }
      });
      emit(state.copyWith(isInitialLoading: false));
    }
  }

  FutureOr<void> _onDeleteBeneficiaryToState(
    _DeleteBeneficiary event,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      state.copyWith(
        isDeleting: true,
        deleteBeneficiaryFailureOrSuccessOption: none(),
      ),
    );

    final failureOrSuccess = await _beneficiaryFacade.deleteBeneficiary(
      beneficiaryId: event.beneficiaryId,
    );

    failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(
          isDeleting: false,
          deleteBeneficiaryFailureOrSuccessOption: some(left(failure)),
        ),
      ),
      (_) {
        final updatedList =
            (state.beneficiaryListDto?.data?.beneficiaryList ?? [])
                .where((b) => b.eId != event.beneficiaryId)
                .toList();
        emit(
          state.copyWith(
            isDeleting: false,
            beneficiaryListDto: state.beneficiaryListDto?.copyWith(
              data: state.beneficiaryListDto?.data?.copyWith(
                beneficiaryList: updatedList,
              ),
            ),
            deleteBeneficiaryFailureOrSuccessOption: some(right(unit)),
          ),
        );
      },
    );
  }

  // ── Payment (action-sheet) flow ────────────────────────────────────────────
  // Mirrors the home send-again flow but self-contained in this feature:
  // resolve the corridor agent, then run the mandatory-field check, then let the
  // page navigate to the summary carrying the resolved agent.
  FutureOr<void> _onPaymentRequested(
    _PaymentRequested event,
    Emitter<BeneficiaryState> emit,
  ) async {
    final beneficiary = event.beneficiary;
    emit(
      state.copyWith(
        isPaymentLoading: true,
        paymentBeneficiary: beneficiary,
        // Fresh slate for both one-shots and the resolved agent per tap.
        paymentAgentItem: null,
        paymentAgentOption: none(),
        paymentMandatoryCheckOption: none(),
      ),
    );
    final agentResult = await _beneficiaryFacade.getBeneficiaryAgentList(
      destinationCountryCode: beneficiary.beneficiaryCountryCode ?? '',
      destinationCurrencyCode: beneficiary.currencyCode ?? '',
      transferTypeCode: beneficiary.disbursalMode ?? '',
    );
    await agentResult.fold(
      (failure) async {
        // Agent fetch failed (non-406): surface a dialog and stop.
        emit(
          state.copyWith(
            isPaymentLoading: false,
            paymentAgentOption: some(left(failure)),
          ),
        );
        emit(state.copyWith(paymentAgentOption: none()));
      },
      (dto) async {
        final list = dto.data?.agentList ?? [];
        // Empty ⇒ 406 "agent not required" (or none): skip the agent step.
        if (list.isEmpty) {
          await _runPaymentMandatoryCheck(beneficiary, null, emit);
          return;
        }
        // Single option ⇒ auto-select as the default.
        if (list.length == 1) {
          final only = list.first;
          await _runPaymentMandatoryCheck(
            beneficiary,
            CommonSelectableItem(
              titleName: (only.name ?? '').toUpperCase(),
              titleCode: only.code ?? '',
            ),
            emit,
          );
          return;
        }
        // Multiple ⇒ hand the list to the UI for a picker dialog; the user's
        // pick re-enters via paymentAgentSelected.
        final agentDto = CommonSelectableDto(
          data: CommonSelectableData(
            list: list
                .map(
                  (e) => CommonSelectableItem(
                    titleName: (e.name ?? '').toUpperCase(),
                    titleCode: e.code ?? '',
                  ),
                )
                .toList(),
          ),
        );
        emit(
          state.copyWith(
            isPaymentLoading: false,
            paymentAgentOption: some(right(agentDto)),
          ),
        );
        emit(state.copyWith(paymentAgentOption: none()));
      },
    );
  }

  FutureOr<void> _onPaymentAgentSelected(
    _PaymentAgentSelected event,
    Emitter<BeneficiaryState> emit,
  ) async {
    final beneficiary = state.paymentBeneficiary;
    // The picker only opens after a tap, so a beneficiary is always present;
    // guard rather than run the check blind.
    if (beneficiary == null) return;
    await _runPaymentMandatoryCheck(beneficiary, event.agent, emit);
  }

  /// Shared tail: run the mandatory-field check with the resolved [agent] (null ⇒
  /// no agent), stashing it so the page's summary navigation can carry it.
  Future<void> _runPaymentMandatoryCheck(
    BeneficiaryList beneficiary,
    CommonSelectableItem? agent,
    Emitter<BeneficiaryState> emit,
  ) async {
    emit(
      state.copyWith(
        isPaymentLoading: true,
        paymentAgentItem: agent,
        paymentMandatoryCheckOption: none(),
      ),
    );
    final failureOrSuccess = await _beneficiaryFacade
        .checkBeneficiaryMandatoryFields(
          beneficiaryId: beneficiary.eId ?? '',
          destinationCountryCode: beneficiary.beneficiaryCountryCode ?? '',
          disbursalModeName: beneficiary.disbursalMode ?? '',
          destinationCurrencyCode: beneficiary.currencyCode ?? '',
        );
    emit(
      state.copyWith(
        isPaymentLoading: false,
        paymentMandatoryCheckOption: some(failureOrSuccess),
      ),
    );
    // One-shot: reset immediately so unrelated listener runs don't replay it.
    emit(state.copyWith(paymentMandatoryCheckOption: none()));
  }

  Map<String, dynamic>? _buildBeneficiaryPayload(BeneficiaryState s) {
    // The selected bank/agent item is the product identity only (product_code
    // below). The beneficiary_bank_* / beneficiary_agent_* name+code fields are
    // driven by the product's dynamic field settings and are serialized from
    // dynamicFieldValues in the spread below.
    //
    // When the product field settings include a mobile-number field, the
    // payload also carries the dial code of the beneficiary's country — the
    // same code the field shows as its prefix in the form.
    final hasMobileField = s.dynamicFieldValues.keys.any(
      (key) =>
          BeneficiaryFieldKeys.normalize(key) == BeneficiaryFieldKeys.mobile,
    );
    final mobileDialCode = hasMobileField
        ? int.tryParse(
            CountryUtils.getCountryByCode(
                  s.selectedBeneficiaryCountry?.titleCode ?? '',
                )?.dialCode.replaceAll('+', '') ??
                '',
          )
        : null;
    final fields = <String, dynamic>{
      for (final entry in s.dynamicFieldValues.entries)
        camelToSnake(entry.key): entry.value.value.getOrElse(() => ''),
      'beneficiary_mobile_code': ?mobileDialCode,
      if (s.isEditing)
        'e_id': s.beneficiaryByIdDto?.data?.beneficiaryById?.eId ?? '',
      'beneficiary_country_code': s.selectedBeneficiaryCountry?.titleCode ?? '',
      'currency_code': s.selectedBeneficiaryCurrency?.trailingCode ?? '',
      'disbursal_mode_code': s.selectedBeneficiaryTransferType?.titleCode ?? '',
      'product_code': s.selectedBeneficiaryBankOrAgent?.titleCode ?? '',
      'purpose_code':
          s.selectedBeneficiaryPurposeOfTransaction?.titleCode ?? '',
      'income_source_code': s.selectedBeneficiarySourceOfFund?.titleCode ?? '',
    };
    return _encodeDynamicFields(fields);
  }

  String camelToSnake(String input) {
    return input.replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    );
  }

  Map<String, dynamic>? _encodeDynamicFields(Map<String, dynamic>? fields) {
    if (fields == null) return null;

    return fields.map((key, value) {
      final raw = value is BeneficiaryDynamicInput
          ? value.value.getOrElse(() => '')
          : value;

      if (key == 'product_code') {
        return MapEntry(key, int.tryParse(raw.toString()) ?? raw);
      }

      return MapEntry(key, raw);
    });
  }

  EventTransformer<T> _debounce<T>(Duration duration) =>
      (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}
