import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_ratting_app/app/domain/preferences_enum.dart';
import 'package:tv_ratting_app/app/domain/repositories/preferences_repository.dart';

class PreferenceRepositoryImpl implements PreferencesRepository {
  final SharedPreferences _preferences;

  PreferenceRepositoryImpl(this._preferences);

  @override
  bool? get darkMode {
    return _preferences.getBool(
      Preferences.darkMode.name,
    );
  }

  @override
  Future<void> setDarkMode(bool darkMode) {
    return _preferences.setBool(
      Preferences.darkMode.name,
      darkMode,
    );
  }
}
