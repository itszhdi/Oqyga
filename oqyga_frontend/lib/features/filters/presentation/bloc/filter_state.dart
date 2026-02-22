part of 'filter_bloc.dart';

enum FilterStatus { initial, loading, success, failure }

class FilterState extends Equatable {
  final FilterStatus status;
  final FilterOptions? options;
  final String errorMessage;
  const FilterState({
    this.status = FilterStatus.initial,
    this.options,
    this.errorMessage = '',
  });
  FilterState copyWith({
    FilterStatus? status,
    FilterOptions? options,
    String? errorMessage,
  }) {
    return FilterState(
      status: status ?? this.status,
      options: options ?? this.options,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, options, errorMessage];
}
