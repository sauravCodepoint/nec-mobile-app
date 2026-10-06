/// Canonical keys for the dynamic beneficiary form fields.
///
/// Backend `field_name` values are inconsistent across products:
/// `beneficiaryNationalityCode`, `gender_list`, `residency type` (with a
/// space), and the `beneficaryrelation` typo all occur. [normalize] collapses
/// every variant to one convention — lowercase with spaces and underscores
/// stripped — and the constants below are the normalized keys the app matches
/// against. Combo option lists in [BeneficiaryState.comboLists] are keyed by
/// these same values.
class BeneficiaryFieldKeys {
  const BeneficiaryFieldKeys._();

  static String normalize(String? raw) =>
      (raw ?? '').toLowerCase().replaceAll(RegExp(r'[\s_]'), '');

  static const nationality = 'beneficiarynationalitycode';
  static const mobile = 'beneficiarymobile';
  static const gender = 'genderlist';
  static const profession = 'profession';

  /// Backend typo ("beneficary") — kept verbatim to match the wire value.
  static const relation = 'beneficaryrelation';
  static const residencyType = 'residencytype';
  static const salutation = 'salutation';
  static const airport = 'airport';
  static const accountType = 'accounttype';
  static const memberCategory = 'membercategory';
  static const routeType = 'routetype';
  static const bankCode = 'beneficiarybankcode';
  static const branchCode = 'beneficiarybranchcode';
  static const routeCode = 'routecode';
  static const idType = 'beneficiaryidtypecode';
}
