abstract class ConnectivityRepository{
  bool get hasInternet;
  Stream<bool> get onInternetChanged;
  Future<void> initialize();
}