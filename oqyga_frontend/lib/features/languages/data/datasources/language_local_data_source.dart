import 'package:shared_preferences/shared_preferences.dart';

abstract class LanguageLocalDataSource {
  Future<void> cacheLanguageCode(String languageCode);
  Future<String?> getCachedLanguageCode();
}

const String CACHED_LANGUAGE_CODE = 'CACHED_LANGUAGE_CODE';

class LanguageLocalDataSourceImpl implements LanguageLocalDataSource {
  final SharedPreferences sharedPreferences;

  LanguageLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheLanguageCode(String languageCode) {
    return sharedPreferences.setString(CACHED_LANGUAGE_CODE, languageCode);
  }

  @override
  Future<String?> getCachedLanguageCode() {
    final code = sharedPreferences.getString(CACHED_LANGUAGE_CODE);
    return Future.value(code);
  }
}
