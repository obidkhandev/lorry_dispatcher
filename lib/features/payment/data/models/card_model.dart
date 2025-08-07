import 'dart:ui';

class CreditCard {
  final String id;
  final String holderName;
  final String cardNumber;
  final String bankLogo;
  final Color cardColor;
  final bool isPrimary;
  final bool isActive;

  CreditCard({
    required this.id,
    required this.holderName,
    required this.cardNumber,
    required this.bankLogo,
    required this.cardColor,
    this.isPrimary = false,
    this.isActive = true,
  });

  CreditCard copyWith({
    String? id,
    String? holderName,
    String? cardNumber,
    String? bankLogo,
    Color? cardColor,
    bool? isPrimary,
    bool? isActive,
  }) {
    return CreditCard(
      id: id ?? this.id,
      holderName: holderName ?? this.holderName,
      cardNumber: cardNumber ?? this.cardNumber,
      bankLogo: bankLogo ?? this.bankLogo,
      cardColor: cardColor ?? this.cardColor,
      isPrimary: isPrimary ?? this.isPrimary,
      isActive: isActive ?? this.isActive,
    );
  }
}