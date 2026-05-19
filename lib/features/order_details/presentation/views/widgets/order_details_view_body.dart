import 'package:cheif_homemade_food/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utilities/api_constants.dart';
import '../../../../../core/utilities/styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../home/data/models/order_requested_model.dart';
import '../../../../home/presentation/manager/orders/orders_cubit.dart';
import '../../../../home/presentation/views/widgets/incoming_order/order_countdown_timer.dart';
import 'order_details_list_view.dart';

class OrderDetailsViewBody extends StatelessWidget {
  final OrderRequestedModel order;

  const OrderDetailsViewBody({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildStatusCard(context),
          const SizedBox(height: 24),
          _buildCustomerSection(),
          const SizedBox(height: 24),
          Text(
            'Order Items',
            style: Styles.textStyle14.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          const OrderDetailsListView(),
          _buildBillSection(),
        ],
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    final isPending = order.status == 'pending';
    final secondsLeft = isPending
        ? order.remainingSecondsToCancel
        : order.remainingSecondsToPrepare;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isPending ? const Color(0xFFE65100) : const Color(0xFFEF6C00),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isPending ? 'Incoming' : 'Preparing',
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '#${order.displayOrderCode}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    order.formattedDate,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Timer',
                    style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  OrderCountdownTimer(
                    initialSeconds: secondsLeft,
                    color: kPrimaryColor,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (isPending)
            _buildPendingActions(context)
          else
            _buildPreparingActions(context),
        ],
      ),
    );
  }

  Widget _buildPendingActions(BuildContext context) {
    return Row(
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
              context.pop();
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
              context.pop();
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
    );
  }

  Widget _buildPreparingActions(BuildContext context) {
    return CustomButton(
      backgroundColor: kPrimaryColor,
      borderRadius: 12,
      onPressed: () {
        context.read<OrdersCubit>().updateOrderStatus(
          token: ApiConstants.token!,
          orderId: order.orderId!,
          status: 'out_for_delivery',
        );
        context.pop();
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
    );
  }

  Widget _buildCustomerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer Details',
          style: Styles.textStyle14.copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: kPrimaryColor.withOpacity(0.1),
                    radius: 20,
                    child: const Icon(Icons.person_outline, color: kPrimaryColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Customer Name',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          order.customerName ?? 'Unknown User',
                          style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Divider(height: 1, thickness: 0.5),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green.withOpacity(0.1),
                    radius: 20,
                    child: const Icon(Icons.location_on_outlined, color: Colors.green),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Address',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Cairo, Egypt - Dar El Salam District, Street 9',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1.3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildBillSection() {
    final String subtotal = order.totalAmount ?? '325.00';
    final String totalAmount = order.totalAmount ?? '335.00';

    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Earnings',
            style: Styles.textStyle15.copyWith(color: Colors.white,fontWeight: FontWeight.w700),
          ),
          Text(
            '${order.totalAmount} EGP',
            style: Styles.textStyle15.copyWith(color: Colors.white,fontWeight: FontWeight.w700),
          ),

        ],
      ),
    );
  }
}