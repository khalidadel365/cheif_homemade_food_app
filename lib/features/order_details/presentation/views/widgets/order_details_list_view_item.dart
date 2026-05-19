import 'package:cheif_homemade_food/constants.dart';
import 'package:cheif_homemade_food/core/utilities/styles.dart';
import 'package:flutter/material.dart';

class OrderDetailsListViewItem extends StatelessWidget {
  final Map<String, dynamic> itemData;

  const OrderDetailsListViewItem({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> varieties = itemData['variety_selections'] ?? [];
    final String? specialRequest = itemData['special_requests'];

    final String dishName = itemData['dish_name'] ?? itemData['name'] ?? '';
    final String itemPrice = itemData['item_total'] ?? itemData['price'] ?? '0.00';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.fastfood_outlined, color: kPrimaryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dishName,
                  style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Quantity: ${itemData['quantity']}',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                ),
                if (varieties.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: varieties.map((v) {
                      return Text(
                        v.toString(),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      );
                    }).toList(),
                  ),
                ],
                if (specialRequest != null && specialRequest.trim().isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Note: $specialRequest',
                      style: TextStyle(
                        color: Colors.amber.shade900,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$itemPrice EGP',
            style: Styles.textStyle14.copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}