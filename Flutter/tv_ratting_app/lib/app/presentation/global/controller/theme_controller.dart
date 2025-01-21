import 'package:flutter/foundation.dart';
import 'package:tv_ratting_app/app/domain/repositories/preferences_repository.dart';

class ThemeController extends ChangeNotifier {
  bool _darkMode;
  final PreferencesRepository preferencesRepository;
  ThemeController(
    this._darkMode, {
    required this.preferencesRepository,
  });

  bool get darkMode => _darkMode;

  void onChanged(bool darkMode) {
    _darkMode = darkMode;
    preferencesRepository.setDarkMode(_darkMode);
    notifyListeners();
  }
}
