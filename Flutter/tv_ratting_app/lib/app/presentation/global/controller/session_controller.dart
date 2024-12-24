import 'package:tv_ratting_app/app/domain/model/user.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';
import 'package:tv_ratting_app/app/presentation/global/state_notifier.dart';

class SessionController extends StateNotifier<User?> {
  SessionController({
    required this.authenticationRepository,
  }) : super(null);

  final AuthenticationRepository authenticationRepository;

  void setUser(User user) {
    state = user;
  }

  Future<void> signOut() async{
    await authenticationRepository.signOut();
    onlyUpdate(null);
  }
}
