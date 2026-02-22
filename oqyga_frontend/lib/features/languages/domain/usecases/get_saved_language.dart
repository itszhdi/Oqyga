import 'dart:ui';
import '../repositories/language_repository.dart';

class GetSavedLanguageUseCase {
  final LanguageRepository repository;

  GetSavedLanguageUseCase(this.repository);

  Future<Locale?> call() async {
    return await repository.getSavedLanguage();
  }
}
