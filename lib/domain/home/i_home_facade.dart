import 'package:dartz/dartz.dart';
import '../common/common_transaction_dto.dart';
import 'home_advertisement_dto.dart';
import 'home_agent_list_dto.dart';
import 'home_bank_or_agent_list_dto.dart';
import 'home_beneficiary_list_dto.dart';
import 'home_destination_currency_list_dto.dart';
import 'home_failure.dart';
import 'home_mandatory_field_check_dto.dart';
import 'home_recent_beneficiaries_dto.dart';
import 'home_transfer_type_dto.dart';
import 'home_user_dto.dart';

abstract class IHomeFacade {
  Future<Either<HomeFailure, HomeAdvertisementDto>> getHomeAdvertisement();
  Future<Either<HomeFailure, HomeUserDto>> getHomeUserData();
  Future<Either<HomeFailure, HomeRecentBeneficiariesDto>>
  getHomeBeneficiaries();
  Future<Either<HomeFailure, CommonTransactionDto>> getHomeRecentTransactions();
  Future<Either<HomeFailure, HomeDestinationCurrencyListDto>>
  getHomeDestinationCurrencyList();
  Future<Either<HomeFailure, HomeTransferTypeDto>> getHomeTransferTypes({
    required String destinationCurrencyCode,
    required String destinationCountryCode,
  });
  Future<Either<HomeFailure, HomeBankOrAgentListDto>> getHomeBankOrAgentList({
    required String destinationCountryCode,
    required String destinationCurrencyCode,
    required String transferTypeCode,
  });
  Future<Either<HomeFailure, HomeAgentListDto>> getHomeAgentList({
    required String destinationCountryCode,
    required String destinationCurrencyCode,
    required String transferTypeCode,
  });
  Future<Either<HomeFailure, HomeBeneficiaryListDto>> getHomeBeneficiaryList({
    required String transferTypeCode,
    required String destinationCountryCode,
    required String destinationCurrencyCode,
    required String productCode,
  });
  Future<Either<HomeFailure, String>> deleteBeneficiary({required String eId});
  Future<Either<HomeFailure, HomeMandatoryFieldCheckDto>>
  checkBeneficiaryMandatoryFields({
    required String beneficiaryId,
    required String destinationCountryCode,
    required String disbursalModeName,
    required String destinationCurrencyCode,
  });
  Future<Either<HomeFailure, Unit>> requestEmailOtp({required String email});
  Future<Either<HomeFailure, Unit>> verifyEmailOtp({
    required String otp,
    required String email,
  });
}
