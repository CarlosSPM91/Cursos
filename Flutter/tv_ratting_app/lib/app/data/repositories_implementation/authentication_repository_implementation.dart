import 'package:tv_ratting_app/app/data/services/local/session_service.dart';
import 'package:tv_ratting_app/app/data/services/remote/account_api.dart';
import 'package:tv_ratting_app/app/data/services/remote/authentication_api.dart';
import 'package:tv_ratting_app/app/domain/either.dart';
import 'package:tv_ratting_app/app/domain/enums.dart';
import 'package:tv_ratting_app/app/domain/model/user/user.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AutenthicationAPI _autenthicationAPI;
  final SessionService _sessionService;
  final AccountApi _accountApi;

  AuthenticationRepositoryImpl(
      this._sessionService, this._autenthicationAPI, this._accountApi);

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _sessionService.sessionId;
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
                _sessionService.saveSessionId(sessionId);

                final user = await _accountApi.getAccount(sessionId);

                if (user == null) {
                  return Either.left(SignInFailure.unknown);
                }
                return Either.right(user);
              },
            );
          },
        );
      },
    );
  }

  @override
  Future<void> signOut() {
    return _sessionService.signOut();
  }
}
