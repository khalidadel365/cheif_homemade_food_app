import 'package:cheif_homemade_food/features/order_details/presentation/views/widgets/order_details_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../core/utilities/styles.dart';
import '../../../home/data/models/order_requested_model.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({required this.order, super.key});

  final OrderRequestedModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.withOpacity(0.3), height: 1.0),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 7),
        centerTitle: true,
        title: Text('Order Details', style: Styles.textStyle20),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: OrderDetailsViewBody(order: order,),
    );
  }
}
