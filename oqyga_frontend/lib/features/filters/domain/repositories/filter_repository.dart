import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/filter_options.dart';

abstract class FilterRepository {
  Future<Either<Failure, FilterOptions>> getFilterOptions(String languageCode);
}
