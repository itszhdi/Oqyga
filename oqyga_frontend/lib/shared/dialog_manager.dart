import 'package:shared_preferences/shared_preferences.dart';

class DialogManager {
  DialogManager._internal();
  static final DialogManager _instance = DialogManager._internal();
  factory DialogManager() => _instance;

  static const String _cityDialogKeyPrefix = 'city_dialog_shown_for_user_';

  Future<bool> shouldShowCityDialog(int userId) async {
    final prefs = await SharedPreferences.getInstance();

    final hasBeenShown = prefs.getBool('$_cityDialogKeyPrefix$userId') ?? false;
    return !hasBeenShown;
  }

  Future<void> markCityDialogAsShown(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_cityDialogKeyPrefix$userId', true);
  }
}
