import 'dart:convert';
import 'package:bloc/bloc.dart';
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
}
