import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../domain/beneficiary/beneficiary_bank_branch_combo_list_dto.dart';
import '../../domain/beneficiary/beneficiary_bank_branch_route_dto.dart';
import '../../domain/beneficiary/beneficiary_bank_combo_list_dto.dart';
import '../../domain/beneficiary/beneficiary_bank_or_agent_list_dto.dart';
import '../../domain/beneficiary/beneficiary_by_id_dto.dart';
import '../../domain/beneficiary/beneficiary_country_list_dto.dart';
import '../../domain/beneficiary/beneficiary_currency_list_dto.dart';
import '../../domain/beneficiary/beneficiary_failure.dart';
import '../../domain/beneficiary/beneficiary_list_dto.dart';
import '../../domain/beneficiary/beneficiary_product_field_settings_dto.dart';
import '../../domain/beneficiary/beneficiary_purpose_of_transfer_dto.dart';
import '../../domain/beneficiary/beneficiary_route_code_dto.dart';
import '../../domain/beneficiary/beneficiary_source_of_fund_dto.dart';
import '../../domain/beneficiary/beneficiary_transfer_mode_list_dto.dart';
import '../../domain/beneficiary/i_beneficiary_facade.dart';
import '../../domain/beneficiary/value_validators.dart';
import '../../domain/home/home_agent_list_dto.dart';
import '../../domain/home/home_mandatory_field_check_dto.dart';
import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/core/services/api_services.dart';
import '../../presentation/core/global/app_global.dart';
import '../../presentation/routes/app_routes.dart';

@LazySingleton(as: IBeneficiaryFacade)
class BeneficiaryRepository implements IBeneficiaryFacade {
  final ApiServices _apiServices;
  final SharedPrefs _sharedPrefs;
  final AppRouter _appRouter;

  BeneficiaryRepository(this._apiServices, this._sharedPrefs, this._appRouter);

  @override
  Future<Either<BeneficiaryFailure, BeneficiaryListDto>> getBeneficiaryList({
    String? transferTypeModeCode,
    String? destinationCountryCode,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final queryParams = {
        'transfer_mode_code': transferTypeModeCode,
        'country_code': destinationCountryCode,
      };
      final response = await _apiServices.getBeneficiaries(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final beneficiaryListDto = BeneficiaryListDto.fromJson(response.body);
        return right(beneficiaryListDto);
      } else {
        return left(const BeneficiaryFailure.unableToGetBeneficiaryList());
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, BeneficiaryByIdDto>> getBeneficiaryById({
    required String beneficiaryId,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final response = await _apiServices.getBeneficiaryById(
        token: token,
        beneficiaryId: beneficiaryId,
      );
      if (response.isSuccessful) {
        final beneficiaryByIdDto = BeneficiaryByIdDto.fromJson(response.body);
        return right(beneficiaryByIdDto);
      } else {
        return left(const BeneficiaryFailure.unableToGetBeneficiaryById());
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, BeneficiaryCountryListDto>>
  getBeneficiaryCountryList() async {
    try {
      final response = await _apiServices.getCountries();
      if (response.isSuccessful) {
        final beneficiaryCountryListDto = BeneficiaryCountryListDto.fromJson(
          response.body,
        );
        return right(beneficiaryCountryListDto);
      } else {
        return left(
          const BeneficiaryFailure.unableToGetBeneficiaryCountryList(),
        );
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, BeneficiaryCurrencyListDto>>
  getBeneficiaryCurrencyListByCountry({
    required String beneficiaryCountryCode,
  }) async {
    final queryParams = {
      'is_base': false,
      'country_code': beneficiaryCountryCode,
    };
    try {
      final response = await _apiServices.getCurrencies(
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final beneficiaryCurrencyListDto = BeneficiaryCurrencyListDto.fromJson(
          response.body,
        );
        return right(beneficiaryCurrencyListDto);
      } else {
        return left(
          const BeneficiaryFailure.unableToGetBeneficiaryCurrencyListByCountry(),
        );
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, BeneficiaryTransferModeListDto>>
  getBeneficiaryTransferModeList({
    required String beneficiaryCountryCode,
    required String beneficiaryCurrencyCode,
  }) async {
    try {
      final queryParams = {
        'country_code': beneficiaryCountryCode,
        'currency_code': beneficiaryCurrencyCode,
      };
      final response = await _apiServices.getTransferTypes(
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final beneficiaryTransferModeListDto =
            BeneficiaryTransferModeListDto.fromJson(response.body);
        return right(beneficiaryTransferModeListDto);
      } else {
        return left(
          const BeneficiaryFailure.unableToGetBeneficiaryTransferModeList(),
        );
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, BeneficiaryBankOrAgentListDto>>
  getBeneficiaryBankOrAgentList({
    required String beneficiaryCountryCode,
    required String beneficiaryCurrencyCode,
    required String beneficiaryTransferTypeCode,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final queryParams = {
        'country_code': beneficiaryCountryCode,
        'currency_code': beneficiaryCurrencyCode,
        'disbursal_mode': beneficiaryTransferTypeCode,
      };
      final response = await _apiServices.getBankOrAgents(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final beneficiaryBankOrAgentListDto =
            BeneficiaryBankOrAgentListDto.fromJson(response.body);
        return right(beneficiaryBankOrAgentListDto);
      } else {
        return left(
          const BeneficiaryFailure.unableToGetBeneficiaryBankOrAgentList(),
        );
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, BeneficiaryProductFieldSettingsDto>>
  getBeneficiaryProductFieldSettings({
    required String beneficiaryCountryCode,
    required String beneficiaryCurrencyCode,
    required String beneficiaryTransferTypeCode,
    required String productCode,
    String? eId,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final locale =
          _appRouter.navigatorKey.currentContext?.locale.languageCode;
      final language = locale == 'ar' ? 'ar' : 'en';
      final queryParams = {
        'country_code': beneficiaryCountryCode,
        'destination_currency_code': beneficiaryCurrencyCode,
        'member_section': 'Beneficiary',
        'disbursal_mode_code': beneficiaryTransferTypeCode,
        'product_code': productCode,
        'language': language,
        // Edit mode: the eId lets the backend return the beneficiary's saved
        // values in each field's default_value for prefill.
        if (eId != null && eId.isNotEmpty) 'eId': eId,
      };
      final response = await _apiServices.getProductFieldSettings(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final beneficiaryProductFieldSettingsDto =
            BeneficiaryProductFieldSettingsDto.fromJson(response.body);
        return right(beneficiaryProductFieldSettingsDto);
      } else {
        return left(
          const BeneficiaryFailure.unableToGetBeneficiaryProductFieldSettings(),
        );
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, BeneficiarySourceOfFundDto>>
  getBeneficiarySourceFundList({required String productCode}) async {
    try {
      final token = _sharedPrefs.getToken();
      final queryParams = {'productCode': productCode};
      final response = await _apiServices.getSourceOfFund(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final beneficiarySourceFundDto = BeneficiarySourceOfFundDto.fromJson(
          response.body,
        );
        return right(beneficiarySourceFundDto);
      } else {
        return left(
          const BeneficiaryFailure.unableToGetBeneficiarySourceFundList(),
        );
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, BeneficiaryPurposeOfTransferDto>>
  getBeneficiaryPurposeOfTransferList({
    required String productCode,
    required String beneficiaryCountryCode,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final queryParams = {
        'productCode': productCode,
        'country_code': beneficiaryCountryCode,
      };
      final response = await _apiServices.getPurposeOfTransfer(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final beneficiaryPurposeOfTransferDto =
            BeneficiaryPurposeOfTransferDto.fromJson(response.body);
        return right(beneficiaryPurposeOfTransferDto);
      } else {
        return left(
          const BeneficiaryFailure.unableToGetBeneficiaryPurposeOfTransferList(),
        );
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, BeneficiaryBankComboListDto>>
  getBeneficiaryBankComboList({
    required String beneficiaryCountryCode,
    required String beneficiaryCurrencyCode,
    required String productCode,
    required String transferTypeModeCode,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final queryParams = {
        'country_code': beneficiaryCountryCode,
        'currency_code': beneficiaryCurrencyCode,
        'product_code': productCode,
        'disbursal_mode_code': transferTypeModeCode,
      };
      final response = await _apiServices.getBankCombo(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final beneficiaryComboListDto = BeneficiaryBankComboListDto.fromJson(
          response.body,
        );
        return right(beneficiaryComboListDto);
      } else {
        return left(
          const BeneficiaryFailure.unableToGetBeneficiaryBankComboList(),
        );
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, BeneficiaryBankBranchComboListDto>>
  getBeneficiaryBankBranchList({
    required String productCode,
    required String beneficiaryBankName,
    required String beneficiaryBankCode,
    required String beneficiaryCountryCode,
    required String beneficiaryCurrencyCode,
    required String transferTypeModeCode,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final queryParams = {
        'product_code': productCode,
        'bank_name': beneficiaryBankName,
        'bank_code': beneficiaryBankCode,
        'country_code': beneficiaryCountryCode,
        'currency_code': beneficiaryCurrencyCode,
        'disbursal_mode_code': transferTypeModeCode,
      };
      final response = await _apiServices.getBankBranchCombo(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final bankBranchList = BeneficiaryBankBranchComboListDto.fromJson(
          response.body,
        );
        return right(bankBranchList);
      } else {
        return left(
          const BeneficiaryFailure.unableToGetBeneficiaryBankBranchComboList(),
        );
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, BeneficiaryRouteCodeDto>>
  getBeneficiaryRouteCode({
    required String productCode,
    required String beneficiaryBankCode,
    required String beneficiaryBankBranchCode,
    required String transferTypeModeCode,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final queryParams = {
        'product_code': productCode,
        'bank_code': beneficiaryBankCode,
        'branch_code': beneficiaryBankBranchCode,
        'disbursal_mode_code': transferTypeModeCode,
      };
      final response = await _apiServices.getRouteCode(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final beneficiaryRouteCodeDto = BeneficiaryRouteCodeDto.fromJson(
          response.body,
        );
        return right(beneficiaryRouteCodeDto);
      } else {
        return left(const BeneficiaryFailure.unableToGetBeneficiaryRouteCode());
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, int>> requestBeneficiaryOtp({
    required Map<String, dynamic>? beneficiary,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final mobileCode = AppGlobal.appCountryCode;
      final mobileNumber = _sharedPrefs.getMobileNumberWithOutCode();
      final idNumber = _sharedPrefs.getIdNumber();
      final memberCode = _sharedPrefs.getMemberCode();
      final body = {
        'mobile_code': mobileCode,
        'mobile_number': mobileNumber,
        'id_number': idNumber,
        'member_code': memberCode,
        'beneficiary': beneficiary,
      };

      final response = await _apiServices.postRequestBeneficiaryOtp(
        token: token,
        body: body,
      );

      if (response.isSuccessful) {
        return right(response.body['status_code']);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        return left(
          BeneficiaryFailure.unableToSendBeneficiaryVerificationCode(message),
        );
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, String>> verifyBeneficiaryOtp({
    required BeneficiaryOtp otp,
    required Map<String, dynamic>? beneficiary,
  }) async {
    final token = _sharedPrefs.getToken();
    final mobileCode = AppGlobal.appCountryCode;
    final mobileNumber = _sharedPrefs.getMobileNumberWithOutCode();
    final idNumber = _sharedPrefs.getIdNumber();
    final memberCode = _sharedPrefs.getMemberCode();
    final otpParse = int.tryParse(otp.getOrCrash());
    try {
      final body = {
        'mobile_code': mobileCode,
        'mobile_number': mobileNumber,
        'id_number': idNumber,
        'member_code': memberCode,
        'o_t_p': otpParse,
        'beneficiary': beneficiary,
      };
      final response = await _apiServices.postVerifyBeneficiaryOtp(
        token: token,
        body: body,
      );
      if (response.isSuccessful) {
        final eId = response.body['data']['e_id']?.toString() ?? '';
        return right(eId);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        return left(BeneficiaryFailure.unableToVerifyBeneficiaryOtp(message));
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, Unit>> deleteBeneficiary({
    required String beneficiaryId,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final queryParams = {'eId': beneficiaryId};
      final response = await _apiServices.deleteBeneficiary(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        return right(unit);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        return left(BeneficiaryFailure.unableToDeleteBeneficiary(message));
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, BeneficiaryBankBranchRouteDto>>
  getBeneficiaryBankBranchFromRoute({
    required String beneficiaryRouteCode,
    required String productCode,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final queryParams = {
        'RouteCode': beneficiaryRouteCode,
        'ProductCode': productCode,
      };
      final response = await _apiServices.getBankBranchFromRoute(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final beneficiaryBankBranchRouteDto =
            BeneficiaryBankBranchRouteDto.fromJson(response.body);
        return right(beneficiaryBankBranchRouteDto);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        return left(
          BeneficiaryFailure.unableToGetBeneficiaryBankBranchRoute(message),
        );
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, HomeAgentListDto>> getBeneficiaryAgentList({
    required String destinationCountryCode,
    required String destinationCurrencyCode,
    required String transferTypeCode,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final queryParams = {
        'country_code': destinationCountryCode,
        'currency_code': destinationCurrencyCode,
        'disbursal_mode': transferTypeCode,
      };
      final response = await _apiServices.getAgents(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final agentDto = HomeAgentListDto.fromJson(response.body);
        return right(agentDto);
      } else if (response.statusCode == 406) {
        // 406 = agent is not required for this corridor. Not an error: return an
        // empty agent list so the flow proceeds straight to the mandatory check.
        return right(const HomeAgentListDto());
      } else {
        return left(const BeneficiaryFailure.unableToFetchAgentList());
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<BeneficiaryFailure, HomeMandatoryFieldCheckDto>>
  checkBeneficiaryMandatoryFields({
    required String beneficiaryId,
    required String destinationCountryCode,
    required String disbursalModeName,
    required String destinationCurrencyCode,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final locale =
          _appRouter.navigatorKey.currentContext?.locale.languageCode;
      final language = locale == 'ar' ? 'ar' : 'en';
      final queryParams = {
        'beneficiary_id': beneficiaryId,
        'country_code': destinationCountryCode,
        'destination_currency_code': destinationCurrencyCode,
        'disbursal_mode_code': disbursalModeName,
        'language': language,
      };
      final response = await _apiServices.checkBeneficiaryMandatoryFields(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final dto = HomeMandatoryFieldCheckDto.fromJson(response.body);
        final message = dto.message ?? '';
        if (dto.statusCode == 200 && message.isEmpty) {
          return right(dto);
        }
        if (dto.statusCode == 200) {
          // 200 with a message means the beneficiary is missing fields the
          // corridor/product now requires. The product (name + code) drives the
          // edit's bank/agent override.
          return left(
            BeneficiaryFailure.missingMandatoryFields(
              message,
              product: dto.data?.product,
            ),
          );
        }
        return left(const BeneficiaryFailure.unableToCheckMandatoryFields());
      } else {
        return left(const BeneficiaryFailure.unableToCheckMandatoryFields());
      }
    } catch (e) {
      return left(BeneficiaryFailure.serverError(e.toString()));
    }
  }
}
