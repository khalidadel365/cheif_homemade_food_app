import 'package:cheif_homemade_food/features/add_dish/presentation/views/add_dish_view.dart';
import 'package:cheif_homemade_food/features/edit_dish/presentation/views/edit_dish_view.dart';
import 'package:cheif_homemade_food/features/home/presentation/views/home_view.dart';
import 'package:cheif_homemade_food/features/profile/presentation/views/edit_profile_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/views/login_view.dart';

import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/profile/presentation/manager/profile_cubit.dart';
import '../../features/profile/presentation/views/change_password_confirm_view.dart';
import '../../features/profile/presentation/views/change_password_request_view.dart';
import '../../features/profile/presentation/views/profile_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  //static const kMainView = '/mainView';
  static const kHomeView = '/homeView';
  static const kFreshNearbyDetailsView = '/freshNearbyDetailsView';
  static const kLoginView = '/loginView';
  static const kSignUpView = '/signUpView';
  static const kSplashView = '/splashView';
  static const kProfileView = '/ProfileView';
  static const kEditProfileView = '/editProfileView';
  static const kAddDishView = '/addDishView';
  static const kEditDishView = '/editDishView';
  static const kChangePasswordRequestView = '/changePasswordRequestView';
  static const kChangePasswordConfirmView = '/changePasswordConfirmView';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(path: kLoginView, builder: (context, state) => LoginView()),
      GoRoute(
        path: kSignUpView,
        builder: (context, state) => const SignupView(),
      ),
      GoRoute(
        path: kProfileView,
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
      GoRoute(path: kAddDishView, builder: (context, state) => const AddDishView()),
      GoRoute(
        path: kEditDishView,
        builder: (context, state) {
          final dishId = state.extra as int;
          return EditDishView(dishId: dishId);
        },
      ),

      GoRoute(
          path: kChangePasswordRequestView,
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            return BlocProvider.value(
              value: data['cubit'] as ProfileCubit,
              child: ChangePasswordRequestView(),
            );
          }),
      GoRoute(
          path: kChangePasswordConfirmView,
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            return BlocProvider.value(
              value: data['cubit'] as ProfileCubit,
              child: ChangePasswordConfirmView(),
            );
          }),
      GoRoute(
          path: kEditProfileView,
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            return BlocProvider.value(
              value: data['cubit'] as ProfileCubit,
              child: EditProfileView(
                user: data['user'],
              ),
            );
          }),
    ],
  );
}
