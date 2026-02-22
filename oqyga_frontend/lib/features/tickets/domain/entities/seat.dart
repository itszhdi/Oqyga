import 'package:equatable/equatable.dart';

class Seat extends Equatable {
  final int row;
  final int number;
  final int priceIndex;
  final int price;
  final bool isBooked;
  final bool isVip;
  final bool isSelected;

  const Seat({
    required this.row,
    required this.number,
    required this.priceIndex,
    required this.price,
    this.isBooked = false,
    this.isVip = false,
    this.isSelected = false,
  });

  Seat copyWith({bool? isSelected}) {
    return Seat(
      row: row,
      number: number,
      priceIndex: priceIndex,
      price: price,
      isBooked: isBooked,
      isVip: isVip,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [row, number, isSelected];
}
