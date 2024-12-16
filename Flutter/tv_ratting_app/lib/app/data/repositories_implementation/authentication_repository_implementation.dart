import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tv_ratting_app/app/data/services/remote/authentication_api.dart';
import 'package:tv_ratting_app/app/domain/either.dart';
import 'package:tv_ratting_app/app/domain/enums.dart';
import 'package:tv_ratting_app/app/domain/model/user.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';

const _key = "sessionId";

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FlutterSecureStorage _segureStorage;
  final AutenthicationAPI _autenthicationAPI;

  AuthenticationRepositoryImpl(this._segureStorage, this._autenthicationAPI);

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
    final requestTokenResult = await _autenthicationAPI.createRequestToken();

    return requestTokenResult.when(
      (failure) async => Either.left(failure),
      (requestToken) async {
        final loginResult = await _autenthicationAPI.createSessionwithLogin(
          username: username,
          password: password,
          requestToken: requestToken,
        );

        return loginResult.when(
          (failure) async => Either.left(failure),
          (newRequestToken) async {
            final sessionResult = await _autenthicationAPI.createSession(
              newRequestToken,
            );

            return sessionResult.when(
              (failure) async => Either.left(failure),
              (sessionId) async {
                await _segureStorage.write(
                  key: _key,
                  value: sessionId,
                );
                return Either.right(User());
              },
            );
          },
        );
      },
    );
  }

  @override
  Future<void> signOut() {
    return _segureStorage.delete(key: _key);
  }
}
