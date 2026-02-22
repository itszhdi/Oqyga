part of 'card_bloc.dart';

// --- Events ---
abstract class CardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMyCardsEvent extends CardEvent {}

class AddNewCardEvent extends CardEvent {
  final String cardNumber;
  final String expiryDate;
  final String cvc;
  final bool saveToVault;

  AddNewCardEvent({
    required this.cardNumber,
    required this.expiryDate,
    required this.cvc,
    this.saveToVault = true,
  });
}

class DeleteCardEvent extends CardEvent {
  final int cardId;
  DeleteCardEvent(this.cardId);
}
