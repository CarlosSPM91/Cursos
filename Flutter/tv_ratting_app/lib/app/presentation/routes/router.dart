import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/inject_repositories.dart';
import 'package:tv_ratting_app/app/my_app.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/favorites/favorites_controller.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/session_controller.dart';
import 'package:tv_ratting_app/app/presentation/modules/favorites/views/favorites_view.dart';
import 'package:tv_ratting_app/app/presentation/modules/home/views/home_view.dart';
import 'package:tv_ratting_app/app/presentation/modules/movie/views/movie_view.dart';
import 'package:tv_ratting_app/app/presentation/modules/offline/views/ofline_view.dart';
import 'package:tv_ratting_app/app/presentation/modules/profile/views/profile_view.dart';
import 'package:tv_ratting_app/app/presentation/modules/serie/views/serie_view.dart';
import 'package:tv_ratting_app/app/presentation/modules/sign_in/views/sign_in_view.dart';
import 'package:tv_ratting_app/app/presentation/modules/splash/views/splash_view.dart';
import 'package:tv_ratting_app/app/presentation/routes/routes.dart';

Future<String> getInitialRouteName(BuildContext context) async {
  final SessionController sessionController = context.read();
  final FavoritesController favoritesController = context.read();

  final hasInternet = Repositories.connectivity.hasInternet;

  if (!hasInternet) {
    return Routes.offline;
  }

  final isSignedIn = await Repositories.authentication.isSignedIn;

  if (!isSignedIn) {
    return Routes.signIn;
  }

  final user = await Repositories.account.getUserData();

  if (user != null) {
    sessionController.setUser(user);
    favoritesController.init();
    return Routes.home;
  }

  return Routes.signIn;
}

mixin RouterMixin on State<MyApp> {
  GoRouter? _router;
  late String _initialRouteName;
  bool _loading = true;

  bool get loading => _loading;

  GoRouter get router {
    if (_router != null) {
      return _router!;
    }
    final routes = [
      GoRoute(
        name: Routes.home,
        path: "/",
        builder: (_, __) => const HomeView(),
      ),
      GoRoute(
        name: Routes.signIn,
        path: "/sign-in",
        builder: (_, __) => const SignInView(),
      ),
      GoRoute(
        name: Routes.movie,
        path: "/movie/:id",
        builder: (_, state) => MovieView(
          movieId: int.parse(state.pathParameters["id"]!),
        ),
      ),
      GoRoute(
        name: Routes.serie,
        path: "/serie/:id",
        builder: (_, state) => SerieView(
          serieId: int.parse(state.pathParameters["id"]!),
        ),
      ),
      GoRoute(
        name: Routes.splash,
        path: "/splash",
        builder: (_, __) => const SplashView(),
      ),
      GoRoute(
        name: Routes.profile,
        path: "/profile",
        builder: (_, __) => const ProfileView(),
      ),
      GoRoute(
        name: Routes.favorites,
        path: "/favorites",
        builder: (_, __) => const FavoritesView(),
      ),
      GoRoute(
        name: Routes.offline,
        path: "/offline",
        builder: (_, __) => const OfflineView(),
      ),
    ];

    final initialLocation = routes
        .firstWhere(
          (element) => element.name == _initialRouteName,
          orElse: () => routes.first,
        )
        .path;
    _router = _router = GoRouter(
      initialLocation: initialLocation,
      routes: routes,
    );
    return _router!;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPersistentFrameCallback((_) => _init);
    super.initState();
  }

  Future<void> _init() async {
    _initialRouteName = await getInitialRouteName(context);
    setState(() {
      _loading = false;
    });
  }
}
