import 'package:cheif_homemade_food/constants.dart';
import 'package:cheif_homemade_food/core/utilities/api_constants.dart';
import 'package:cheif_homemade_food/core/utilities/styles.dart';
import 'package:cheif_homemade_food/core/widgets/custom_button.dart';
import 'package:cheif_homemade_food/features/home/data/models/order_requested_model.dart';
import 'package:cheif_homemade_food/features/home/presentation/manager/orders/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utilities/app_router.dart';
import '../incoming_order/order_countdown_timer.dart';

class OrderAcceptedListViewItem extends StatelessWidget {
  final OrderRequestedModel order;

  const OrderAcceptedListViewItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.push(
          AppRouter.kOrderDetailsView,
          extra: order,
        );
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildTimerSection(),
              const SizedBox(height: 12),
              _buildActionButton(context),
            ],
          ),
        ),
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
              'ORDER # ${order.displayOrderCode}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Text(
              order.customerName ?? "Unknown User",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
    // استدعاء الحسبة المصلحة من الموديل
    final secondsLeft = order.remainingSecondsToPrepare;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: secondsLeft == 0 ? Colors.red[50] : Colors.green[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.timer_outlined,
                color: secondsLeft == 0 ? Colors.red : Colors.green,
                size: 18,
              ),
              const SizedBox(width: 8),
              OrderCountdownTimer(
                initialSeconds: secondsLeft,
                color: secondsLeft == 0 ? Colors.red : Colors.green,
              ),
            ],
          ),
          Text(
            secondsLeft == 0 ? "Should be ready!" : "Preparation time",
            style: TextStyle(
              color: secondsLeft == 0 ? Colors.red : Colors.green,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomButton(
        backgroundColor: kPrimaryColor,
        borderRadius: 12,
        onPressed: () {
          context.read<OrdersCubit>().updateOrderStatus(
            token: ApiConstants.token!,
            orderId: order.orderId!,
            status: 'out_for_delivery',
          );
        },
        text: 'Mark as Ready',
        icon: const Icon(
          Icons.check_circle_outline,
          color: Colors.white,
          size: 20,
        ),
        elevation: 0,
        height: 48,
        textStyle: Styles.textStyle14.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}