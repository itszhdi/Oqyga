import 'package:oqyga_frontend/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/features/cards/data/datasources/card_remote_data_source.dart';
import 'package:oqyga_frontend/features/cards/domain/entities/card_entity.dart';
import 'package:oqyga_frontend/features/cards/domain/repositories/i_card_repository.dart';

class CardRepositoryImpl implements CardRepository {
  final CardRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  CardRepositoryImpl({
    required this.remoteDataSource,
    required this.authLocalDataSource,
  });

  Future<int> _getUserId() async {
    final userId = await authLocalDataSource.getUserId();
    if (userId == null) {
      throw ApiException(message: 'unexpectedError', statusCode: 401);
    }
    return userId;
  }

  @override
  Future<List<CardEntity>> getMyCards() async {
    final userId = await _getUserId();
    return await remoteDataSource.fetchUserCards(userId);
  }

  @override
  Future<CardEntity> addCard({
    required String cardNumber,
    required int expMonth,
    required int expYear,
    required String cvc,
  }) async {
    final userId = await _getUserId();

    final paymentMethodId = await remoteDataSource.createStripePaymentMethod(
      number: cardNumber,
      expMonth: expMonth,
      expYear: expYear,
      cvc: cvc,
    );

    return await remoteDataSource.sendTokenToBackend(paymentMethodId, userId);
  }

  @override
  Future<void> deleteCard(int cardId) async {
    final userId = await _getUserId();
    await remoteDataSource.deleteCard(cardId, userId);
  }
}
