import 'package:tv_ratting_app/app/domain/model/user/user.dart';

abstract class AccountRepository {
  Future<User?> getUserData();
}
