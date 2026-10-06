import 'package:dartz/dartz.dart';
import '../home/home_agent_list_dto.dart';
import '../home/home_mandatory_field_check_dto.dart';
import 'beneficiary_bank_branch_combo_list_dto.dart';
import 'beneficiary_bank_branch_route_dto.dart';
import 'beneficiary_bank_combo_list_dto.dart';
import 'beneficiary_bank_or_agent_list_dto.dart';
import 'beneficiary_by_id_dto.dart';
import 'beneficiary_country_list_dto.dart';
import 'beneficiary_currency_list_dto.dart';
import 'beneficiary_failure.dart';
import 'beneficiary_list_dto.dart';
import 'beneficiary_product_field_settings_dto.dart';
import 'beneficiary_purpose_of_transfer_dto.dart';
import 'beneficiary_route_code_dto.dart';
import 'beneficiary_source_of_fund_dto.dart';
import 'beneficiary_transfer_mode_list_dto.dart';
import 'value_validators.dart';

abstract class IBeneficiaryFacade {
  Future<Either<BeneficiaryFailure, BeneficiaryListDto>> getBeneficiaryList({
    String? transferTypeModeCode,
    String? destinationCountryCode,
  });
  Future<Either<BeneficiaryFailure, BeneficiaryByIdDto>> getBeneficiaryById({
    required String beneficiaryId,
  });
  Future<Either<BeneficiaryFailure, BeneficiaryCountryListDto>>
  getBeneficiaryCountryList();
  Future<Either<BeneficiaryFailure, BeneficiaryCurrencyListDto>>
  getBeneficiaryCurrencyListByCountry({required String beneficiaryCountryCode});
  Future<Either<BeneficiaryFailure, BeneficiaryTransferModeListDto>>
  getBeneficiaryTransferModeList({
    required String beneficiaryCountryCode,
    required String beneficiaryCurrencyCode,
  });
  Future<Either<BeneficiaryFailure, BeneficiaryBankOrAgentListDto>>
  getBeneficiaryBankOrAgentList({
    required String beneficiaryCountryCode,
    required String beneficiaryCurrencyCode,
    required String beneficiaryTransferTypeCode,
  });
  Future<Either<BeneficiaryFailure, BeneficiaryProductFieldSettingsDto>>
  getBeneficiaryProductFieldSettings({
    required String beneficiaryCountryCode,
    required String beneficiaryCurrencyCode,
    required String beneficiaryTransferTypeCode,
    required String productCode,
    String? eId,
  });

  Future<Either<BeneficiaryFailure, BeneficiarySourceOfFundDto>>
  getBeneficiarySourceFundList({required String productCode});
  Future<Either<BeneficiaryFailure, BeneficiaryPurposeOfTransferDto>>
  getBeneficiaryPurposeOfTransferList({
    required String productCode,
    required String beneficiaryCountryCode,
  });
  Future<Either<BeneficiaryFailure, BeneficiaryBankComboListDto>>
  getBeneficiaryBankComboList({
    required String beneficiaryCountryCode,
    required String beneficiaryCurrencyCode,
    required String productCode,
    required String transferTypeModeCode,
  });
  Future<Either<BeneficiaryFailure, BeneficiaryBankBranchComboListDto>>
  getBeneficiaryBankBranchList({
    required String productCode,
    required String beneficiaryBankName,
    required String beneficiaryBankCode,
    required String beneficiaryCountryCode,
    required String beneficiaryCurrencyCode,
    required String transferTypeModeCode,
  });
  Future<Either<BeneficiaryFailure, BeneficiaryRouteCodeDto>>
  getBeneficiaryRouteCode({
    required String productCode,
    required String beneficiaryBankCode,
    required String beneficiaryBankBranchCode,
    required String transferTypeModeCode,
  });
  Future<Either<BeneficiaryFailure, int>> requestBeneficiaryOtp({
    required Map<String, dynamic>? beneficiary,
  });
  Future<Either<BeneficiaryFailure, String>> verifyBeneficiaryOtp({
    required BeneficiaryOtp otp,
    required Map<String, dynamic>? beneficiary,
  });
  Future<Either<BeneficiaryFailure, Unit>> deleteBeneficiary({
    required String beneficiaryId,
  });
  Future<Either<BeneficiaryFailure, BeneficiaryBankBranchRouteDto>>
  getBeneficiaryBankBranchFromRoute({
    required String beneficiaryRouteCode,
    required String productCode,
  });

  // ── Payment (action-sheet) flow ──────────────────────────────────────────
  // Resolve the corridor's payout agent, then verify the beneficiary still
  // satisfies the corridor/product's mandatory fields — mirrors the home
  // send-again flow but owned by the beneficiary feature.
  Future<Either<BeneficiaryFailure, HomeAgentListDto>> getBeneficiaryAgentList({
    required String destinationCountryCode,
    required String destinationCurrencyCode,
    required String transferTypeCode,
  });
  Future<Either<BeneficiaryFailure, HomeMandatoryFieldCheckDto>>
  checkBeneficiaryMandatoryFields({
    required String beneficiaryId,
    required String destinationCountryCode,
    required String disbursalModeName,
    required String destinationCurrencyCode,
  });
}
