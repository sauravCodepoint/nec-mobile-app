// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i40;
import 'package:flutter/foundation.dart' as _i45;
import 'package:flutter/material.dart' as _i41;
import 'package:nec_mobile_app/domain/common/common_branches_dto.dart' as _i44;
import 'package:nec_mobile_app/domain/common/common_payment_result_dto.dart'
    as _i43;
import 'package:nec_mobile_app/domain/common/common_selectable_dto.dart'
    as _i42;
import 'package:nec_mobile_app/domain/company_info/company_info_type.dart'
    as _i46;
import 'package:nec_mobile_app/domain/notification/notification_dto.dart'
    as _i47;
import 'package:nec_mobile_app/presentation/beneficiary/beneficiary_page.dart'
    as _i7;
import 'package:nec_mobile_app/presentation/beneficiary/widgets/beneficiary_add_form.dart'
    as _i4;
import 'package:nec_mobile_app/presentation/beneficiary/widgets/beneficiary_edit_form.dart'
    as _i5;
import 'package:nec_mobile_app/presentation/beneficiary/widgets/beneficiary_otp_view.dart'
    as _i6;
import 'package:nec_mobile_app/presentation/bio_metric/bio_metric_page.dart'
    as _i8;
import 'package:nec_mobile_app/presentation/branches/branches_page.dart' as _i9;
import 'package:nec_mobile_app/presentation/change_mpin/change_current_mpin_page.dart'
    as _i10;
import 'package:nec_mobile_app/presentation/change_mpin/widgets/change_new_mpin_view.dart'
    as _i11;
import 'package:nec_mobile_app/presentation/change_mpin/widgets/change_verify_mpin_view.dart'
    as _i12;
import 'package:nec_mobile_app/presentation/company_info/company_info_page.dart'
    as _i13;
import 'package:nec_mobile_app/presentation/complete_profile/complete_profile_page.dart'
    as _i14;
import 'package:nec_mobile_app/presentation/core/payment_method_page/app_payment_method_page.dart'
    as _i1;
import 'package:nec_mobile_app/presentation/core/result_page/app_payment_result_page.dart'
    as _i2;
import 'package:nec_mobile_app/presentation/core/selectable_page/app_selectable_page.dart'
    as _i3;
import 'package:nec_mobile_app/presentation/forgot_mpin/forgot_mpin_page.dart'
    as _i15;
import 'package:nec_mobile_app/presentation/forgot_mpin/widgets/forgot_otp_view.dart'
    as _i16;
import 'package:nec_mobile_app/presentation/home/widgets/home_beneficiary_view.dart'
    as _i17;
import 'package:nec_mobile_app/presentation/home/widgets/home_email_otp_view.dart'
    as _i18;
import 'package:nec_mobile_app/presentation/home/widgets/home_email_view.dart'
    as _i19;
import 'package:nec_mobile_app/presentation/login/login_page.dart' as _i21;
import 'package:nec_mobile_app/presentation/login/widgets/login_contact_us_view.dart'
    as _i20;
import 'package:nec_mobile_app/presentation/main/main_page.dart' as _i22;
import 'package:nec_mobile_app/presentation/member_approval/member_approval_page.dart'
    as _i23;
import 'package:nec_mobile_app/presentation/mpin/mpin_page.dart' as _i24;
import 'package:nec_mobile_app/presentation/notification/notification_page.dart'
    as _i26;
import 'package:nec_mobile_app/presentation/notification/widgets/notification_detail_view.dart'
    as _i25;
import 'package:nec_mobile_app/presentation/on_boarding/on_boarding_page.dart'
    as _i27;
import 'package:nec_mobile_app/presentation/otp/otp_page.dart' as _i28;
import 'package:nec_mobile_app/presentation/profile/profile_page.dart' as _i31;
import 'package:nec_mobile_app/presentation/profile/widgets/profile_email_otp_view.dart'
    as _i29;
import 'package:nec_mobile_app/presentation/profile/widgets/profile_email_view.dart'
    as _i30;
import 'package:nec_mobile_app/presentation/rate_calculator/rate_calculator_page.dart'
    as _i32;
import 'package:nec_mobile_app/presentation/set_mpin/set_mpin_page.dart'
    as _i33;
import 'package:nec_mobile_app/presentation/set_mpin/widgets/set_verify_mpin_view.dart'
    as _i34;
import 'package:nec_mobile_app/presentation/splash/splash_page.dart' as _i35;
import 'package:nec_mobile_app/presentation/summary/summary_page.dart' as _i36;
import 'package:nec_mobile_app/presentation/support/support_page.dart' as _i37;
import 'package:nec_mobile_app/presentation/transaction_history/transaction_history_page.dart'
    as _i38;
import 'package:nec_mobile_app/presentation/update_kyc/update_kyc_page.dart'
    as _i39;

/// generated route for
/// [_i1.AppPaymentMethodPage]
class AppPaymentMethodRoute
    extends _i40.PageRouteInfo<AppPaymentMethodRouteArgs> {
  AppPaymentMethodRoute({
    _i41.Key? key,
    String? title,
    String? subtitle,
    _i42.CommonSelectableDto? commonSelectableDto,
    _i42.CommonSelectableItem? initialSelectedItem,
    _i41.ValueChanged<_i42.CommonSelectableItem>? onSelected,
    List<_i40.PageRouteInfo>? children,
  }) : super(
         AppPaymentMethodRoute.name,
         args: AppPaymentMethodRouteArgs(
           key: key,
           title: title,
           subtitle: subtitle,
           commonSelectableDto: commonSelectableDto,
           initialSelectedItem: initialSelectedItem,
           onSelected: onSelected,
         ),
         initialChildren: children,
       );

  static const String name = 'AppPaymentMethodRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppPaymentMethodRouteArgs>(
        orElse: () => const AppPaymentMethodRouteArgs(),
      );
      return _i1.AppPaymentMethodPage(
        key: args.key,
        title: args.title,
        subtitle: args.subtitle,
        commonSelectableDto: args.commonSelectableDto,
        initialSelectedItem: args.initialSelectedItem,
        onSelected: args.onSelected,
      );
    },
  );
}

class AppPaymentMethodRouteArgs {
  const AppPaymentMethodRouteArgs({
    this.key,
    this.title,
    this.subtitle,
    this.commonSelectableDto,
    this.initialSelectedItem,
    this.onSelected,
  });

  final _i41.Key? key;

  final String? title;

  final String? subtitle;

  final _i42.CommonSelectableDto? commonSelectableDto;

  final _i42.CommonSelectableItem? initialSelectedItem;

  final _i41.ValueChanged<_i42.CommonSelectableItem>? onSelected;

  @override
  String toString() {
    return 'AppPaymentMethodRouteArgs{key: $key, title: $title, subtitle: $subtitle, commonSelectableDto: $commonSelectableDto, initialSelectedItem: $initialSelectedItem, onSelected: $onSelected}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppPaymentMethodRouteArgs) return false;
    return key == other.key &&
        title == other.title &&
        subtitle == other.subtitle &&
        commonSelectableDto == other.commonSelectableDto &&
        initialSelectedItem == other.initialSelectedItem &&
        onSelected == other.onSelected;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      title.hashCode ^
      subtitle.hashCode ^
      commonSelectableDto.hashCode ^
      initialSelectedItem.hashCode ^
      onSelected.hashCode;
}

/// generated route for
/// [_i2.AppPaymentResultPage]
class AppPaymentResultRoute
    extends _i40.PageRouteInfo<AppPaymentResultRouteArgs> {
  AppPaymentResultRoute({
    _i41.Key? key,
    _i43.CommonPaymentResultDto? paymentResult,
    bool isPayAtBranch = false,
    String? validTimeLimit,
    _i44.BranchDto? selectedBranch,
    List<_i40.PageRouteInfo>? children,
  }) : super(
         AppPaymentResultRoute.name,
         args: AppPaymentResultRouteArgs(
           key: key,
           paymentResult: paymentResult,
           isPayAtBranch: isPayAtBranch,
           validTimeLimit: validTimeLimit,
           selectedBranch: selectedBranch,
         ),
         initialChildren: children,
       );

  static const String name = 'AppPaymentResultRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppPaymentResultRouteArgs>(
        orElse: () => const AppPaymentResultRouteArgs(),
      );
      return _i2.AppPaymentResultPage(
        key: args.key,
        paymentResult: args.paymentResult,
        isPayAtBranch: args.isPayAtBranch,
        validTimeLimit: args.validTimeLimit,
        selectedBranch: args.selectedBranch,
      );
    },
  );
}

class AppPaymentResultRouteArgs {
  const AppPaymentResultRouteArgs({
    this.key,
    this.paymentResult,
    this.isPayAtBranch = false,
    this.validTimeLimit,
    this.selectedBranch,
  });

  final _i41.Key? key;

  final _i43.CommonPaymentResultDto? paymentResult;

  final bool isPayAtBranch;

  final String? validTimeLimit;

  final _i44.BranchDto? selectedBranch;

  @override
  String toString() {
    return 'AppPaymentResultRouteArgs{key: $key, paymentResult: $paymentResult, isPayAtBranch: $isPayAtBranch, validTimeLimit: $validTimeLimit, selectedBranch: $selectedBranch}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppPaymentResultRouteArgs) return false;
    return key == other.key &&
        paymentResult == other.paymentResult &&
        isPayAtBranch == other.isPayAtBranch &&
        validTimeLimit == other.validTimeLimit &&
        selectedBranch == other.selectedBranch;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      paymentResult.hashCode ^
      isPayAtBranch.hashCode ^
      validTimeLimit.hashCode ^
      selectedBranch.hashCode;
}

/// generated route for
/// [_i3.AppSelectablePage]
class AppSelectableRoute extends _i40.PageRouteInfo<AppSelectableRouteArgs> {
  AppSelectableRoute({
    _i45.Key? key,
    bool isShowLeading = false,
    bool isShowTrailing = false,
    String? title,
    _i42.CommonSelectableDto? commonSelectableDto,
    _i45.ValueChanged<_i42.CommonSelectableItem>? onSelected,
    _i42.CommonSelectableItem? initialSelectedItem,
    List<_i40.PageRouteInfo>? children,
  }) : super(
         AppSelectableRoute.name,
         args: AppSelectableRouteArgs(
           key: key,
           isShowLeading: isShowLeading,
           isShowTrailing: isShowTrailing,
           title: title,
           commonSelectableDto: commonSelectableDto,
           onSelected: onSelected,
           initialSelectedItem: initialSelectedItem,
         ),
         initialChildren: children,
       );

  static const String name = 'AppSelectableRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppSelectableRouteArgs>(
        orElse: () => const AppSelectableRouteArgs(),
      );
      return _i3.AppSelectablePage(
        key: args.key,
        isShowLeading: args.isShowLeading,
        isShowTrailing: args.isShowTrailing,
        title: args.title,
        commonSelectableDto: args.commonSelectableDto,
        onSelected: args.onSelected,
        initialSelectedItem: args.initialSelectedItem,
      );
    },
  );
}

class AppSelectableRouteArgs {
  const AppSelectableRouteArgs({
    this.key,
    this.isShowLeading = false,
    this.isShowTrailing = false,
    this.title,
    this.commonSelectableDto,
    this.onSelected,
    this.initialSelectedItem,
  });

  final _i45.Key? key;

  final bool isShowLeading;

  final bool isShowTrailing;

  final String? title;

  final _i42.CommonSelectableDto? commonSelectableDto;

  final _i45.ValueChanged<_i42.CommonSelectableItem>? onSelected;

  final _i42.CommonSelectableItem? initialSelectedItem;

  @override
  String toString() {
    return 'AppSelectableRouteArgs{key: $key, isShowLeading: $isShowLeading, isShowTrailing: $isShowTrailing, title: $title, commonSelectableDto: $commonSelectableDto, onSelected: $onSelected, initialSelectedItem: $initialSelectedItem}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppSelectableRouteArgs) return false;
    return key == other.key &&
        isShowLeading == other.isShowLeading &&
        isShowTrailing == other.isShowTrailing &&
        title == other.title &&
        commonSelectableDto == other.commonSelectableDto &&
        onSelected == other.onSelected &&
        initialSelectedItem == other.initialSelectedItem;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      isShowLeading.hashCode ^
      isShowTrailing.hashCode ^
      title.hashCode ^
      commonSelectableDto.hashCode ^
      onSelected.hashCode ^
      initialSelectedItem.hashCode;
}

/// generated route for
/// [_i4.BeneficiaryAddForm]
class BeneficiaryAddForm extends _i40.PageRouteInfo<void> {
  const BeneficiaryAddForm({List<_i40.PageRouteInfo>? children})
    : super(BeneficiaryAddForm.name, initialChildren: children);

  static const String name = 'BeneficiaryAddForm';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i4.BeneficiaryAddForm();
    },
  );
}

/// generated route for
/// [_i5.BeneficiaryEditForm]
class BeneficiaryEditForm extends _i40.PageRouteInfo<void> {
  const BeneficiaryEditForm({List<_i40.PageRouteInfo>? children})
    : super(BeneficiaryEditForm.name, initialChildren: children);

  static const String name = 'BeneficiaryEditForm';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i5.BeneficiaryEditForm();
    },
  );
}

/// generated route for
/// [_i6.BeneficiaryOtpView]
class BeneficiaryOtpView extends _i40.PageRouteInfo<void> {
  const BeneficiaryOtpView({List<_i40.PageRouteInfo>? children})
    : super(BeneficiaryOtpView.name, initialChildren: children);

  static const String name = 'BeneficiaryOtpView';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i6.BeneficiaryOtpView();
    },
  );
}

/// generated route for
/// [_i7.BeneficiaryPage]
class BeneficiaryRoute extends _i40.PageRouteInfo<void> {
  const BeneficiaryRoute({List<_i40.PageRouteInfo>? children})
    : super(BeneficiaryRoute.name, initialChildren: children);

  static const String name = 'BeneficiaryRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i7.BeneficiaryPage();
    },
  );
}

/// generated route for
/// [_i8.BioMetricPage]
class BioMetricRoute extends _i40.PageRouteInfo<void> {
  const BioMetricRoute({List<_i40.PageRouteInfo>? children})
    : super(BioMetricRoute.name, initialChildren: children);

  static const String name = 'BioMetricRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i8.BioMetricPage();
    },
  );
}

/// generated route for
/// [_i9.BranchesPage]
class BranchesRoute extends _i40.PageRouteInfo<void> {
  const BranchesRoute({List<_i40.PageRouteInfo>? children})
    : super(BranchesRoute.name, initialChildren: children);

  static const String name = 'BranchesRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i9.BranchesPage();
    },
  );
}

/// generated route for
/// [_i10.ChangeCurrentMpinPage]
class ChangeCurrentMpinRoute extends _i40.PageRouteInfo<void> {
  const ChangeCurrentMpinRoute({List<_i40.PageRouteInfo>? children})
    : super(ChangeCurrentMpinRoute.name, initialChildren: children);

  static const String name = 'ChangeCurrentMpinRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i10.ChangeCurrentMpinPage();
    },
  );
}

/// generated route for
/// [_i11.ChangeNewMpinView]
class ChangeNewMpinView extends _i40.PageRouteInfo<void> {
  const ChangeNewMpinView({List<_i40.PageRouteInfo>? children})
    : super(ChangeNewMpinView.name, initialChildren: children);

  static const String name = 'ChangeNewMpinView';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i11.ChangeNewMpinView();
    },
  );
}

/// generated route for
/// [_i12.ChangeVerifyMpinView]
class ChangeVerifyMpinView extends _i40.PageRouteInfo<void> {
  const ChangeVerifyMpinView({List<_i40.PageRouteInfo>? children})
    : super(ChangeVerifyMpinView.name, initialChildren: children);

  static const String name = 'ChangeVerifyMpinView';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i12.ChangeVerifyMpinView();
    },
  );
}

/// generated route for
/// [_i13.CompanyInfoPage]
class CompanyInfoRoute extends _i40.PageRouteInfo<CompanyInfoRouteArgs> {
  CompanyInfoRoute({
    _i41.Key? key,
    required _i46.CompanyInfoType companyInfoType,
    List<_i40.PageRouteInfo>? children,
  }) : super(
         CompanyInfoRoute.name,
         args: CompanyInfoRouteArgs(key: key, companyInfoType: companyInfoType),
         initialChildren: children,
       );

  static const String name = 'CompanyInfoRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CompanyInfoRouteArgs>();
      return _i13.CompanyInfoPage(
        key: args.key,
        companyInfoType: args.companyInfoType,
      );
    },
  );
}

class CompanyInfoRouteArgs {
  const CompanyInfoRouteArgs({this.key, required this.companyInfoType});

  final _i41.Key? key;

  final _i46.CompanyInfoType companyInfoType;

  @override
  String toString() {
    return 'CompanyInfoRouteArgs{key: $key, companyInfoType: $companyInfoType}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CompanyInfoRouteArgs) return false;
    return key == other.key && companyInfoType == other.companyInfoType;
  }

  @override
  int get hashCode => key.hashCode ^ companyInfoType.hashCode;
}

/// generated route for
/// [_i14.CompleteProfilePage]
class CompleteProfileRoute extends _i40.PageRouteInfo<void> {
  const CompleteProfileRoute({List<_i40.PageRouteInfo>? children})
    : super(CompleteProfileRoute.name, initialChildren: children);

  static const String name = 'CompleteProfileRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i14.CompleteProfilePage();
    },
  );
}

/// generated route for
/// [_i15.ForgotMpinPage]
class ForgotMpinRoute extends _i40.PageRouteInfo<void> {
  const ForgotMpinRoute({List<_i40.PageRouteInfo>? children})
    : super(ForgotMpinRoute.name, initialChildren: children);

  static const String name = 'ForgotMpinRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i15.ForgotMpinPage();
    },
  );
}

/// generated route for
/// [_i16.ForgotOtpView]
class ForgotOtpView extends _i40.PageRouteInfo<void> {
  const ForgotOtpView({List<_i40.PageRouteInfo>? children})
    : super(ForgotOtpView.name, initialChildren: children);

  static const String name = 'ForgotOtpView';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i16.ForgotOtpView();
    },
  );
}

/// generated route for
/// [_i17.HomeBeneficiaryView]
class HomeBeneficiaryView extends _i40.PageRouteInfo<void> {
  const HomeBeneficiaryView({List<_i40.PageRouteInfo>? children})
    : super(HomeBeneficiaryView.name, initialChildren: children);

  static const String name = 'HomeBeneficiaryView';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i17.HomeBeneficiaryView();
    },
  );
}

/// generated route for
/// [_i18.HomeEmailOtpView]
class HomeEmailOtpView extends _i40.PageRouteInfo<void> {
  const HomeEmailOtpView({List<_i40.PageRouteInfo>? children})
    : super(HomeEmailOtpView.name, initialChildren: children);

  static const String name = 'HomeEmailOtpView';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i18.HomeEmailOtpView();
    },
  );
}

/// generated route for
/// [_i19.HomeEmailView]
class HomeEmailView extends _i40.PageRouteInfo<HomeEmailViewArgs> {
  HomeEmailView({
    _i41.Key? key,
    String? email,
    List<_i40.PageRouteInfo>? children,
  }) : super(
         HomeEmailView.name,
         args: HomeEmailViewArgs(key: key, email: email),
         initialChildren: children,
       );

  static const String name = 'HomeEmailView';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeEmailViewArgs>(
        orElse: () => const HomeEmailViewArgs(),
      );
      return _i19.HomeEmailView(key: args.key, email: args.email);
    },
  );
}

class HomeEmailViewArgs {
  const HomeEmailViewArgs({this.key, this.email});

  final _i41.Key? key;

  final String? email;

  @override
  String toString() {
    return 'HomeEmailViewArgs{key: $key, email: $email}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HomeEmailViewArgs) return false;
    return key == other.key && email == other.email;
  }

  @override
  int get hashCode => key.hashCode ^ email.hashCode;
}

/// generated route for
/// [_i20.LoginContactUsView]
class LoginContactUsView extends _i40.PageRouteInfo<void> {
  const LoginContactUsView({List<_i40.PageRouteInfo>? children})
    : super(LoginContactUsView.name, initialChildren: children);

  static const String name = 'LoginContactUsView';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i20.LoginContactUsView();
    },
  );
}

/// generated route for
/// [_i21.LoginPage]
class LoginRoute extends _i40.PageRouteInfo<void> {
  const LoginRoute({List<_i40.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i21.LoginPage();
    },
  );
}

/// generated route for
/// [_i22.MainPage]
class MainRoute extends _i40.PageRouteInfo<void> {
  const MainRoute({List<_i40.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i22.MainPage();
    },
  );
}

/// generated route for
/// [_i23.MemberApprovalPage]
class MemberApprovalRoute extends _i40.PageRouteInfo<void> {
  const MemberApprovalRoute({List<_i40.PageRouteInfo>? children})
    : super(MemberApprovalRoute.name, initialChildren: children);

  static const String name = 'MemberApprovalRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i23.MemberApprovalPage();
    },
  );
}

/// generated route for
/// [_i24.MpinPage]
class MpinRoute extends _i40.PageRouteInfo<MpinRouteArgs> {
  MpinRoute({
    _i41.Key? key,
    bool autoPromptBiometric = false,
    List<_i40.PageRouteInfo>? children,
  }) : super(
         MpinRoute.name,
         args: MpinRouteArgs(
           key: key,
           autoPromptBiometric: autoPromptBiometric,
         ),
         initialChildren: children,
       );

  static const String name = 'MpinRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MpinRouteArgs>(
        orElse: () => const MpinRouteArgs(),
      );
      return _i24.MpinPage(
        key: args.key,
        autoPromptBiometric: args.autoPromptBiometric,
      );
    },
  );
}

class MpinRouteArgs {
  const MpinRouteArgs({this.key, this.autoPromptBiometric = false});

  final _i41.Key? key;

  final bool autoPromptBiometric;

  @override
  String toString() {
    return 'MpinRouteArgs{key: $key, autoPromptBiometric: $autoPromptBiometric}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MpinRouteArgs) return false;
    return key == other.key && autoPromptBiometric == other.autoPromptBiometric;
  }

  @override
  int get hashCode => key.hashCode ^ autoPromptBiometric.hashCode;
}

/// generated route for
/// [_i25.NotificationDetailView]
class NotificationDetailView
    extends _i40.PageRouteInfo<NotificationDetailViewArgs> {
  NotificationDetailView({
    _i41.Key? key,
    _i47.NotificationList? notification,
    List<_i40.PageRouteInfo>? children,
  }) : super(
         NotificationDetailView.name,
         args: NotificationDetailViewArgs(key: key, notification: notification),
         initialChildren: children,
       );

  static const String name = 'NotificationDetailView';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotificationDetailViewArgs>(
        orElse: () => const NotificationDetailViewArgs(),
      );
      return _i25.NotificationDetailView(
        key: args.key,
        notification: args.notification,
      );
    },
  );
}

class NotificationDetailViewArgs {
  const NotificationDetailViewArgs({this.key, this.notification});

  final _i41.Key? key;

  final _i47.NotificationList? notification;

  @override
  String toString() {
    return 'NotificationDetailViewArgs{key: $key, notification: $notification}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NotificationDetailViewArgs) return false;
    return key == other.key && notification == other.notification;
  }

  @override
  int get hashCode => key.hashCode ^ notification.hashCode;
}

/// generated route for
/// [_i26.NotificationPage]
class NotificationRoute extends _i40.PageRouteInfo<void> {
  const NotificationRoute({List<_i40.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i26.NotificationPage();
    },
  );
}

/// generated route for
/// [_i27.OnBoardingPage]
class OnBoardingRoute extends _i40.PageRouteInfo<void> {
  const OnBoardingRoute({List<_i40.PageRouteInfo>? children})
    : super(OnBoardingRoute.name, initialChildren: children);

  static const String name = 'OnBoardingRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i27.OnBoardingPage();
    },
  );
}

/// generated route for
/// [_i28.OtpPage]
class OtpRoute extends _i40.PageRouteInfo<void> {
  const OtpRoute({List<_i40.PageRouteInfo>? children})
    : super(OtpRoute.name, initialChildren: children);

  static const String name = 'OtpRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i28.OtpPage();
    },
  );
}

/// generated route for
/// [_i29.ProfileEmailOtpView]
class ProfileEmailOtpView extends _i40.PageRouteInfo<void> {
  const ProfileEmailOtpView({List<_i40.PageRouteInfo>? children})
    : super(ProfileEmailOtpView.name, initialChildren: children);

  static const String name = 'ProfileEmailOtpView';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i29.ProfileEmailOtpView();
    },
  );
}

/// generated route for
/// [_i30.ProfileEmailView]
class ProfileEmailView extends _i40.PageRouteInfo<void> {
  const ProfileEmailView({List<_i40.PageRouteInfo>? children})
    : super(ProfileEmailView.name, initialChildren: children);

  static const String name = 'ProfileEmailView';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i30.ProfileEmailView();
    },
  );
}

/// generated route for
/// [_i31.ProfilePage]
class ProfileRoute extends _i40.PageRouteInfo<void> {
  const ProfileRoute({List<_i40.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i31.ProfilePage();
    },
  );
}

/// generated route for
/// [_i32.RateCalculatorPage]
class RateCalculatorRoute extends _i40.PageRouteInfo<void> {
  const RateCalculatorRoute({List<_i40.PageRouteInfo>? children})
    : super(RateCalculatorRoute.name, initialChildren: children);

  static const String name = 'RateCalculatorRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i32.RateCalculatorPage();
    },
  );
}

/// generated route for
/// [_i33.SetMpinPage]
class SetMpinRoute extends _i40.PageRouteInfo<void> {
  const SetMpinRoute({List<_i40.PageRouteInfo>? children})
    : super(SetMpinRoute.name, initialChildren: children);

  static const String name = 'SetMpinRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i33.SetMpinPage();
    },
  );
}

/// generated route for
/// [_i34.SetVerifyMpinView]
class SetVerifyMpinView extends _i40.PageRouteInfo<void> {
  const SetVerifyMpinView({List<_i40.PageRouteInfo>? children})
    : super(SetVerifyMpinView.name, initialChildren: children);

  static const String name = 'SetVerifyMpinView';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i34.SetVerifyMpinView();
    },
  );
}

/// generated route for
/// [_i35.SplashPage]
class SplashRoute extends _i40.PageRouteInfo<void> {
  const SplashRoute({List<_i40.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i35.SplashPage();
    },
  );
}

/// generated route for
/// [_i36.SummaryPage]
class SummaryRoute extends _i40.PageRouteInfo<void> {
  const SummaryRoute({List<_i40.PageRouteInfo>? children})
    : super(SummaryRoute.name, initialChildren: children);

  static const String name = 'SummaryRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i36.SummaryPage();
    },
  );
}

/// generated route for
/// [_i37.SupportPage]
class SupportRoute extends _i40.PageRouteInfo<void> {
  const SupportRoute({List<_i40.PageRouteInfo>? children})
    : super(SupportRoute.name, initialChildren: children);

  static const String name = 'SupportRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i37.SupportPage();
    },
  );
}

/// generated route for
/// [_i38.TransactionHistoryPage]
class TransactionHistoryRoute extends _i40.PageRouteInfo<void> {
  const TransactionHistoryRoute({List<_i40.PageRouteInfo>? children})
    : super(TransactionHistoryRoute.name, initialChildren: children);

  static const String name = 'TransactionHistoryRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i38.TransactionHistoryPage();
    },
  );
}

/// generated route for
/// [_i39.UpdateKycPage]
class UpdateKycRoute extends _i40.PageRouteInfo<void> {
  const UpdateKycRoute({List<_i40.PageRouteInfo>? children})
    : super(UpdateKycRoute.name, initialChildren: children);

  static const String name = 'UpdateKycRoute';

  static _i40.PageInfo page = _i40.PageInfo(
    name,
    builder: (data) {
      return const _i39.UpdateKycPage();
    },
  );
}
