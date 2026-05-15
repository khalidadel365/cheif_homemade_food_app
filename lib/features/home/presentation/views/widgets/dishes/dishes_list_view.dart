import 'package:flutter/material.dart';
import '../../../../../../core/models/dish_model.dart';
import 'dishes_list_view_item.dart';

class DishesListView extends StatelessWidget {
  final List<DishModel> dishes;

  const DishesListView({super.key, required this.dishes});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 5),
      itemBuilder: (context, index) => DishesListViewItem(dish: dishes[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemCount: dishes.length,
    );
  }
}
