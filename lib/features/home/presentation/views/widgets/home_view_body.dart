import 'package:cheif_homemade_food/features/home/presentation/manager/home_cubit.dart';
import 'package:cheif_homemade_food/features/home/presentation/manager/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cheif_homemade_food/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dishes_tab_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              height: 50,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(18),
              ),
              child: TabBar(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                enableFeedback: false,
                splashFactory: NoSplash.splashFactory,
                padding: EdgeInsets.zero,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                    ),
                  ],
                ),
                labelColor: kPrimaryColor,
                unselectedLabelColor: Colors.grey[500],
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                tabs: const [
                  Tab(text: "Dishes"),
                  Tab(text: "Incoming"),
                  Tab(text: "Preparing"),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                BlocBuilder<HomeCubit, HomeStates>(
                  buildWhen: (previous, current) {
                    return current is GetChefDishesSuccessState ||
                        current is GetChefDishesErrorState ||
                        current is GetChefDishesLoadingState;
                  },
                  builder: (context, state) {
                    if (state is GetChefDishesSuccessState) {
                      return state.dishes.isEmpty
                          ? const Center(child: Text("You can add your first dish"))
                          : DishesTabView(dishes: state.dishes);
                    } else if (state is GetChefDishesErrorState) {
                      return Center(child: Text(state.error));
                    } else {
                      return const Center(
                        child: SpinKitPulse(size: 45, color: kPrimaryColor),
                      );
                    }
                  },
                ),
                const Center(child: Text("Incoming")),
                const Center(child: Text("Preparing")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}