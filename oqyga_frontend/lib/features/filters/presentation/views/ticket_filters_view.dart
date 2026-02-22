import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oqyga_frontend/core/errors/error_translator.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/category.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/ticket_filters.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/filter_options.dart';
import 'package:oqyga_frontend/features/filters/presentation/bloc/filter_bloc.dart';
import 'package:oqyga_frontend/features/filters/presentation/views/filter_view_mixin.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class TicketFiltersView extends StatefulWidget {
  final TicketFilters? initialFilters;

  const TicketFiltersView({super.key, this.initialFilters});

  @override
  State<TicketFiltersView> createState() => _TicketFiltersViewState();
}

class _TicketFiltersViewState extends State<TicketFiltersView>
    with FilterFormMixin<TicketFiltersView> {
  bool _initialValuesSet = false;
  Category? _selectedCategory;
  String? _selectedStatus;

  String _getStatusLabel(String status, S s) {
    switch (status) {
      case 'active':
        return s.statusActive;
      case 'inactive':
        return s.statusInactive;
      default:
        return status;
    }
  }

  final List<String> _statusKeys = ['active', 'inactive'];

  @override
  void initState() {
    super.initState();
    if (widget.initialFilters != null) {
      dateFrom = widget.initialFilters!.dateFrom;
      dateTo = widget.initialFilters!.dateTo;
      timeFrom = widget.initialFilters!.timeFrom;
      timeTo = widget.initialFilters!.timeTo;
      _selectedStatus = widget.initialFilters!.status;
    }
  }

  void _applyFilters() {
    final filters = TicketFilters(
      status: _selectedStatus,
      cityId: selectedCity?.cityId,
      categoryId: _selectedCategory?.categoryId,
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

    _initialValuesSet = true;
  }

  @override
  void resetFormFields() {
    super.resetFormFields();
    setState(() {
      _selectedCategory = null;
      _selectedStatus = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FilterBloc, FilterState>(
          builder: (context, state) {
            if (state.status == FilterStatus.loading) {
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
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
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
                title: s.ticketFiltersTitle,
                cities: state.options!.cities,
                onApply: _applyFilters,
                showPriceFilters: false,
                actionButtonTopSpacing: 260,
                specificFilters: Column(
                  children: [
                    buildDropdownField<String>(
                      label: s.statusLabel,
                      value: _selectedStatus,
                      items: _statusKeys,
                      titleBuilder: (value) => _getStatusLabel(value, s),
                      onChanged: (val) => setState(() => _selectedStatus = val),
                    ),
                    const SizedBox(height: 20),
                    buildDropdownField<Category>(
                      label: s.categoryLabel,
                      value: _selectedCategory,
                      items: state.options!.categories,
                      titleBuilder: (c) => c.categoryName,
                      onChanged: (val) =>
                          setState(() => _selectedCategory = val),
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
