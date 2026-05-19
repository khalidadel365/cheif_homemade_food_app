import 'package:cheif_homemade_food/features/add_dish/presentation/views/add_dish_view.dart';
import 'package:cheif_homemade_food/features/edit_dish/presentation/views/edit_dish_view.dart';
import 'package:cheif_homemade_food/features/home/presentation/views/home_view.dart';
import 'package:cheif_homemade_food/features/profile/presentation/views/edit_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/utilities/api_constants.dart';
import '../../core/utilities/service_locator.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/home/data/models/order_requested_model.dart';
import '../../features/home/presentation/manager/orders/orders_cubit.dart';
import '../../features/home/presentation/manager/orders/orders_states.dart';
import '../../features/order_details/presentation/views/order_details_view.dart';
import '../../features/profile/presentation/manager/profile_cubit.dart';
import '../../features/profile/presentation/views/change_password_confirm_view.dart';
import '../../features/profile/presentation/views/change_password_request_view.dart';
import '../../features/profile/presentation/views/profile_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import 'functions/show_snack_bar.dart';

abstract class AppRouter {
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
  static const kOrderDetailsView = '/orderDetailsView';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(path: kLoginView, builder: (context, state) => LoginView()),
      GoRoute(
        path: kSignUpView,
        builder: (context, state) => const SignupView(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider.value(
            value: getIt.get<OrdersCubit>()..initSocket(ApiConstants.token!),
            child: BlocListener<OrdersCubit, OrdersState>(
              listener: (context, state) {
                if (state is NewIncomingOrderSuccess) {
                  showSnackBar(
                    showFromTop: true,
                    context: context,
                    color: Colors.green,
                    message: 'You have a new order!',
                  );
                  context.read<OrdersCubit>().refreshOrders();
                } else if (state is OrderCanceledSuccess) {
                  showSnackBar(
                    context: context,
                    color: Colors.red,
                    message: 'Order has been auto canceled ',
                    showFromTop: true,
                  );
                  context.read<OrdersCubit>().refreshOrders();
                }
              },
              child: child,
            ),
          );
        },
        routes: [
          GoRoute(
            path: kHomeView,
            builder: (context, state) => const HomeView(),
          ),
          GoRoute(
            path: kProfileView,
            builder: (context, state) => const ProfileView(),
          ),
          GoRoute(
            path: kAddDishView,
            builder: (context, state) => const AddDishView(),
          ),
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
            },
          ),
          GoRoute(
            path: kChangePasswordConfirmView,
            builder: (context, state) {
              final data = state.extra as Map<String, dynamic>;
              return BlocProvider.value(
                value: data['cubit'] as ProfileCubit,
                child: ChangePasswordConfirmView(),
              );
            },
          ),
          GoRoute(
            path: kEditProfileView,
            builder: (context, state) {
              final data = state.extra as Map<String, dynamic>;
              return BlocProvider.value(
                value: data['cubit'] as ProfileCubit,
                child: EditProfileView(user: data['user']),
              );
            },
          ),
          GoRoute(
            path: kOrderDetailsView,
            builder: (context, state) {
              final order = state.extra as OrderRequestedModel;
              return OrderDetailsView(order: order);
            },
          ),
        ],
      ),
    ],
  );
}
