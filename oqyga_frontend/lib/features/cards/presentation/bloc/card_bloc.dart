import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:oqyga_frontend/features/cards/data/datasources/card_remote_data_source.dart';
import 'package:oqyga_frontend/features/cards/domain/entities/card_entity.dart';
import 'package:oqyga_frontend/features/cards/domain/usecases/add_card.dart';
import 'package:oqyga_frontend/features/cards/domain/usecases/delete_card.dart';
import 'package:oqyga_frontend/features/cards/domain/usecases/get_my_cards.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final GetMyCards getMyCards;
  final AddCard addCard;
  final DeleteCard deleteCardUseCase;
  final CardRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  CardBloc({
    required this.getMyCards,
    required this.addCard,
    required this.deleteCardUseCase,
    required this.remoteDataSource,
    required this.authLocalDataSource,
  }) : super(CardInitial()) {
    on<LoadMyCardsEvent>(_onLoadMyCards);
    on<AddNewCardEvent>(_onAddNewCard);
    on<DeleteCardEvent>(_onDeleteCard);
  }

  Future<void> _onLoadMyCards(
    LoadMyCardsEvent event,
    Emitter<CardState> emit,
  ) async {
    if (state is! CardLoaded) emit(CardLoading());
    try {
      final cards = await getMyCards();
      emit(CardLoaded(cards));
    } catch (e) {
      emit(CardFailure(_cleanError(e)));
    }
  }

  Future<void> _onDeleteCard(
    DeleteCardEvent event,
    Emitter<CardState> emit,
  ) async {
    final prevState = state;
    emit(CardLoading());
    try {
      await deleteCardUseCase(event.cardId);
      emit(CardOperationSuccess("cardDeletedSuccess"));
      add(LoadMyCardsEvent());
    } catch (e) {
      emit(CardFailure(_cleanError(e)));
      if (prevState is CardLoaded) emit(prevState);
    }
  }

  Future<void> _onAddNewCard(
    AddNewCardEvent event,
    Emitter<CardState> emit,
  ) async {
    List<CardEntity> currentCards = [];
    if (state is CardLoaded) {
      currentCards = List.from((state as CardLoaded).cards);
    }

    emit(CardLoading());

    try {
      final parts = event.expiryDate.split('/');
      if (parts.length != 2) throw Exception("invalidDateFormat");
      final int month = int.parse(parts[0]);
      final int year = int.parse('20${parts[1]}');
      final cleanNumber = event.cardNumber.replaceAll(' ', '');

      final userId = await _getUserIdHelper();

      final paymentMethodId = await remoteDataSource.createStripePaymentMethod(
        number: cleanNumber,
        expMonth: month,
        expYear: year,
        cvc: event.cvc,
      );

      if (event.saveToVault) {
        final newCard = await remoteDataSource.sendTokenToBackend(
          paymentMethodId,
          userId,
        );

        emit(CardOperationSuccess("cardAddedSuccess"));
        currentCards.add(newCard);
        emit(CardLoaded(currentCards));
        add(LoadMyCardsEvent());
      } else {
        emit(CardOneTimePaymentReady(paymentMethodId));
        if (currentCards.isNotEmpty) emit(CardLoaded(currentCards));
      }
    } catch (e) {
      emit(CardFailure(_cleanError(e)));
      if (currentCards.isNotEmpty) emit(CardLoaded(currentCards));
    }
  }

  String _cleanError(Object e) => e.toString().replaceAll('Exception: ', '');

  Future<int> _getUserIdHelper() async {
    final userId = await authLocalDataSource.getUserId();
    if (userId == null) {
      throw Exception("userNotAuthenticated");
    }
    return userId;
  }
}
