part of 'ticket_purchase_bloc.dart';

abstract class TicketPurchaseEvent extends Equatable {
  const TicketPurchaseEvent();
  @override
  List<Object?> get props => []; 
}

class PurchaseFlowStarted extends TicketPurchaseEvent {
  final Event event;
  const PurchaseFlowStarted(this.event);
  @override
  List<Object?> get props => [event];
}

class SeatToggled extends TicketPurchaseEvent {
  final int row;
  final int number;
  const SeatToggled({required this.row, required this.number});
  @override
  List<Object?> get props => [row, number];
}

class PromocodeSubmitted extends TicketPurchaseEvent {
  final String code;
  const PromocodeSubmitted(this.code);
  @override
  List<Object?> get props => [code];
}

// ОБНОВЛЕННОЕ СОБЫТИЕ
class PurchaseSubmitted extends TicketPurchaseEvent {
  final int? savedCardId;
  final String? newPaymentMethodId;
  final bool saveNewCard;

  const PurchaseSubmitted({
    this.savedCardId,
    this.newPaymentMethodId,
    this.saveNewCard = false,
  });

  @override
  List<Object?> get props => [savedCardId, newPaymentMethodId, saveNewCard];
}
