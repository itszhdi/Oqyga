import 'package:oqyga_frontend/features/tickets/domain/entities/ticket_purchase_request.dart';

class TicketPurchaseRequestModel extends TicketPurchaseRequest {
  const TicketPurchaseRequestModel({
    required super.eventId,
    required super.userId,
    required super.seats,
    super.promocode,
    super.savedCardId,
    super.newPaymentMethodId,
    super.saveNewCard,
  });

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'userId': userId,
      'promocode': promocode,
      'savedCardId': savedCardId,
      'newPaymentMethodId': newPaymentMethodId,
      'saveNewCard': saveNewCard,
      'seats': seats
          .map(
            (seat) => PurchaseSeatRequestModel(
              ticketTypeId: seat.ticketTypeId,
              row: seat.row,
              number: seat.number,
            ).toJson(),
          )
          .toList(),
    };
  }
}

class PurchaseSeatRequestModel extends PurchaseSeatRequest {
  const PurchaseSeatRequestModel({
    required super.ticketTypeId,
    required super.row,
    required super.number,
  });

  Map<String, dynamic> toJson() {
    return {'ticketTypeId': ticketTypeId, 'row': row, 'number': number};
  }
}
