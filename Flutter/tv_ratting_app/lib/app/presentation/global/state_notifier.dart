import 'package:flutter/foundation.dart';

abstract class StateNotifier<T> extends ChangeNotifier {
  T _state;
  T _oldState;
  bool _mounted = true;

  StateNotifier(this._state) : _oldState = _state;

  T get state => _state;
  T get oldState => _oldState;
  bool get mounted => _mounted;

  set state(T newState) => _update(newState);

  void onlyUpdate(T newState) {
    _update(newState, notify: false);
  }

  void _update(
    T newState, {
    bool notify = true,
  }) {
    if (_state != newState) {
      _oldState = _state;
      _state = newState;
    }
    if (notify) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
