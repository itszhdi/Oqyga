import 'package:oqyga_frontend/features/cards/domain/entities/card_entity.dart';

class CardModel extends CardEntity {
  const CardModel({
    required super.id,
    required super.lastFourDigits,
    required super.brand,
    super.message,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as int? ?? 0,
      lastFourDigits: json['lastFourDigits'] as String? ?? '****',
      brand: json['brand'] as String? ?? 'unknown',
      message: json['message'] as String? ?? '',
    );
  }
}
