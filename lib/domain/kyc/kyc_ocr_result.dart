class KycOcrResult {
  final String? idNumber;
  final String? dateOfBirth;
  final String? issueDate;
  final String? expiryDate;
  final String? cardType;

  const KycOcrResult({
    this.idNumber,
    this.dateOfBirth,
    this.issueDate,
    this.expiryDate,
    this.cardType,
  });

  bool get hasAnyData =>
      idNumber != null ||
      dateOfBirth != null ||
      issueDate != null ||
      expiryDate != null ||
      cardType != null;

  KycOcrResult copyWith({
    String? idNumber,
    String? dateOfBirth,
    String? issueDate,
    String? expiryDate,
    String? cardType,
  }) =>
      KycOcrResult(
        idNumber: idNumber ?? this.idNumber,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        issueDate: issueDate ?? this.issueDate,
        expiryDate: expiryDate ?? this.expiryDate,
        cardType: cardType ?? this.cardType,
      );
}