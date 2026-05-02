import 'package:cheif_homemade_food/core/utilities/api_constants.dart';
import 'package:cheif_homemade_food/features/add_dish/data/repos/add_dish_repo_imp.dart';
import 'package:cheif_homemade_food/features/add_dish/presentation/manager/add_dish_cubit.dart';
import 'package:cheif_homemade_food/features/add_dish/presentation/views/widgets/add_dish_view_body.dart';
import 'package:cheif_homemade_food/features/home/data/repos/home_repo_imp.dart';
import 'package:cheif_homemade_food/features/home/presentation/manager/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../core/utilities/service_locator.dart';
import '../../../../core/utilities/styles.dart';

class AddDishView extends StatelessWidget {
  const AddDishView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              HomeCubit(getIt.get<HomeRepoImp>())
                ..getChefDishes(token: ApiConstants.token!),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBackGroundColor,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(color: Colors.grey.withOpacity(0.3), height: 1.0),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 7),
          centerTitle: true,
          title: Text('Add Dish Details', style: Styles.textStyle20),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: BlocProvider(
          create:
              (context) =>
                  AddDishCubit(getIt.get<AddDishRepoImp>())..getCategories(),
          child: const AddDishViewBody(),
        ),
      ),
    );
  }
}
