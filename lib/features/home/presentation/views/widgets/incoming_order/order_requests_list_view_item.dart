import 'package:cheif_homemade_food/constants.dart';
import 'package:cheif_homemade_food/core/utilities/api_constants.dart';
import 'package:cheif_homemade_food/core/utilities/styles.dart';
import 'package:cheif_homemade_food/core/widgets/custom_button.dart';
import 'package:cheif_homemade_food/features/home/data/models/order_model.dart';
import 'package:cheif_homemade_food/features/home/presentation/manager/orders/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'order_countdown_timer.dart';

class OrderRequestsListViewItem extends StatelessWidget {
  final OrderModel order;

  const OrderRequestsListViewItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                Text(
                  "${order.itemsCount ?? 0} Items ordered",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  "${order.totalAmount ?? '0.00'} EGP",
                  style: Styles.textStyle18.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          _buildTimerSection(),
          _buildActionButtons(context), // باصينا الـ context هنا عشان الـ Cubit
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.customerName ?? "Unknown User",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              order.formattedDate,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            order.displayOrderCode,
            style: Styles.textStyle13.copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimerSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.red[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.timer_outlined, color: Colors.red, size: 18),
              const SizedBox(width: 8),
              OrderCountdownTimer(
                initialSeconds: order.remainingSecondsToCancel,
              ),
            ],
          ),
          const Text(
            "Auto-decline soon",
            style: TextStyle(color: Colors.redAccent, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              backgroundColor: Colors.grey.shade100,
              borderRadius: 12,
              onPressed: () {
                context.read<OrdersCubit>().updateOrderStatus(
                  token: ApiConstants.token!,
                  orderId: order.orderId!,
                  status: 'rejected',
                );
              },
              text: 'Decline',
              elevation: 0,
              height: 45,
              textStyle: Styles.textStyle13.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomButton(
              backgroundColor: kPrimaryColor,
              borderRadius: 12,
              onPressed: () {
                context.read<OrdersCubit>().updateOrderStatus(
                  token: ApiConstants.token!,
                  orderId: order.orderId!,
                  status: 'accepted',
                );
              },
              text: 'Accept Order',
              elevation: 0,
              height: 45,
              textStyle: Styles.textStyle13.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}