import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../../../constants.dart';
import '../../../../../../core/utilities/api_constants.dart';
import '../../../manager/orders/orders_cubit.dart';
import '../../../manager/orders/orders_states.dart';
import 'order_accepted_list_view.dart';

class PreparingOrderTabView extends StatefulWidget {
  const PreparingOrderTabView({super.key});

  @override
  State<PreparingOrderTabView> createState() => _PreparingOrderTabViewState();
}

class _PreparingOrderTabViewState extends State<PreparingOrderTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().getOrders(
      token: ApiConstants.token!,
      status: 'accepted',
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<OrdersCubit, OrdersState>(
      buildWhen: (previous, current) =>
      current is GetPreparingOrdersLoadingState ||
          current is GetPreparingOrdersSuccessState ||
          current is GetPreparingOrdersErrorState,
      builder: (context, state) {
        if (state is GetPreparingOrdersSuccessState) {
          return state.orders.isEmpty
              ? const Center(child: Text("No accepted orders yet"))
              : OrderAcceptedListView(orders: state.orders);
        } else if (state is GetPreparingOrdersErrorState) {
          return Center(child: Text(state.error));
        } else if (state is GetPreparingOrdersLoadingState) {
          return const Center(
            child: SpinKitPulse(size: 45, color: kPrimaryColor),
          );
        } else {
          final cubit = context.read<OrdersCubit>();
          return cubit.preparingOrders.isEmpty
              ? const Center(child: Text("No accepted orders yet"))
              : OrderAcceptedListView(orders: cubit.preparingOrders);
        }
      },
    );
  }
}