part of 'ticket_purchase_bloc.dart';

enum TicketPurchaseStatus { initial, selecting, processing, success, failure }

class TicketPurchaseState extends Equatable {
  final TicketPurchaseStatus status;
  final Event? event;
  final List<EventTicketType> sortedTicketTypes;

  final List<List<Seat>> seatingMap;
  final List<Seat> selectedSeats;
  final double totalPrice;
  final List<int> purchasedTicketIds;
  final String errorMessage;

  final String appliedPromocode;
  final double discountAmount;
  final bool isPromocodeLoading;

  const TicketPurchaseState({
    this.status = TicketPurchaseStatus.initial,
    this.event,
    this.sortedTicketTypes = const [],
    this.seatingMap = const [],
    this.selectedSeats = const [],
    this.totalPrice = 0,
    this.purchasedTicketIds = const [],
    this.errorMessage = '',
    this.appliedPromocode = '',
    this.discountAmount = 0.0,
    this.isPromocodeLoading = false,
  });

  TicketPurchaseState copyWith({
    TicketPurchaseStatus? status,
    Event? event,
    List<EventTicketType>? sortedTicketTypes,
    List<List<Seat>>? seatingMap,
    List<Seat>? selectedSeats,
    double? totalPrice,
    List<int>? purchasedTicketIds,
    String? errorMessage,
    // Параметры для copyWith
    String? appliedPromocode,
    double? discountAmount,
    bool? isPromocodeLoading,
  }) {
    return TicketPurchaseState(
      status: status ?? this.status,
      event: event ?? this.event,
      sortedTicketTypes: sortedTicketTypes ?? this.sortedTicketTypes,
      seatingMap: seatingMap ?? this.seatingMap,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      totalPrice: totalPrice ?? this.totalPrice,
      purchasedTicketIds: purchasedTicketIds ?? this.purchasedTicketIds,
      errorMessage: errorMessage ?? this.errorMessage,
      appliedPromocode: appliedPromocode ?? this.appliedPromocode,
      discountAmount: discountAmount ?? this.discountAmount,
      isPromocodeLoading: isPromocodeLoading ?? this.isPromocodeLoading,
    );
  }

  @override
  List<Object?> get props => [
    status,
    event,
    sortedTicketTypes,
    seatingMap,
    selectedSeats,
    totalPrice,
    purchasedTicketIds,
    errorMessage,
    appliedPromocode,
    discountAmount,
    isPromocodeLoading,
  ];
}
