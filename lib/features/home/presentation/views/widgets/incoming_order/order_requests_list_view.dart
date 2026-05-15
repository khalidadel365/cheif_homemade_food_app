import 'package:cheif_homemade_food/features/home/data/models/order_model.dart'; // تأكد من المسار الصح للموديل
import 'package:cheif_homemade_food/features/home/presentation/views/widgets/incoming_order/order_requests_list_view_item.dart';
import 'package:flutter/material.dart';

class OrderRequestsListView extends StatelessWidget {
  final List<OrderModel> orders;

  const OrderRequestsListView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: OrderRequestsListViewItem(
            order: orders[index],
          ),
        );
      },
    );
  }
}