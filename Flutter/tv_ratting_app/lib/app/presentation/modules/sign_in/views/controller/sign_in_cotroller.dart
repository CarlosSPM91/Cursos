import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/sign_in/sign_in_failure.dart';
import 'package:tv_ratting_app/app/domain/model/user/user.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/favorites/favorites_controller.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/session_controller.dart';
import 'package:tv_ratting_app/app/presentation/global/state_notifier.dart';
import 'package:tv_ratting_app/app/presentation/modules/sign_in/views/controller/state/sign_in_state.dart';

class SignInCotroller extends StateNotifier<SignInState> {
  SignInCotroller(
    super.state, {
    required this.authenticationRepository,
    required this.sessionController,
    required this.favoritesController,
  });
  final AuthenticationRepository authenticationRepository;
  final SessionController sessionController;
  final FavoritesController favoritesController;

  void onUsernameChanged(String text) {
    onlyUpdate(
      state.copyWith(username: text.trim()),
    );
  }

  void onPasswordChanged(String text) {
    onlyUpdate(
      state.copyWith(
        password: text.replaceAll(" ", ""),
      ),
    );
  }

  Future<Either<SignInFailure, User>> submit() async {
    state = state.copyWith(fetching: true);
    final result = await authenticationRepository.signIn(
      state.username,
      state.password,
    );
    result.when(
      left:(_) => state = state.copyWith(fetching: false),
      right:(user) {
        sessionController.setUser(user);
        favoritesController.init();
      },
    );

    return result;
  }
}
