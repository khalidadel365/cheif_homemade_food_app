import 'package:cheif_homemade_food/constants.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/dish_model.dart';
import '../../../../../core/utilities/styles.dart';

class DishesListViewItem extends StatelessWidget {
  final DishModel dish;
  const DishesListViewItem({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              dish.imageUrl ?? '',
              height: 85,
              width: 85,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dish.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "\$${dish.price ?? ''}",
                  style: Styles.textStyle18,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 40,
                      child: Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          value: dish.isAvailable ?? false,
                          onChanged: (val) {},
                          activeColor: Colors.white,
                          activeTrackColor: kPrimaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      dish.isAvailable == true ? "Active" : "Inactive",
                      style: TextStyle(
                        color: dish.isAvailable == true ? Colors.green : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined, size: 20, color: Colors.black),
              ),
              const SizedBox(height: 25),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {},
                icon: const Icon(Icons.delete_outline, size: 22, color: Colors.redAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}