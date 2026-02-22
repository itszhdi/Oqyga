class TicketPurchaseRequest {
  final int eventId;
  final int userId;
  final List<PurchaseSeatRequest> seats;
  final String? promocode;
  final int? savedCardId;
  final String? newPaymentMethodId;
  final bool? saveNewCard;

  const TicketPurchaseRequest({
    required this.eventId,
    required this.userId,
    required this.seats,
    this.promocode,
    this.savedCardId,
    this.newPaymentMethodId,
    this.saveNewCard,
  });
}

class PurchaseSeatRequest {
  final int ticketTypeId;
  final int row;
  final int number;

  const PurchaseSeatRequest({
    required this.ticketTypeId,
    required this.row,
    required this.number,
  });
}
