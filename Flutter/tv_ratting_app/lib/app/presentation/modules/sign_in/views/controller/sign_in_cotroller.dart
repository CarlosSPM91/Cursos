import 'package:flutter/foundation.dart';
import 'package:tv_ratting_app/app/presentation/modules/sign_in/views/controller/sign_in_state.dart';

class SignInCotroller extends ChangeNotifier {
  SignInState _state = SignInState();
  bool _mounted = true;

  SignInState get state => _state;
  bool get mounted => _mounted;

  void onUsernameChanged(String text) {
    _state = _state.copyWith(username: text.trim());
  }

  void onPasswordChanged(String text) {
    _state = _state.copyWith(password: text.replaceAll(" ", ""));
  }

  void onFetchingChanged(bool value) {
    _state = _state.copyWith(fetching: value);
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
