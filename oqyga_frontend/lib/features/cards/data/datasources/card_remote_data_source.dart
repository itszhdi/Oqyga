import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:oqyga_frontend/core/api/api_client.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/features/cards/data/models/card_model.dart';

abstract class CardRemoteDataSource {
  Future<List<CardModel>> fetchUserCards(int userId);
  Future<String> createStripePaymentMethod({
    required String number,
    required int expMonth,
    required int expYear,
    required String cvc,
  });
  Future<CardModel> sendTokenToBackend(String paymentMethodId, int userId);
  Future<void> deleteCard(int cardId, int userId);
}

class CardRemoteDataSourceImpl implements CardRemoteDataSource {
  final ApiClient apiClient;

  CardRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<CardModel>> fetchUserCards(int userId) async {
    final response = await apiClient.get('/cards/user/$userId');

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      return body.map((json) => CardModel.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw ApiException(
        message: 'failedToGetCards',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<String> createStripePaymentMethod({
    required String number,
    required int expMonth,
    required int expYear,
    required String cvc,
  }) async {
    try {
      final cardDetails = CardDetails(
        number: number,
        cvc: cvc,
        expirationMonth: expMonth,
        expirationYear: expYear,
      );

      await Stripe.instance.dangerouslyUpdateCardDetails(cardDetails);

      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(),
          ),
        ),
      );

      return paymentMethod.id;
    } catch (e) {
      throw ApiException(
        message: 'failedToCreatePaymentMethod',
        statusCode: 500,
      );
    }
  }

  @override
  Future<CardModel> sendTokenToBackend(
    String paymentMethodId,
    int userId,
  ) async {
    final response = await apiClient.post(
      '/cards/add',
      body: jsonEncode({'paymentMethodId': paymentMethodId, 'userId': userId}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      return CardModel.fromJson(body);
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<void> deleteCard(int cardId, int userId) async {
    final response = await apiClient.delete(
      '/cards/delete/$cardId',
      queryParams: {'userId': userId.toString()},
    );

    if (response.statusCode != 200) {
      throw ApiException(
        message: 'failedToDeleteCard',
        statusCode: response.statusCode,
      );
    }
  }
}
