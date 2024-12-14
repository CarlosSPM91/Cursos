import 'package:tv_ratting_app/app/domain/either.dart';
import 'package:tv_ratting_app/app/domain/enums.dart';
import 'package:tv_ratting_app/app/domain/model/user.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;
  Future<User?> getUserData();
  Future<void> signOut();
  Future<Either<SignInFailure, User>> signIn(
    String username,
    String password,
  );
}
