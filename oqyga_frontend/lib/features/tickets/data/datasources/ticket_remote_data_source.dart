import 'dart:convert';
import 'dart:typed_data';
import 'package:oqyga_frontend/core/api/api_client.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/features/tickets/data/models/my_ticket_model.dart';
import 'package:oqyga_frontend/features/tickets/data/models/purchased_ticket_model.dart';
import 'package:oqyga_frontend/features/tickets/data/models/ticket_details_model.dart';
import 'package:oqyga_frontend/features/tickets/data/models/ticket_purchase_request_model.dart';

abstract class TicketRemoteDataSource {
  Future<List<MyTicketModel>> getMyTickets({
    Map<String, String>? queryParams,
    required String languageCode,
  });
  Future<TicketDetailsModel> getTicketDetails(
    int ticketId,
    String languageCode,
  );
  Future<Uint8List> getTicketQrCode(int ticketId);
  Future<double> validatePromocode(String code);
  Future<PurchasedTicketModel> purchaseTickets(
    TicketPurchaseRequestModel request,
  );
}

class TicketRemoteDataSourceImpl implements TicketRemoteDataSource {
  final ApiClient apiClient;
  static const _purchasePath = "/tickets/purchase";
  static const _detailsPath = "/tickets/details";
  static const _qrCodePath = "/tickets/qr-code";
  static const _myTicketsPath = "/tickets/my-tickets";

  TicketRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<double> validatePromocode(String code) async {
    final response = await apiClient.get(
      '/tickets/promocode/validate',
      queryParams: {'code': code},
    );
    if (response.statusCode == 200) {
      return double.parse(response.body);
    } else {
      throw ApiException(
        message: "invalidPromocode",
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<List<MyTicketModel>> getMyTickets({
    Map<String, String>? queryParams,
    required String languageCode,
  }) async {
    final response = await apiClient.get(
      _myTicketsPath,
      queryParams: queryParams,
      headers: {'Accept-Language': languageCode},
    );

    if (response.statusCode == 200) {
      final jsonBody = utf8.decode(response.bodyBytes);
      final List<dynamic> jsonList = jsonDecode(jsonBody);
      return jsonList.map((json) => MyTicketModel.fromJson(json)).toList();
    } else {
      throw ApiException(
        message: "errorLoadingTickets",
        statusCode: response.statusCode,
      );
    }
  }

  @override
  @override
  Future<TicketDetailsModel> getTicketDetails(
    int ticketId,
    String languageCode,
  ) async {
    final response = await apiClient.get(
      _detailsPath,
      queryParams: {'ticketId': ticketId.toString()},
      headers: {'Accept-Language': languageCode},
    );
    if (response.statusCode == 200) {
      final jsonBody = utf8.decode(response.bodyBytes);
      return TicketDetailsModel.fromJson(jsonDecode(jsonBody));
    } else {
      throw ApiException(
        message: "errorLoadingTicketDetails",
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<Uint8List> getTicketQrCode(int ticketId) async {
    final response = await apiClient.get(
      _qrCodePath,
      queryParams: {'ticketId': ticketId.toString()},
    );
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw ApiException(
        message: "errorLoadingQrCode",
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<PurchasedTicketModel> purchaseTickets(
    TicketPurchaseRequestModel request,
  ) async {
    final response = await apiClient.post(
      _purchasePath,
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 201) {
      final jsonBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonMap = jsonDecode(jsonBody);
      return PurchasedTicketModel.fromJson(jsonMap);
    } else {
      final errorBody = jsonDecode(response.body);
      throw ApiException(
        message: errorBody['message'] ?? "errorPurchasingTicket",
        statusCode: response.statusCode,
      );
    }
  }
}
