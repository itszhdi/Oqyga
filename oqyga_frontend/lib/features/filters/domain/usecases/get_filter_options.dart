import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/filter_options.dart';
import 'package:oqyga_frontend/features/filters/domain/repositories/filter_repository.dart';

class GetFilterOptions {
  final FilterRepository repository;

  GetFilterOptions(this.repository);

  Future<Either<Failure, FilterOptions>> call(String languageCode) async {
    return await repository.getFilterOptions(languageCode);
  }
}
