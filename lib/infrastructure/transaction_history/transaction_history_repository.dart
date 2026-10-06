import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/core/services/api_services.dart';
import '../../domain/transaction_history/i_transaction_history_facade.dart';
import '../../domain/transaction_history/transaction_history_beneficiary_dto.dart';
import '../../domain/transaction_history/transaction_history_country_combo_dto.dart';
import '../../domain/transaction_history/transaction_history_details_dto.dart';
import '../../domain/transaction_history/transaction_history_dto.dart';
import '../../domain/transaction_history/transaction_history_failure.dart';
import '../../presentation/core/global/app_global.dart';

@LazySingleton(as: ITransactionHistoryFacade)
class TransactionHistoryRepository implements ITransactionHistoryFacade {
  final ApiServices _apiService;
  final SharedPrefs _appPrefs;
  TransactionHistoryRepository(this._apiService, this._appPrefs);
  @override
  Future<Either<TransactionHistoryFailure, TransactionHistoryDto>>
  getTransactionHistory({
    required int page,
    String? sortBy,
    String? sortOrder,
    List<String>? countryCodes,
    List<String>? beneficiaryCodes,
    String? keyword,
  }) async {
    try {
      final token = _appPrefs.getToken();
      final queryParams = <String, dynamic>{
        'page_index': page,
        'sort_order': ?sortOrder,
        'sort_by': ?sortBy,
        if ((beneficiaryCodes ?? []).isNotEmpty)
          'filter_beneficiary': beneficiaryCodes!.join(','),
        if ((countryCodes ?? []).isNotEmpty)
          'filter_country': countryCodes!.join(','),
        if (keyword != null && keyword.trim().isNotEmpty)
          'keyword': keyword.trim().toLowerCase(),
      };
      final response = await _apiService.getTransactionHistories(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final dto = TransactionHistoryDto.fromJson(response.body);
        return right(dto);
      } else {
        return left(
          const TransactionHistoryFailure.unableToGetTransactionHistory(),
        );
      }
    } catch (e) {
      return left(const TransactionHistoryFailure.serverError());
    }
  }

  @override
  Future<Either<TransactionHistoryFailure, TransactionHistoryBeneficiaryDto>>
  getTransactionHistoryBeneficiary() async {
    try {
      final token = _appPrefs.getToken();
      final appMemberCode = _appPrefs.getAppMemberCode();
      final queryParams = {'app_member_code': appMemberCode};
      final response = await _apiService.getBeneficiaries(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final dto = TransactionHistoryBeneficiaryDto.fromJson(response.body);
        return right(dto);
      } else {
        return left(
          const TransactionHistoryFailure.unableToGetTransactionHistoryBeneficiary(),
        );
      }
    } catch (e) {
      return left(const TransactionHistoryFailure.serverError());
    }
  }

  @override
  Future<Either<TransactionHistoryFailure, TransactionHistoryCountryComboDto>>
  getTransactionHistoryCountryCombo() async {
    try {
      final response = await _apiService.getCountryCombo();
      if (response.isSuccessful) {
        final dto = TransactionHistoryCountryComboDto.fromJson(response.body);
        return right(dto);
      } else {
        return left(
          const TransactionHistoryFailure.unableToGetTransactionHistoryCountryCombo(),
        );
      }
    } catch (e) {
      return left(const TransactionHistoryFailure.serverError());
    }
  }

  @override
  Future<Either<TransactionHistoryFailure, TransactionHistoryDetailsDto>>
  getTransactionHistoryDetails({
    required String beneficiaryId,
    required int transactionReference,
  }) async {
    try {
      final token = _appPrefs.getToken();
      final queryParams = {
        'eId': beneficiaryId,
        'transaction_reference': transactionReference,
      };
      final response = await _apiService.getTransactionDetails(
        token: token,
        queryParams: queryParams,
      );
      if (response.isSuccessful) {
        final dto = TransactionHistoryDetailsDto.fromJson(response.body);
        return right(dto);
      } else {
        return left(
          const TransactionHistoryFailure.unableToGetTransactionHistoryDetails(),
        );
      }
    } catch (e) {
      return left(const TransactionHistoryFailure.serverError());
    }
  }

  @override
  Future<Either<TransactionHistoryFailure, String>>
  downloadOrShareTransactionReceipt({
    required int transactionReference,
    required String? status,
  }) async {
    try {
      Directory? dir;
      if (Platform.isAndroid) {
        dir = Directory('/storage/emulated/0/Download');
        // Writing to the public Download folder needs WRITE_EXTERNAL_STORAGE
        // up to API 29; Android 11+ allows app-created files there freely.
        final sdkInt = (await DeviceInfoPlugin().androidInfo).version.sdkInt;
        if (sdkInt <= 29 && !await Permission.storage.request().isGranted) {
          return left(
            const TransactionHistoryFailure.unableToDownloadOrShareTransactionHistoryReceipt(),
          );
        }
      } else {
        dir = await getApplicationDocumentsDirectory();
      }

      // The receipt changes as the transaction status advances, so the cache
      // is keyed by status: a status change yields a new filename and forces a
      // fresh download. Only a settled ('success') receipt is immutable and
      // safe to reuse from disk; anything still in-flight (or unknown/null
      // status) is always re-fetched and overwritten so we never serve a stale
      // receipt.
      final txnStatus = TransactionStatus.fromValue(status);
      final filePath =
          '${dir.path}/receipt_${transactionReference}_${txnStatus.name}.pdf';
      final file = File(filePath);

      if (txnStatus == TransactionStatus.success && await file.exists()) {
        return right(filePath);
      }

      final token = _appPrefs.getToken();

      final response = await _apiService.downloadOrShareReceipt(
        token: token,
        queryParams: {'RefNo': transactionReference},
      );

      if (response.isSuccessful) {
        List<int>? bytes;

        if (response.body is List<int>) {
          bytes = response.body;
        } else {
          final bodyString = response.body.toString();
          bytes = utf8.encode(bodyString);
        }

        await file.writeAsBytes(bytes!);

        return right(filePath);
      } else {
        return left(
          const TransactionHistoryFailure.unableToDownloadOrShareTransactionHistoryReceipt(),
        );
      }
    } catch (e) {
      return left(const TransactionHistoryFailure.serverError());
    }
  }
}
