import 'package:flutter/foundation.dart';

class ThemeController extends ChangeNotifier {
  bool _darkMode;

  ThemeController(this._darkMode);
  bool get darkMode => _darkMode;

  void onChanged(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }
}
