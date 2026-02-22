import 'package:oqyga_frontend/features/cards/domain/entities/card_entity.dart';
import 'package:oqyga_frontend/features/cards/domain/repositories/i_card_repository.dart';

class GetMyCards {
  final CardRepository repository;

  GetMyCards(this.repository);

  Future<List<CardEntity>> call() async {
    return await repository.getMyCards();
  }
}
