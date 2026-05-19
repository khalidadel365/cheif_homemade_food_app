import 'package:flutter/material.dart';
import 'order_details_list_view_item.dart';

class OrderDetailsListView extends StatelessWidget {
  const OrderDetailsListView({super.key});

  final List<Map<String, dynamic>> staticItems = const [
    {'name': 'Chicken Biryani', 'quantity': 2, 'price': '240.00'},
    {'name': 'Green Salad', 'quantity': 1, 'price': '45.00'},
    {'name': 'Molokhia Cup', 'quantity': 1, 'price': '60.00'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: staticItems.length,
      itemBuilder: (context, index) {
        return OrderDetailsListViewItem(itemData: staticItems[index]);
      },
    );
  }
}