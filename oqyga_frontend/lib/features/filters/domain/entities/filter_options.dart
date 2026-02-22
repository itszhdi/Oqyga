import 'package:equatable/equatable.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/city.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/category.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/age_restriction.dart';

class FilterOptions extends Equatable {
  final List<City> cities;
  final List<Category> categories;
  final List<AgeRestriction> ageRatings;
  final List<String> organizerVenues;

  const FilterOptions({
    required this.cities,
    required this.categories,
    required this.ageRatings,
    this.organizerVenues = const [],
  });

  @override
  List<Object> get props => [cities, categories, ageRatings];
}
