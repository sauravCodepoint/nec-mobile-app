import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import '../../domain/common/common_transaction_dto.dart';
import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/core/services/api_services.dart';
import '../../domain/home/home_advertisement_dto.dart';
import '../../domain/home/home_agent_list_dto.dart';
import '../../domain/home/home_bank_or_agent_list_dto.dart';
import '../../domain/home/home_beneficiary_list_dto.dart';
import '../../domain/home/home_destination_currency_list_dto.dart';
import '../../domain/home/home_failure.dart';
import '../../domain/home/home_mandatory_field_check_dto.dart';
import '../../domain/home/home_recent_beneficiaries_dto.dart';
import '../../domain/home/home_transfer_type_dto.dart';
import '../../domain/home/home_user_dto.dart';
import '../../domain/home/i_home_facade.dart';
import '../../presentation/routes/app_routes.dart';

@LazySingleton(as: IHomeFacade)
class HomeRepository implements IHomeFacade {
  final ApiServices _apiServices;
  final SharedPrefs _sharedPrefs;
  final AppRouter _appRouter;
  HomeRepository(this._apiServices, this._sharedPrefs, this._appRouter);

  @override
  Future<Either<HomeFailure, HomeAdvertisementDto>>
  getHomeAdvertisement() async {
    try {
      final response = await _apiServices.getAdvertisement();
      if (response.isSuccessful) {
        final advertisementDto = HomeAdvertisementDto.fromJson(response.body);
        return right(advertisementDto);
      } else {
        return left(const HomeFailure.unableToFetchAdvertisement());
      }
    } catch (e) {
      return left(const HomeFailure.serverError());
    }
  }

  @override
  Future<Either<HomeFailure, HomeUserDto>> getHomeUserData() async {
    try {
      final token = _sharedPrefs.getToken();
      final response = await _apiServices.getUserInfo(token: token);
      if (response.isSuccessful) {
        final homeUserDto = HomeUserDto.fromJson(response.body);
        return right(homeUserDto);
      } else {
        return left(const HomeFailure.unableToFetchUserData());
      }
    } catch (e) {
      return left(const HomeFailure.serverError());
    }
  }

  @override
  Future<Either<HomeFailure, HomeRecentBeneficiariesDto>>
  getHomeBeneficiaries() async {
    try {
      final token = _sharedPrefs.getToken();
      final appMemberCode = _sharedPrefs.getAppMemberCode();
      final queryParams = {'app_member_code': appMemberCode};
      final response = await _apiServices.getRecentBeneficiaries(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final beneficiariesDto = HomeRecentBeneficiariesDto.fromJson(
          response.body,
        );
        return right(beneficiariesDto);
      } else {
        return left(const HomeFailure.unableToFetchBeneficiaries());
      }
    } catch (e) {
      return left(const HomeFailure.serverError());
    }
  }

  @override
  Future<Either<HomeFailure, CommonTransactionDto>>
  getHomeRecentTransactions() async {
    try {
      final token = _sharedPrefs.getToken();
      // Reuses the transaction-list endpoint the history page pages through.
      // Home only ever renders the newest five, so the first page — returned
      // newest-first by the backend — is all it asks for. Parsed straight into
      // the shared CommonTransactionDto (same wire shape as the history list),
      // which is also what AppTransactionTile draws from.
      final queryParams = <String, dynamic>{'page_index': 1};
      final response = await _apiServices.getTransactionHistories(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final dto = CommonTransactionDto.fromJson(response.body);
        return right(dto);
      } else {
        return left(const HomeFailure.unableToFetchRecentTransactions());
      }
    } catch (e) {
      return left(const HomeFailure.serverError());
    }
  }

  @override
  Future<Either<HomeFailure, HomeDestinationCurrencyListDto>>
  getHomeDestinationCurrencyList() async {
    try {
      final queryParams = {'is_base': false};
      final response = await _apiServices.getCurrencies(
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final destinationCurrencyListDto =
            HomeDestinationCurrencyListDto.fromJson(response.body);
        return right(destinationCurrencyListDto);
      } else {
        return left(const HomeFailure.unableToFetchDestinationCurrencyList());
      }
    } catch (e) {
      return left(const HomeFailure.serverError());
    }
  }

  @override
  Future<Either<HomeFailure, HomeTransferTypeDto>> getHomeTransferTypes({
    required String destinationCurrencyCode,
    required String destinationCountryCode,
  }) async {
    try {
      final queryParams = {
        'country_code': destinationCountryCode,
        'currency_code': destinationCurrencyCode,
      };
      final response = await _apiServices.getTransferTypes(
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final transferTypeDto = HomeTransferTypeDto.fromJson(response.body);
        return right(transferTypeDto);
      } else {
        return left(const HomeFailure.unableToFetchTransferTypes());
      }
    } catch (e) {
      return left(const HomeFailure.serverError());
    }
  }

  @override
  Future<Either<HomeFailure, HomeBankOrAgentListDto>> getHomeBankOrAgentList({
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
      final response = await _apiServices.getBankOrAgents(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final bankOrAgentDto = HomeBankOrAgentListDto.fromJson(response.body);
        return right(bankOrAgentDto);
      } else {
        return left(const HomeFailure.unableToFetchBankOrAgentList());
      }
    } catch (e) {
      return left(const HomeFailure.serverError());
    }
  }

  @override
  Future<Either<HomeFailure, HomeAgentListDto>> getHomeAgentList({
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
        // 406 = agent is not required for this corridor. This is not an error:
        // return an empty agent list so the corridor settles cleanly (no
        // failure, no UI to show). Downstream, an empty list self-hides the
        // Agent field and the Pay Now validation reads it as "no selection
        // required", letting the user proceed. The `agentNotRequired` marker
        // is what earns that pass: it is the only way the send-money gate can
        // tell this case apart from a 200 carrying an empty list, which is a
        // corridor with no agent at all and must block instead.
        return right(const HomeAgentListDto(agentNotRequired: true));
      } else {
        return left(const HomeFailure.unableToFetchAgentList());
      }
    } catch (e) {
      return left(const HomeFailure.serverError());
    }
  }

  @override
  Future<Either<HomeFailure, HomeBeneficiaryListDto>> getHomeBeneficiaryList({
    required String transferTypeCode,
    required String destinationCountryCode,
    required String destinationCurrencyCode,
    required String productCode,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final queryParams = {
        'transfer_mode_code': transferTypeCode,
        'country_code': destinationCountryCode,
        'CurrencyCode': destinationCurrencyCode,
        'product_code': productCode,
      };
      final response = await _apiServices.getBeneficiaries(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final beneficiaryListDto = HomeBeneficiaryListDto.fromJson(
          response.body,
        );
        return right(beneficiaryListDto);
      } else {
        return left(const HomeFailure.unableToFetchBeneficiaryList());
      }
    } catch (e) {
      return left(const HomeFailure.serverError());
    }
  }

  @override
  Future<Either<HomeFailure, String>> deleteBeneficiary({
    required String eId,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final queryParams = {'eId': eId};
      final response = await _apiServices.deleteBeneficiary(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        return right(eId);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        return left(HomeFailure.unableToDeleteBeneficiary(message));
      }
    } catch (e) {
      return left(HomeFailure.serverError());
    }
  }

  @override
  Future<Either<HomeFailure, HomeMandatoryFieldCheckDto>>
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
          // 200 with a message means the beneficiary record is missing
          // fields that are now mandatory for this corridor/product. The
          // response's product (name + code) drives the edit's bank/agent
          // override so the form re-targets the product the check ran against.
          return left(
            HomeFailure.missingMandatoryFields(
              message,
              product: dto.data?.product,
            ),
          );
        }
        return left(const HomeFailure.unableToCheckMandatoryFields());
      } else {
        return left(const HomeFailure.unableToCheckMandatoryFields());
      }
    } catch (e) {
      return left(const HomeFailure.serverError());
    }
  }

  @override
  Future<Either<HomeFailure, Unit>> requestEmailOtp({
    required String email,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final memberCode = _sharedPrefs.getMemberCode();
      final queryParams = {'member_code': memberCode, 'email': email};
      final response = await _apiServices.postRequestEmailOtp(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        return right(unit);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        return left(HomeFailure.unableToUpdateEmailAddress(message));
      }
    } catch (e) {
      return left(HomeFailure.serverError());
    }
  }

  @override
  Future<Either<HomeFailure, Unit>> verifyEmailOtp({
    required String otp,
    required String email,
  }) async {
    try {
      final token = _sharedPrefs.getToken();
      final memberCode = _sharedPrefs.getMemberCode();
      final queryParams = {
        'member_code': memberCode,
        'otp': otp,
        'email': email,
      };
      final response = await _apiServices.postVerifyEmailOtp(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        return right(unit);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        return left(HomeFailure.unableToVerifyEmailOtp(message));
      }
    } catch (e) {
      return left(HomeFailure.serverError());
    }
  }
}
