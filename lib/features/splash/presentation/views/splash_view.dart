import 'package:cheif_homemade_food/features/splash/presentation/views/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utilities/api_constants.dart';
import '../../../../core/utilities/app_router.dart';
import '../../../../core/utilities/cache_helper.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      ApiConstants.token = CacheHelper.getData(key: 'token');
      ApiConstants.id = CacheHelper.getData(key: 'id');
      print("user id ${ApiConstants.id}");
      print("token ${ApiConstants.token}");
      if (ApiConstants.token != null) {
        GoRouter.of(context).go(AppRouter.kHomeView);
      } else {
        GoRouter.of(context).go(AppRouter.kLoginView);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SplashViewBody());
  }
}
