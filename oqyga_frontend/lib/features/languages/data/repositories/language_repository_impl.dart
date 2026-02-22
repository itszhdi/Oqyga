import 'dart:ui';
import 'package:oqyga_frontend/features/languages/data/datasources/language_local_data_source.dart';
import 'package:oqyga_frontend/features/languages/domain/repositories/language_repository.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageLocalDataSource languageLocalDataSource;

  LanguageRepositoryImpl({required this.languageLocalDataSource});

  @override
  Future<void> changeLanguage(Locale locale) async {
    await languageLocalDataSource.cacheLanguageCode(locale.languageCode);
  }

  @override
  Future<Locale?> getSavedLanguage() async {
    final languageCode = await languageLocalDataSource.getCachedLanguageCode();
    if (languageCode != null) {
      return Locale(languageCode);
    }
    return null; // Если null, приложение будет использовать системный язык
  }
}
