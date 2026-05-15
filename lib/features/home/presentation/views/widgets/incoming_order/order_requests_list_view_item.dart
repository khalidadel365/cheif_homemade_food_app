import 'package:cheif_homemade_food/constants.dart';
import 'package:cheif_homemade_food/core/utilities/styles.dart';
import 'package:cheif_homemade_food/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'order_countdown_timer.dart';

class OrderRequestsListViewItem extends StatelessWidget {
  const OrderRequestsListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                const Text(
                  "1x Homemade Sourdough Loaf",
                  style: TextStyle(fontSize: 14),
                ),
                const Text(
                  "2x Berry Jam Jars (Small)",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  "\$24.50",
                  style: Styles.textStyle18.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          _buildTimerSection(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: NetworkImage(
            'https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fHww',
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sarah J.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "2 mins ago • 0.5 mi away",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "4.8",
            style: Styles.textStyle13.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.timer_outlined, color: Colors.red, size: 18),
              SizedBox(width: 8),
              OrderCountdownTimer(initialSeconds: 80),
            ],
          ),
          Text(
            "Auto-decline soon",
            style: TextStyle(color: Colors.redAccent, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              backgroundColor: Colors.grey.shade100,
              borderRadius: 12,
              onPressed: () {},
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
              onPressed: () {},
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
