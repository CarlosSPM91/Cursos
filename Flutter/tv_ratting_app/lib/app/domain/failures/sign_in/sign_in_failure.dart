import "package:freezed_annotation/freezed_annotation.dart";

part "sign_in_failure.freezed.dart";

@freezed
abstract class SignInFailure with _$SignInFailure{
  factory SignInFailure.notFound()= _NotFound;
  factory SignInFailure.notVerified()= _NotVerified;
  factory SignInFailure.network()= _Network;
  factory SignInFailure.unkown()= _Unkown;
  factory SignInFailure.unauthorized()= _Unauthorized;
}

