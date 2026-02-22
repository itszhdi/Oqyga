import 'package:oqyga_frontend/features/cards/domain/repositories/i_card_repository.dart';

class DeleteCard {
  final CardRepository repository;
  DeleteCard(this.repository);

  Future<void> call(int cardId) async {
    return await repository.deleteCard(cardId);
  }
}
