import 'package:cheif_homemade_food/core/utilities/api_constants.dart';
import 'package:cheif_homemade_food/core/utilities/app_router.dart';
import 'package:cheif_homemade_food/features/home/data/repos/home_repo_imp.dart';
import 'package:cheif_homemade_food/features/home/presentation/manager/home_cubit.dart';
import 'package:cheif_homemade_food/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../constants.dart';
import '../../../../core/utilities/service_locator.dart';
import '../../../../core/utilities/styles.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(getIt.get<HomeRepoImp>())..getChefDishes(token: ApiConstants.token!),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBackGroundColor,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey.withOpacity(0.3),
              height: 1.0,
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 7),
          title: Text('My Menu', style: Styles.textStyle23),
          actions: [
            IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kProfileView);
              },
              icon: const Icon(
                Icons.account_circle_outlined,
                size: 26,
              ),
            ),
          ],
        ),
        body: const HomeViewBody(),
        floatingActionButton: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimaryColor,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 27,
          ),
        ),
      ),
    );
  }
}