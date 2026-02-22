part of 'card_bloc.dart';

abstract class CardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardLoaded extends CardState {
  final List<CardEntity> cards;
  CardLoaded(this.cards);
  @override
  List<Object?> get props => [cards];
}

class CardOneTimePaymentReady extends CardState {
  final String paymentMethodId;
  CardOneTimePaymentReady(this.paymentMethodId);
  @override
  List<Object?> get props => [paymentMethodId];
}

class CardOperationSuccess extends CardState {
  final String message;
  CardOperationSuccess(this.message);
}

class CardFailure extends CardState {
  final String error;
  CardFailure(this.error);
  @override
  List<Object?> get props => [error];
}
