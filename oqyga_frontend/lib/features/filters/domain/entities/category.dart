import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int categoryId;
  final String categoryName;

  const Category({required this.categoryId, required this.categoryName});

  @override
  List<Object> get props => [categoryId, categoryName];
}
