import 'package:tv_ratting_app/app/data/http/http.dart';
import 'package:tv_ratting_app/app/domain/model/user.dart';

class AccountApi {
  final Http _http;

  AccountApi(this._http);

  Future<User?> getAccount(String sessionId) async {
    final result = await _http.request(
      "/account",
      queryParameters: {
        "session_id": sessionId,
      },
      onSucces: (json) {
        return User.fromJson(json);
      },
    );
    return result.when(
      (_) => null,
      (user) => user,
    );
  }
}
