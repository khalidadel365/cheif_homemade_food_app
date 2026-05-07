import 'package:cheif_homemade_food/core/utilities/api_constants.dart';
import 'package:cheif_homemade_food/core/utilities/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../constants.dart';
import '../../../../../core/models/dish_model.dart';
import '../../../../../core/utilities/styles.dart';
import '../../manager/home_cubit.dart';
import '../../manager/home_states.dart';

class DishesListViewItem extends StatelessWidget {
  final DishModel dish;
  const DishesListViewItem({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              dish.imageUrl ?? '',
              height: 85,
              width: 85,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => const Icon(Icons.fastfood),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dish.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text("\$${dish.price ?? ''}", style: Styles.textStyle18),
                const SizedBox(height: 10),
                Row(
                  children: [
                    BlocBuilder<HomeCubit, HomeStates>(
                      buildWhen:
                          (prev, curr) =>
                              (curr is ChangeDishAvailabilityLoadingState &&
                                  curr.dishId == dish.id) ||
                              (curr is ChangeDishAvailabilitySuccessState &&
                                  curr.updatedDish.id == dish.id) ||
                              (curr is ChangeDishAvailabilityErrorState),
                      builder: (context, state) {
                        if (state is ChangeDishAvailabilityLoadingState &&
                            state.dishId == dish.id) {
                          return const SizedBox(
                            height: 20,
                            width: 40,
                            child: Center(
                              child: SizedBox(
                                height: 14,
                                width: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          );
                        }
                        return SizedBox(
                          height: 15,
                          width: 40,
                          child: Transform.scale(
                            scale: 0.7,
                            child: Switch(
                              trackOutlineColor: WidgetStateProperty.all(
                                Colors.transparent,
                              ),
                              thumbColor: WidgetStateProperty.all(Colors.white),
                              activeTrackColor: kPrimaryColor,
                              trackOutlineWidth: WidgetStateProperty.all(0),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: dish.isAvailable ?? false,
                              onChanged: (val) {
                                context
                                    .read<HomeCubit>()
                                    .changeDishAvailability(
                                      token: ApiConstants.token!,
                                      dishId: dish.id!,
                                      isAvailable: val,
                                    );
                              },
                              activeColor: Colors.white,
                              inactiveTrackColor: Colors.grey[300],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    Text(
                      dish.isAvailable == true ? "Active" : "Inactive",
                      style: TextStyle(
                        color:
                            dish.isAvailable == true
                                ? Colors.green
                                : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  GoRouter.of(context).push(
                    AppRouter.kEditDishView,
                    extra: dish.id,
                  );
                },
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 25),
              BlocBuilder<HomeCubit, HomeStates>(
                buildWhen:
                    (prev, curr) =>
                        (curr is DeleteChefDishLoadingState &&
                            curr.dishId == dish.id) ||
                        (curr is DeleteChefDishErrorState) ||
                        (curr is DeleteChefDishSuccessState &&
                            curr.dishId == dish.id),
                builder: (context, state) {
                  if (state is DeleteChefDishLoadingState &&
                      state.dishId == dish.id) {
                    return const SizedBox(
                      height: 17,
                      width: 17,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.redAccent,
                      ),
                    );
                  }
                  return IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      context.read<HomeCubit>().deleteDish(
                        token: ApiConstants.token!,
                        dishId: dish.id!,
                      );
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      size: 22,
                      color: Colors.redAccent,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
