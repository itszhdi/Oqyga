import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart'; // Для ApiException
import 'package:oqyga_frontend/features/filters/data/datasources/filter_remote_data_source.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/age_restriction.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/category.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/city.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/filter_options.dart';
import 'package:oqyga_frontend/features/filters/domain/repositories/filter_repository.dart';

class FilterRepositoryImpl implements FilterRepository {
  final FilterRemoteDataSource remoteDataSource;

  FilterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, FilterOptions>> getFilterOptions(
    String languageCode,
  ) async {
    try {
      final results = await Future.wait([
        remoteDataSource.getCities(languageCode),
        remoteDataSource.getCategories(languageCode),
        remoteDataSource.getAgeRestrictions(),
      ], eagerError: true);

      final cities = results[0] as List<City>;
      final categories = results[1] as List<Category>;
      final ageRatings = results[2] as List<AgeRestriction>;

      final options = FilterOptions(
        cities: cities,
        categories: categories,
        ageRatings: ageRatings,
      );

      return Right(options);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('Failed to load filter options: ${e.toString()}'),
      );
    }
  }
}
