import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/domain/model/user/user.dart';

abstract class AccountRepository {
  Future<User?> getUserData();
  Future<Either<HttpRequestFailure, Map<int, Media>>> getFavorites(MediaType type);
}
