import 'dart:convert';
import 'package:bloc/bloc.dart';
import '../../../../../core/utilities/api_constants.dart';
import '../../../data/models/order_model.dart';
import '../../../data/models/order_socket_response.dart';
import '../../../data/repos/home_repo.dart';
import 'orders_states.dart';
import 'dart:async';

class OrdersCubit extends Cubit<OrdersState> {
  final HomeRepo homeRepo;
  StreamSubscription? _ordersSubscription;

  OrdersCubit(this.homeRepo) : super(OrdersInitial());

  void initSocket(String token) {
    // Cancel any existing subscription before creating a new one
    _ordersSubscription?.cancel();

    homeRepo.initOrdersSocket(token: token);

    _ordersSubscription = homeRepo.listenToOrders().listen((event) {
      if (!isClosed) {
        try {
          final Map<String, dynamic> responseMap =
              event is String ? jsonDecode(event) : event;
          final socketResponse = OrderSocketResponse.fromJson(responseMap);

          if (socketResponse.type == 'new_order') {
            emit(NewIncomingOrderSuccess(socketResponse.data));
          } else if (socketResponse.type == 'order_canceled') {
            emit(OrderCanceledSuccess(socketResponse.data));
          }
        } catch (e) {
          print("Error parsing socket event: $e");
        }
      }
    });
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    homeRepo.closeSocket();
    return super.close();
  }
  List<OrderModel> orders = [];

  Future<void> getOrders({
    required String token,
    required String status,
  }) async {
    emit(GetOrdersLoadingState());

    var result = await homeRepo.getOrders(token: token, status: status);

    result.fold(
          (failure) => emit(GetOrdersErrorState(failure.errorMessage)),
          (ordersResponse) {
        orders = ordersResponse;
        emit(GetOrdersSuccessState(orders));
      },
    );
  }
  void refreshOrders() {
    getOrders(
      token: ApiConstants.token!,
      status: 'pending',
    );
  }
  Future<void> updateOrderStatus({
    required String token,
    required String orderId,
    required String status,
  }) async {
    emit(UpdateOrderStatusLoadingState());

    var result = await homeRepo.updateOrderStatus(
      token: token,
      orderId: orderId,
      status: status,
    );

    result.fold(
          (failure) => emit(UpdateOrderStatusErrorState(failure.errorMessage)),
          (updatedStatusModel) {
        emit(UpdateOrderStatusSuccessState(updatedStatusModel));
        refreshOrders();
      },
    );
  }
}
