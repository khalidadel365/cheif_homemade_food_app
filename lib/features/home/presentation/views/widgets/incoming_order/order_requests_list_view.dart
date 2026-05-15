import 'package:cheif_homemade_food/features/home/presentation/views/widgets/incoming_order/order_requests_list_view_item.dart';
import 'package:flutter/material.dart';

class OrderRequestsListView extends StatelessWidget {
  const OrderRequestsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return const OrderRequestsListViewItem();
      },
    );
  }
}
