import 'package:oqyga_frontend/features/cards/domain/entities/card_entity.dart';
import 'package:oqyga_frontend/features/cards/domain/repositories/i_card_repository.dart';

class AddCard {
  final CardRepository repository;

  AddCard(this.repository);

  Future<CardEntity> call({
    required String cardNumber,
    required int expMonth,
    required int expYear,
    required String cvc,
  }) async {
    return await repository.addCard(
      cardNumber: cardNumber,
      expMonth: expMonth,
      expYear: expYear,
      cvc: cvc,
    );
  }
}
