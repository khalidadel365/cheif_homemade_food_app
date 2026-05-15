import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../../../constants.dart';
import '../../../../../../core/utilities/api_constants.dart';
import '../../../manager/orders/orders_cubit.dart';
import '../../../manager/orders/orders_states.dart';
import 'order_requests_list_view.dart';

class IncomingOrderTabView extends StatefulWidget {
  const IncomingOrderTabView({super.key});

  @override
  State<IncomingOrderTabView> createState() => _IncomingOrderTabViewState();
}

class _IncomingOrderTabViewState extends State<IncomingOrderTabView>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().getOrders(
      token: ApiConstants.token!,
      status: 'pending',
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<OrdersCubit, OrdersState>(
      buildWhen: (previous, current) =>
      current is GetOrdersLoadingState ||
          current is GetOrdersSuccessState ||
          current is GetOrdersErrorState,
      builder: (context, state) {
        if (state is GetOrdersSuccessState) {
          return state.orders.isEmpty
              ? const Center(child: Text("No incoming orders yet"))
              : OrderRequestsListView(orders: state.orders);
        } else if (state is GetOrdersErrorState) {
          return Center(child: Text(state.error));
        } else {
          return const Center(
            child: SpinKitPulse(size: 45, color: kPrimaryColor),
          );
        }
      },
    );
  }
}