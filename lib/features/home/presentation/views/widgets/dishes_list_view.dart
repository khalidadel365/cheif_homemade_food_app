import 'package:flutter/material.dart';

import 'dishes_list_view_item.dart';

class DishesListView extends StatelessWidget {
  const DishesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 5),
      itemBuilder: (context, index) => DishesListViewItem(),
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemCount: 5,
    );
  }
}
