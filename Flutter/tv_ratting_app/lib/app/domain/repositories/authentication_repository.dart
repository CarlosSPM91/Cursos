import 'package:tv_ratting_app/app/domain/either.dart';
import 'package:tv_ratting_app/app/domain/failures/sign_in/sign_in_failure.dart';
import 'package:tv_ratting_app/app/domain/model/user/user.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;
  Future<void> signOut();
  Future<Either<SignInFailure, User>> signIn(
    String username,
    String password,
  );
}
