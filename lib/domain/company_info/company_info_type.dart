// Verify these queryValue strings match what the /Auth/print-policy API expects.
enum CompanyInfoType {
  aboutUs,
  privacyPolicy,
  termsAndConditions;

  String get queryValue => switch (this) {
        CompanyInfoType.aboutUs => 'About Us',
        CompanyInfoType.privacyPolicy => 'Privacy Policy',
        CompanyInfoType.termsAndConditions => 'T&C',
      };

  String get titleKey => switch (this) {
        CompanyInfoType.aboutUs => 'settings.aboutUs.title',
        CompanyInfoType.privacyPolicy => 'settings.privacyPolicy.title',
        CompanyInfoType.termsAndConditions => 'settings.termsAndConditions.title',
      };
}