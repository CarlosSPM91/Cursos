import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tv_ratting_app/app/data/services/remote/internet_checker.dart';
import 'package:tv_ratting_app/app/domain/repositories/connectivity_repository.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  final Connectivity _connectivity;
  final InternetChecker _internetChecker;
  final _streamController = StreamController<bool>.broadcast();

  late bool _hasInternet;
  StreamSubscription? _subscription;

  ConnectivityRepositoryImpl(
    this._connectivity,
    this._internetChecker,
  );

  @override
  Future<void> initialize() async {
    Future<bool> hasInternet(List<ConnectivityResult> result) async {
      if (result.first == ConnectivityResult.none) {
        return false;
      }
      return _internetChecker.hasInternet();
    }

    _hasInternet = await hasInternet(
      await _connectivity.checkConnectivity(),
    );

    _connectivity.onConnectivityChanged.listen(
      (event) async {
        _subscription?.cancel();
        _subscription = hasInternet(event).asStream().listen(
          (connected) {
            _hasInternet = connected;

            if (_streamController.hasListener && !_streamController.isClosed) {
              _streamController.add(
                _hasInternet,
              );
            }
          },
        );
      },
    );
  }

  @override
  bool get hasInternet => _hasInternet;

  @override
  Stream<bool> get onInternetChanged => _streamController.stream;
}
