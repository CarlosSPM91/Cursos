import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tv_ratting_app/app/domain/model/user.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';

const _key="sessionId";
class AuthenticationRepositoryImpl implements AuthenticationRepository{
  final FlutterSecureStorage _segureStorage;

  AuthenticationRepositoryImpl(this._segureStorage);

  
  @override
  Future<User?> getUserData() {
    return Future.value(User());
  }

  @override
  
  Future<bool> get isSignedIn async{
  final sessionId = await _segureStorage.read(key: _key);
  return sessionId!=null;
  
  }
}