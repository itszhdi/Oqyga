import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/filter_options.dart';
import 'package:oqyga_frontend/features/filters/domain/usecases/get_filter_options.dart';
import 'package:oqyga_frontend/features/organizer/domain/usecases/get_previous_venues.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final GetFilterOptions _getFilterOptions;
  final GetPreviousVenues _getPreviousVenues;

  FilterBloc({
    required GetFilterOptions getFilterOptions,
    required GetPreviousVenues getPreviousVenues,
  }) : _getFilterOptions = getFilterOptions,
       _getPreviousVenues = getPreviousVenues,
       super(const FilterState()) {
    on<LoadFilterOptions>(_onLoadFilterOptions);
  }

  Future<void> _onLoadFilterOptions(
    LoadFilterOptions event,
    Emitter<FilterState> emit,
  ) async {
    emit(state.copyWith(status: FilterStatus.loading));
    final languageCode = Intl.getCurrentLocale().substring(0, 2);

    final filtersResult = await _getFilterOptions(languageCode);

    final venuesResult = await _getPreviousVenues();

    filtersResult.fold(
      (failure) => emit(
        state.copyWith(
          status: FilterStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (options) {
        List<String> venues = [];
        venuesResult.fold((l) => null, (r) => venues = r);

        final fullOptions = FilterOptions(
          cities: options.cities,
          categories: options.categories,
          ageRatings: options.ageRatings,
          organizerVenues: venues,
        );

        emit(
          state.copyWith(status: FilterStatus.success, options: fullOptions),
        );
      },
    );
  }
}
