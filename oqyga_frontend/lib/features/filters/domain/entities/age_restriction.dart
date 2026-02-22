import 'package:equatable/equatable.dart';

class AgeRestriction extends Equatable {
  final int ageId;
  final String ageCategory;

  const AgeRestriction({required this.ageId, required this.ageCategory});

  @override
  List<Object> get props => [ageId, ageCategory];
}
