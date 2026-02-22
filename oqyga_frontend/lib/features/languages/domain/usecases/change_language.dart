import 'dart:ui';
import '../repositories/language_repository.dart';

class ChangeLanguageUseCase {
  final LanguageRepository repository;

  ChangeLanguageUseCase(this.repository);

  Future<void> call(Locale locale) async {
    return await repository.changeLanguage(locale);
  }
}
