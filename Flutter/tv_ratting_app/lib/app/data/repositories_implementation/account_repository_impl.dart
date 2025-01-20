import 'package:tv_ratting_app/app/data/services/local/session_service.dart';
import 'package:tv_ratting_app/app/data/services/remote/account_api.dart';
import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/domain/model/user/user.dart';
import 'package:tv_ratting_app/app/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountApi _accountApi;
  final SessionService _sessionService;

  AccountRepositoryImpl(
    this._accountApi,
    this._sessionService,
  );

  @override
  Future<User?> getUserData() async {
    final user = await _accountApi.getAccount(
      await _sessionService.sessionId ?? "",
    );
    if (user != null) {
      await _sessionService.saveAccountId(user.id.toString());
    }
    return user;
  }

  @override
  Future<Either<HttpRequestFailure, Map<int, Media>>> getFavorites(MediaType type) {
    return _accountApi.getFavorites(type);
  }

  @override
  Future<Either<HttpRequestFailure, void>> markAsFavorite({
    required int mediaId,
    required MediaType type,
    required bool favorite,
  }) {
    return _accountApi.markAsFavorite(
      mediaId: mediaId,
      type: type,
      favorite: favorite,
    );
  }
}
