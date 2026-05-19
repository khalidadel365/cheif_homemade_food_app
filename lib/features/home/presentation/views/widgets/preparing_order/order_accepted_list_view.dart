import 'package:cheif_homemade_food/features/home/data/models/order_requested_model.dart'; // تأكد من المسار الصح للموديل
import 'package:flutter/material.dart';

import 'order_accepted_list_view_item.dart';

class OrderAcceptedListView extends StatelessWidget {
  final List<OrderRequestedModel> orders;

  const OrderAcceptedListView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: OrderAcceptedListViewItem(
            order: orders[index],
          ),
        );
      },
    );
  }
}