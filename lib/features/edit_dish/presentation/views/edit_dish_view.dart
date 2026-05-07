import 'package:cheif_homemade_food/features/edit_dish/presentation/views/widgets/edit_dish_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../core/utilities/service_locator.dart';
import '../../../../core/utilities/styles.dart';
import '../../data/repos/edit_dish_repo.dart';
import '../manager/edit_dish_cubit.dart';

class EditDishView extends StatelessWidget {
  final int dishId;
  const EditDishView({super.key, required this.dishId});

  @override
  Widget build(BuildContext context) {
    print(dishId);
    return BlocProvider(
      create: (context) => EditDishCubit(
        getIt.get<EditDishRepo>(),
      )
        ..getCategories()
        ..fetchDishDetails(id: dishId),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBackGroundColor,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(color: Colors.grey.withOpacity(0.3), height: 1.0),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 7),
          title: Text('Edit Dish', style: Styles.textStyle20),
        ),
        body: EditDishViewBody(),
      ),
    );
  }
}
