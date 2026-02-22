import 'dart:ui';

abstract class LanguageRepository {
  Future<void> changeLanguage(Locale locale);
  Future<Locale?> getSavedLanguage();
}
