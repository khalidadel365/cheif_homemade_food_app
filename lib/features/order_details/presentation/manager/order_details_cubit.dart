import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/order_details_repo.dart';
import 'order_details_states.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final OrderDetailsRepo orderDetailsRepo;

  OrderDetailsCubit(this.orderDetailsRepo) : super(OrderDetailsInitialState());

  Future<void> fetchOrderDetails({
    required String token,
    required String orderId,
  }) async {
    emit(OrderDetailsLoadingState());

    var result = await orderDetailsRepo.getOrderDetails(
      token: token,
      orderId: orderId,
    );

    result.fold(
          (failure) => emit(OrderDetailsFailureState(failure.errorMessage)),
          (orderDetails) => emit(OrderDetailsSuccessState(orderDetails)),
    );
  }
}