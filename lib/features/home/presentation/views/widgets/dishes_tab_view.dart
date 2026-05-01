import 'package:flutter/material.dart';
import '../../../../../core/models/dish_model.dart';
import 'dishes_list_view.dart';

class DishesTabView extends StatelessWidget {
  final List<DishModel> dishes;

  const DishesTabView({super.key, required this.dishes});

  @override
  Widget build(BuildContext context) {
    return DishesListView(dishes: dishes);
  }
}