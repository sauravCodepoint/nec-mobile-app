import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/compressor/media_compressor.dart';
import '../../domain/core/multipdart/multipart_service.dart';
import '../../domain/core/prefs/app_prefs.dart';
import '../../domain/core/services/api_services.dart';
import '../../domain/login/login_id_identity_dto.dart';
import '../../domain/update_kyc/i_update_kyc_facade.dart';
import '../../domain/update_kyc/update_kyc_failure.dart';

@LazySingleton(as: IUpdateKycFacade)
class UpdateKycRepository implements IUpdateKycFacade {
  final ApiServices _apiServices;
  final SharedPrefs _sharedPrefs;

  UpdateKycRepository(this._apiServices, this._sharedPrefs);

  // ── Identity types ─────────────────────────────────────────────────────────

  @override
  Future<Either<UpdateKycFailure, LoginIdIdentityDto>> getIdentityTypes() async {
    try {
      final response = await _apiServices.getKycComboList();
      if (response.isSuccessful) {
        return right(LoginIdIdentityDto.fromJson(response.body));
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? '';
        return left(UpdateKycFailure.unableToFetchIdentityTypes(message));
      }
    } catch (e) {
      return left(const UpdateKycFailure.serverError());
    }
  }

  // ── Documents ──────────────────────────────────────────────────────────────

  @override
  Future<Either<UpdateKycFailure, String>> uploadFrontDocument({
    required File file,
  }) async {
    return _uploadDoc(
      file: file,
      module: 'Identity Details',
      moduleCode: 62,
      docName: 'KYC Front Side ${file.uri.pathSegments.last}',
      onFailure: UpdateKycFailure.frontUploadFailed,
    );
  }

  @override
  Future<Either<UpdateKycFailure, String>> uploadBackDocument({
    required File file,
  }) async {
    return _uploadDoc(
      file: file,
      module: 'Identity Details',
      moduleCode: 62,
      docName: 'KYC Back Side ${file.uri.pathSegments.last}',
      onFailure: UpdateKycFailure.backUploadFailed,
    );
  }

  // ── Delete ─────────────────────────────────────────────────────────────────

  @override
  Future<Either<UpdateKycFailure, Unit>> deleteDocument({
    required String eId,
  }) async {
    try {
      final response = await _apiServices.deleteDocs(body: {'e_id': eId});
      if (response.isSuccessful) {
        return right(unit);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message =
            errorMap?['message']?.toString() ?? 'Failed to delete document';
        return left(UpdateKycFailure.deleteFailed(message));
      }
    } catch (e) {
      return left(const UpdateKycFailure.serverError());
    }
  }

  // ── Update KYC submit ──────────────────────────────────────────────────────

  @override
  Future<Either<UpdateKycFailure, Unit>> postUpdateKyc({
    required String idTypeCode,
    required String idNumber,
    required String issueDate,
    required String expiryDate,
    required String remarks,
    required String frontDocEId,
    required String backDocEId,
  }) async {
    try {
      final appMemberCode = _sharedPrefs.getAppMemberCode();
      final body = {
        'app_member_code': appMemberCode,
        'identity_type_code': idTypeCode,
        'id_number': idNumber,
        'issue_date': _toApiDate(issueDate),
        'expiry_date': _toApiDate(expiryDate),
        'remarks': remarks,
        'doc_ref': [
          {'e_id': frontDocEId},
          {'e_id': backDocEId},
        ],
      };
      final response = await _apiServices.postUpdateKyc(body: body);
      if (response.isSuccessful) {
        return right(unit);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message =
            errorMap?['message']?.toString() ?? 'KYC update failed';
        return left(UpdateKycFailure.submitFailed(message));
      }
    } catch (e) {
      return left(const UpdateKycFailure.serverError());
    }
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  Future<Either<UpdateKycFailure, String>> _uploadDoc({
    required File file,
    required String module,
    required int moduleCode,
    required String docName,
    required UpdateKycFailure Function(String) onFailure,
  }) async {
    try {
      final toUpload = await MediaCompressor.compressImage(file);
      final multipart = await MultipartService.convertFile(
        'file',
        toUpload.path,
      );
      final response = await _apiServices.uploadDocs(
        module: module,
        moduleCode: moduleCode,
        docName: docName,
        file: multipart,
      );
      if (toUpload.path != file.path) toUpload.delete().ignore();
      if (response.isSuccessful) {
        final eId = response.body['data']['e_id']?.toString() ?? '';
        return right(eId);
      } else {
        final errorMap = response.error as Map<String, dynamic>?;
        final message = errorMap?['message']?.toString() ?? 'Upload failed';
        return left(onFailure(message));
      }
    } catch (e) {
      return left(const UpdateKycFailure.serverError());
    }
  }

  String _toApiDate(String ddmmyyyy) {
    final p = ddmmyyyy.split('/');
    return '${p[2]}-${p[1].padLeft(2, '0')}-${p[0].padLeft(2, '0')}';
  }
}