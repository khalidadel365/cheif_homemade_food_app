import 'package:cheif_homemade_food/constants.dart';
import 'package:flutter/material.dart';

import 'dishes_tab_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(18),
            ),
            child: TabBar(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              enableFeedback: false,
              splashFactory: NoSplash.splashFactory,
              padding: EdgeInsets.all(0),
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ],
              ),
              labelColor: kPrimaryColor,
              unselectedLabelColor: Colors.grey[500],
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              tabs: const [
                Tab(text: "Dishes"),
                Tab(text: "Incoming"),
                Tab(text: "Preparing"),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                DishesTabView(),
                SizedBox(height: 4,),
                SizedBox(height: 4,),
                //IncomingOrdersTabView(),
                //PreparingOrdersTabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}