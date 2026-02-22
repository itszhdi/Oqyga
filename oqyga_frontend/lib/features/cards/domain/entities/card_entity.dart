import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final int id;
  final String lastFourDigits;
  final String brand;
  final String message;

  const CardEntity({
    required this.id,
    required this.lastFourDigits,
    required this.brand,
    this.message = '',
  });

  @override
  List<Object?> get props => [id, lastFourDigits, brand, message];
}
