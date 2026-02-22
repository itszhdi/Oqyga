import 'package:oqyga_frontend/features/cards/domain/entities/card_entity.dart';

abstract class CardRepository {
  Future<List<CardEntity>> getMyCards();
  Future<CardEntity> addCard({
    required String cardNumber,
    required int expMonth,
    required int expYear,
    required String cvc,
  });
  Future<void> deleteCard(int cardId);
}
