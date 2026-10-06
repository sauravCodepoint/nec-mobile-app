// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:local_auth/local_auth.dart' as _i152;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../../application/app_update/app_update_bloc.dart' as _i614;
import '../../../application/beneficiary/beneficiary_bloc.dart' as _i589;
import '../../../application/bio_metric/bio_metric_bloc.dart' as _i162;
import '../../../application/branches/branches_bloc.dart' as _i1061;
import '../../../application/change_mpin/change_mpin_bloc.dart' as _i883;
import '../../../application/company_info/company_info_bloc.dart' as _i832;
import '../../../application/complete_profile/complete_profile_bloc.dart'
    as _i564;
import '../../../application/forgot_mpin/forgot_mpin_bloc.dart' as _i740;
import '../../../application/home/home_bloc.dart' as _i485;
import '../../../application/login/login_bloc.dart' as _i779;
import '../../../application/member_approval/member_approval_bloc.dart'
    as _i471;
import '../../../application/mpin/mpin_bloc.dart' as _i527;
import '../../../application/notification/notification_bloc.dart' as _i547;
import '../../../application/on_boarding/on_boarding_bloc.dart' as _i808;
import '../../../application/otp/otp_bloc.dart' as _i698;
import '../../../application/profile/profile_bloc.dart' as _i694;
import '../../../application/rate_calculator/rate_calculator_bloc.dart'
    as _i735;
import '../../../application/set_mpin/set_mpin_bloc.dart' as _i567;
import '../../../application/settings/settings_bloc.dart' as _i682;
import '../../../application/splash/splash_bloc.dart' as _i623;
import '../../../application/summary/summary_bloc.dart' as _i1000;
import '../../../application/support/support_bloc.dart' as _i531;
import '../../../application/transaction_history/transaction_history_bloc.dart'
    as _i1062;
import '../../../application/update_kyc/update_kyc_bloc.dart' as _i428;
import '../../../infrastructure/app_update/app_update_repository.dart' as _i134;
import '../../../infrastructure/beneficiary/beneficiary_repository.dart'
    as _i562;
import '../../../infrastructure/branches/branches_repository.dart' as _i1071;
import '../../../infrastructure/change_mpin/change_mpin_repository.dart' as _i6;
import '../../../infrastructure/company_info/company_info_repository.dart'
    as _i401;
import '../../../infrastructure/complete_profile/complete_profile_repository.dart'
    as _i284;
import '../../../infrastructure/core/app_injectable/app_injectable.dart'
    as _i697;
import '../../../infrastructure/core/audit/audit_log_repository.dart' as _i1005;
import '../../../infrastructure/forgot_mpin/forgot_mpin_repository.dart'
    as _i584;
import '../../../infrastructure/home/home_repository.dart' as _i1019;
import '../../../infrastructure/login/login_repository.dart' as _i1060;
import '../../../infrastructure/member_approval/member_approval_repository.dart'
    as _i920;
import '../../../infrastructure/mpin/mpin_repository.dart' as _i1046;
import '../../../infrastructure/notification/notification_repository.dart'
    as _i142;
import '../../../infrastructure/otp/otp_repository.dart' as _i236;
import '../../../infrastructure/profile/profile_repository.dart' as _i539;
import '../../../infrastructure/rate_calculator/rate_calculator_repository.dart'
    as _i263;
import '../../../infrastructure/security/security_service.dart' as _i952;
import '../../../infrastructure/set_mpin/set_mpin_repository.dart' as _i611;
import '../../../infrastructure/settings/settings_repository.dart' as _i965;
import '../../../infrastructure/summary/summary_repository.dart' as _i441;
import '../../../infrastructure/support/support_repository.dart' as _i939;
import '../../../infrastructure/transaction_history/transaction_history_repository.dart'
    as _i925;
import '../../../infrastructure/update_kyc/update_kyc_repository.dart' as _i326;
import '../../../presentation/routes/app_routes.dart' as _i139;
import '../../app_update/i_app_update_facade.dart' as _i360;
import '../../beneficiary/i_beneficiary_facade.dart' as _i452;
import '../../branches/i_branches_facade.dart' as _i20;
import '../../change_mpin/i_change_mpin_facade.dart' as _i43;
import '../../company_info/i_company_info_facade.dart' as _i77;
import '../../complete_profile/i_complete_profile_facade.dart' as _i199;
import '../../forgot_mpin/i_forgot_mpin_facade.dart' as _i1012;
import '../../home/i_home_facade.dart' as _i490;
import '../../login/i_login_facade.dart' as _i772;
import '../../member_approval/i_member_approval_facade.dart' as _i233;
import '../../mpin/i_mpin_facade.dart' as _i157;
import '../../notification/i_notification_facade.dart' as _i636;
import '../../otp/i_otp_facade.dart' as _i797;
import '../../profile/i_profile_facade.dart' as _i108;
import '../../rate_calculator/i_rate_calculator_facade.dart' as _i341;
import '../../set_mpin/i_set_mpin_facade.dart' as _i232;
import '../../settings/i_settings_facade.dart' as _i744;
import '../../summary/i_summary_facade.dart' as _i975;
import '../../support/i_support_facade.dart' as _i476;
import '../../transaction_history/i_transaction_history_facade.dart' as _i990;
import '../../update_kyc/i_update_kyc_facade.dart' as _i261;
import '../audit/i_audit_log_facade.dart' as _i1045;
import '../device_helper/app_device_helper.dart' as _i528;
import '../encryption_helper/app_encryption_helper.dart' as _i834;
import '../network/connectivity_service.dart' as _i491;
import '../permission_handler/app_permission_handler.dart' as _i615;
import '../prefs/app_prefs.dart' as _i469;
import '../services/api_services.dart' as _i500;
import '../session/force_logout_handler.dart' as _i566;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final appInjectableModule = _$AppInjectableModule();
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => appInjectableModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i528.AppDeviceHelper>(() => _i528.AppDeviceHelper());
  gh.lazySingleton<_i834.AppEncryptionHelper>(
    () => _i834.AppEncryptionHelper(),
  );
  gh.lazySingleton<_i491.ConnectivityService>(
    () => _i491.ConnectivityService(),
  );
  gh.lazySingleton<_i615.AppPermissionHandler>(
    () => _i615.AppPermissionHandler(),
  );
  gh.lazySingleton<_i500.ApiServices>(() => appInjectableModule.apiServices);
  gh.lazySingleton<_i152.LocalAuthentication>(
    () => appInjectableModule.localAuthentication,
  );
  gh.lazySingleton<_i952.SecurityService>(() => _i952.SecurityService());
  gh.lazySingleton<_i360.IAppUpdateFacade>(
    () => _i134.AppUpdateRepository(gh<_i500.ApiServices>()),
  );
  gh.lazySingleton<_i772.ILoginFacade>(
    () => _i1060.LoginRepository(
      gh<_i500.ApiServices>(),
      gh<_i528.AppDeviceHelper>(),
    ),
  );
  gh.lazySingleton<_i341.IRateCalculatorFacade>(
    () => _i263.RateCalculatorRepository(gh<_i500.ApiServices>()),
  );
  gh.lazySingleton<_i476.ISupportFacade>(
    () => _i939.SupportRepository(gh<_i500.ApiServices>()),
  );
  gh.factory<_i614.AppUpdateBloc>(
    () => _i614.AppUpdateBloc(gh<_i360.IAppUpdateFacade>()),
  );
  gh.lazySingleton<_i77.ICompanyInfoFacade>(
    () => _i401.CompanyInfoRepository(gh<_i500.ApiServices>()),
  );
  gh.factory<_i832.CompanyInfoBloc>(
    () => _i832.CompanyInfoBloc(gh<_i77.ICompanyInfoFacade>()),
  );
  gh.factory<_i735.RateCalculatorBloc>(
    () => _i735.RateCalculatorBloc(gh<_i341.IRateCalculatorFacade>()),
  );
  gh.lazySingleton<_i20.IBranchesFacade>(
    () => _i1071.BranchesRepository(gh<_i500.ApiServices>()),
  );
  gh.factory<_i1061.BranchesBloc>(
    () => _i1061.BranchesBloc(gh<_i20.IBranchesFacade>()),
  );
  gh.factory<_i531.SupportBloc>(
    () => _i531.SupportBloc(gh<_i476.ISupportFacade>()),
  );
  gh.lazySingleton<_i469.SharedPrefs>(
    () => _i469.SharedPrefs(
      gh<_i460.SharedPreferences>(),
      gh<_i834.AppEncryptionHelper>(),
    ),
  );
  gh.lazySingleton<_i43.IChangeMpinFacade>(
    () => _i6.ChangeMpinRepository(
      gh<_i500.ApiServices>(),
      gh<_i469.SharedPrefs>(),
    ),
  );
  gh.lazySingleton<_i990.ITransactionHistoryFacade>(
    () => _i925.TransactionHistoryRepository(
      gh<_i500.ApiServices>(),
      gh<_i469.SharedPrefs>(),
    ),
  );
  gh.factory<_i779.LoginBloc>(
    () => _i779.LoginBloc(gh<_i772.ILoginFacade>(), gh<_i469.SharedPrefs>()),
  );
  gh.lazySingleton<_i975.ISummaryFacade>(
    () => _i441.SummaryRepository(
      gh<_i500.ApiServices>(),
      gh<_i469.SharedPrefs>(),
    ),
  );
  gh.lazySingleton<_i566.ForceLogoutHandler>(
    () => _i566.ForceLogoutHandler(
      gh<_i469.SharedPrefs>(),
      gh<_i139.AppRouter>(),
    ),
  );
  gh.lazySingleton<_i261.IUpdateKycFacade>(
    () => _i326.UpdateKycRepository(
      gh<_i500.ApiServices>(),
      gh<_i469.SharedPrefs>(),
    ),
  );
  gh.lazySingleton<_i1045.IAuditLogFacade>(
    () => _i1005.AuditLogRepository(gh<_i469.SharedPrefs>()),
  );
  gh.lazySingleton<_i1012.IForgotMpinFacade>(
    () => _i584.ForgotMpinRepository(
      gh<_i500.ApiServices>(),
      gh<_i528.AppDeviceHelper>(),
      gh<_i469.SharedPrefs>(),
    ),
  );
  gh.lazySingleton<_i636.INotificationFacade>(
    () => _i142.NotificationRepository(
      gh<_i500.ApiServices>(),
      gh<_i469.SharedPrefs>(),
      gh<_i528.AppDeviceHelper>(),
    ),
  );
  gh.factory<_i883.ChangeMpinBloc>(
    () => _i883.ChangeMpinBloc(gh<_i43.IChangeMpinFacade>()),
  );
  gh.factory<_i808.OnBoardingBloc>(
    () => _i808.OnBoardingBloc(gh<_i469.SharedPrefs>()),
  );
  gh.factory<_i623.SplashBloc>(() => _i623.SplashBloc(gh<_i469.SharedPrefs>()));
  gh.lazySingleton<_i744.ISettingsFacade>(
    () => _i965.SettingsRepository(
      gh<_i500.ApiServices>(),
      gh<_i469.SharedPrefs>(),
      gh<_i152.LocalAuthentication>(),
    ),
  );
  gh.lazySingleton<_i490.IHomeFacade>(
    () => _i1019.HomeRepository(
      gh<_i500.ApiServices>(),
      gh<_i469.SharedPrefs>(),
      gh<_i139.AppRouter>(),
    ),
  );
  gh.factory<_i682.SettingsBloc>(
    () => _i682.SettingsBloc(gh<_i744.ISettingsFacade>()),
  );
  gh.factory<_i547.NotificationBloc>(
    () => _i547.NotificationBloc(gh<_i636.INotificationFacade>()),
  );
  gh.lazySingleton<_i199.ICompleteProfileFacade>(
    () => _i284.CompleteProfileRepository(
      gh<_i500.ApiServices>(),
      gh<_i469.SharedPrefs>(),
      gh<_i139.AppRouter>(),
      gh<_i528.AppDeviceHelper>(),
    ),
  );
  gh.lazySingleton<_i452.IBeneficiaryFacade>(
    () => _i562.BeneficiaryRepository(
      gh<_i500.ApiServices>(),
      gh<_i469.SharedPrefs>(),
      gh<_i139.AppRouter>(),
    ),
  );
  gh.factory<_i589.BeneficiaryBloc>(
    () => _i589.BeneficiaryBloc(gh<_i452.IBeneficiaryFacade>()),
  );
  gh.lazySingleton<_i797.IOtpFacade>(
    () => _i236.OtpRepository(
      gh<_i500.ApiServices>(),
      gh<_i469.SharedPrefs>(),
      gh<_i528.AppDeviceHelper>(),
    ),
  );
  gh.lazySingleton<_i232.ISetMpinFacade>(
    () => _i611.SetMpinRepository(
      gh<_i500.ApiServices>(),
      gh<_i469.SharedPrefs>(),
    ),
  );
  gh.lazySingleton<_i233.IMemberApprovalFacade>(
    () => _i920.MemberApprovalRepository(
      gh<_i500.ApiServices>(),
      gh<_i469.SharedPrefs>(),
    ),
  );
  gh.factory<_i1062.TransactionHistoryBloc>(
    () => _i1062.TransactionHistoryBloc(gh<_i990.ITransactionHistoryFacade>()),
  );
  gh.factory<_i471.MemberApprovalBloc>(
    () => _i471.MemberApprovalBloc(gh<_i233.IMemberApprovalFacade>()),
  );
  gh.factory<_i698.OtpBloc>(
    () => _i698.OtpBloc(gh<_i797.IOtpFacade>(), gh<_i469.SharedPrefs>()),
  );
  gh.lazySingleton<_i157.IMpinFacade>(
    () => _i1046.MpinRepository(
      gh<_i500.ApiServices>(),
      gh<_i469.SharedPrefs>(),
      gh<_i528.AppDeviceHelper>(),
    ),
  );
  gh.factory<_i162.BioMetricBloc>(
    () => _i162.BioMetricBloc(
      gh<_i469.SharedPrefs>(),
      gh<_i152.LocalAuthentication>(),
    ),
  );
  gh.lazySingleton<_i108.IProfileFacade>(
    () => _i539.ProfileRepository(
      gh<_i500.ApiServices>(),
      gh<_i469.SharedPrefs>(),
    ),
  );
  gh.factory<_i567.SetMpinBloc>(
    () => _i567.SetMpinBloc(gh<_i232.ISetMpinFacade>()),
  );
  gh.factory<_i428.UpdateKycBloc>(
    () => _i428.UpdateKycBloc(gh<_i261.IUpdateKycFacade>()),
  );
  gh.factory<_i740.ForgotMpinBloc>(
    () => _i740.ForgotMpinBloc(gh<_i1012.IForgotMpinFacade>()),
  );
  gh.factory<_i1000.SummaryBloc>(
    () => _i1000.SummaryBloc(gh<_i975.ISummaryFacade>()),
  );
  gh.factory<_i564.CompleteProfileBloc>(
    () => _i564.CompleteProfileBloc(gh<_i199.ICompleteProfileFacade>()),
  );
  gh.factory<_i485.HomeBloc>(() => _i485.HomeBloc(gh<_i490.IHomeFacade>()));
  gh.factory<_i694.ProfileBloc>(
    () => _i694.ProfileBloc(gh<_i108.IProfileFacade>()),
  );
  gh.factory<_i527.MpinBloc>(
    () => _i527.MpinBloc(
      gh<_i157.IMpinFacade>(),
      gh<_i152.LocalAuthentication>(),
      gh<_i469.SharedPrefs>(),
    ),
  );
  return getIt;
}

class _$AppInjectableModule extends _i697.AppInjectableModule {}
