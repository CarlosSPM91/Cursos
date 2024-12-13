import 'package:tv_ratting_app/app/domain/model/user.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository{
  @override
  Future<User?> getUserData() {
    return Future.value(User());
  }

  @override
  
  Future<bool> get isSignedIn {
  return Future.value(true);
  }
}