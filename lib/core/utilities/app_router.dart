import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/views/login_view.dart';

import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kMainView = '/mainView';
  static const kHomeView = '/homeView';
  static const kFreshNearbyDetailsView = '/freshNearbyDetailsView';
  static const kLoginView = '/loginView';
  static const kSignUpView = '/signUpView';
  static const kSplashScreen = '/splashView';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(path: kLoginView, builder: (context, state) => LoginView()),
      GoRoute(path: kSignUpView, builder: (context, state) => SignupView()),
    ],
  );
}
