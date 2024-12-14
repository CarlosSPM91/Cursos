import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tv_ratting_app/app/domain/either.dart';
import 'package:tv_ratting_app/app/domain/enums.dart';
import 'package:tv_ratting_app/app/domain/model/user.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';

const _key = "sessionId";

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FlutterSecureStorage _segureStorage;

  AuthenticationRepositoryImpl(this._segureStorage);

  @override
  Future<User?> getUserData() {
    return Future.value(User());
  }

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _segureStorage.read(key: _key);
    return sessionId != null;
  }

  @override
  Future<Either<SignInFailure, User>> signIn(
    String username,
    String password,
  ) async {
    if (username != "test") {
      return Either.left(SignInFailure.notFound);
    }
    if (password != "123456") {
      return Either.left(SignInFailure.unAuthorized);
    }

    await _segureStorage.write(key: _key, value: "123");
    return Either.right(
      User(),
    );
  }
  
  @override
  Future<void> signOut() {
    return _segureStorage.delete(key: _key);
  }
}
