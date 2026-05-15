import 'package:meta/meta.dart';
import '../../../data/models/order_socket_model.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersSocketConnected extends OrdersState {}

class NewIncomingOrderSuccess extends OrdersState {
  final OrderSocketModel order;
  NewIncomingOrderSuccess(this.order);
}

class OrderCanceledSuccess extends OrdersState {
  final OrderSocketModel order;
  OrderCanceledSuccess(this.order);
}

class PreparingOrdersUpdated extends OrdersState {
  final List<OrderSocketModel> preparingOrders;
  PreparingOrdersUpdated(this.preparingOrders);
}

class OrdersError extends OrdersState {
  final String errMessage;
  OrdersError(this.errMessage);
}
