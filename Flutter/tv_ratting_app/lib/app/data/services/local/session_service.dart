import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const sessionKey = "sessionId";
const accountKey = "accountId";

class SessionService {
  final FlutterSecureStorage _secureStorage;

  SessionService(this._secureStorage);

  Future<String?> get sessionId async {
    return _secureStorage.read(key: sessionKey);
  }

  Future<String?> get accountId async {
    return _secureStorage.read(key: accountKey);
  }

  Future<void> saveSessionId(String sessionId) {
    return _secureStorage.write(
      key: sessionKey,
      value: sessionId,
    );
  }

  Future<void> saveAccountId(String accountId) {
    return _secureStorage.write(
      key: accountKey,
      value: accountId,
    );
  }

  Future<void> signOut() async {
    return _secureStorage.deleteAll();
  }
}
