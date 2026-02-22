import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/features/languages/domain/usecases/change_language.dart';
import 'package:oqyga_frontend/features/languages/domain/usecases/get_saved_language.dart';
part 'language_event.dart';
part 'language_state.dart';

// Bloc
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetSavedLanguageUseCase getSavedLanguageUseCase;
  final ChangeLanguageUseCase changeLanguageUseCase;

  LanguageBloc({
    required this.getSavedLanguageUseCase,
    required this.changeLanguageUseCase,
  }) : super(const LanguageState(locale: null)) {
    on<LoadSavedLanguageEvent>(_onLoadSavedLanguage);
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  Future<void> _onLoadSavedLanguage(
    LoadSavedLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    final locale = await getSavedLanguageUseCase();
    emit(LanguageState(locale: locale));
  }

  Future<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    await changeLanguageUseCase(event.locale);
    emit(LanguageState(locale: event.locale));
  }
}
