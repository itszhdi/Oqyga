import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oqyga_frontend/core/errors/error_translator.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/category.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/age_restriction.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/filter_options.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/organizer_filters.dart';
import 'package:oqyga_frontend/features/filters/presentation/bloc/filter_bloc.dart';
import 'package:oqyga_frontend/features/filters/presentation/views/filter_view_mixin.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class OrganizerFiltersView extends StatefulWidget {
  final OrganizerFilters? initialFilters;

  const OrganizerFiltersView({super.key, this.initialFilters});

  @override
  State<OrganizerFiltersView> createState() => _OrganizerFiltersViewState();
}

class _OrganizerFiltersViewState extends State<OrganizerFiltersView>
    with FilterFormMixin<OrganizerFiltersView> {
  bool _initialValuesSet = false;
  Category? _selectedCategory;
  AgeRestriction? _selectedAge;
  String? _selectedVenueAddress;

  @override
  void initState() {
    super.initState();
    if (widget.initialFilters != null) {
      dateFrom = widget.initialFilters!.dateFrom;
      dateTo = widget.initialFilters!.dateTo;
      timeFrom = widget.initialFilters!.timeFrom;
      timeTo = widget.initialFilters!.timeTo;
      _selectedVenueAddress = widget.initialFilters!.venueAddress;
    }
    context.read<FilterBloc>().add(LoadFilterOptions());
  }

  @override
  void resetFormFields() {
    super.resetFormFields();
    setState(() {
      _selectedCategory = null;
      _selectedAge = null;
      _selectedVenueAddress = null;
    });
  }

  void _applyFilters() {
    final filters = OrganizerFilters(
      cityId: selectedCity?.cityId,
      categoryId: _selectedCategory?.categoryId,
      ageRatingId: _selectedAge?.ageId,
      venueAddress: _selectedVenueAddress,
      dateFrom: dateFrom,
      dateTo: dateTo,
      timeFrom: timeFrom,
      timeTo: timeTo,
    );
    context.pop(filters);
  }

  void _setInitialSelects(FilterOptions options) {
    if (_initialValuesSet || widget.initialFilters == null) return;

    if (widget.initialFilters!.cityId != null) {
      try {
        selectedCity = options.cities.firstWhere(
          (c) => c.cityId == widget.initialFilters!.cityId,
        );
      } catch (_) {
        selectedCity = null;
      }
    }

    if (widget.initialFilters!.categoryId != null) {
      try {
        _selectedCategory = options.categories.firstWhere(
          (c) => c.categoryId == widget.initialFilters!.categoryId,
        );
      } catch (_) {
        _selectedCategory = null;
      }
    }

    if (widget.initialFilters!.ageRatingId != null) {
      try {
        _selectedAge = options.ageRatings.firstWhere(
          (a) => a.ageId == widget.initialFilters!.ageRatingId,
        );
      } catch (_) {
        _selectedAge = null;
      }
    }

    if (widget.initialFilters!.venueAddress != null) {
      if (options.organizerVenues.contains(
        widget.initialFilters!.venueAddress,
      )) {
        _selectedVenueAddress = widget.initialFilters!.venueAddress;
      }
    }

    _initialValuesSet = true;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FilterBloc, FilterState>(
          builder: (context, state) {
            if (state.status == FilterStatus.loading ||
                state.status == FilterStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == FilterStatus.failure) {
              final errorMessage = translateErrorMessage(
                context,
                state.errorMessage,
              );
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${s.errorPrefix} $errorMessage',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<FilterBloc>().add(LoadFilterOptions()),
                      child: Text(s.retryButton),
                    ),
                  ],
                ),
              );
            }

            if (state.status == FilterStatus.success && state.options != null) {
              if (!_initialValuesSet) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted && !_initialValuesSet) {
                    setState(() {
                      _setInitialSelects(state.options!);
                    });
                  }
                });
              }

              return buildFilterFormContent(
                title: s.organizerFiltersTitle,
                cities: state.options!.cities,
                onApply: _applyFilters,
                showPriceFilters: false,
                actionButtonTopSpacing: 170,
                specificFilters: Column(
                  children: [
                    buildDropdownField<Category>(
                      label: s.categoryLabel,
                      value: _selectedCategory,
                      items: state.options!.categories,
                      titleBuilder: (c) => c.categoryName,
                      onChanged: (val) =>
                          setState(() => _selectedCategory = val),
                    ),
                    const SizedBox(height: 20),
                    buildDropdownField<AgeRestriction>(
                      label: s.ageRestrictionLabel,
                      value: _selectedAge,
                      items: state.options!.ageRatings,
                      titleBuilder: (a) => a.ageCategory,
                      onChanged: (val) => setState(() => _selectedAge = val),
                    ),
                    const SizedBox(height: 20),

                    buildDropdownField<String>(
                      label: s.venueLabel,
                      value: _selectedVenueAddress,
                      items: state.options!.organizerVenues,
                      titleBuilder: (venue) => venue,
                      onChanged: (val) =>
                          setState(() => _selectedVenueAddress = val),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
