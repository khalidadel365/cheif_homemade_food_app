import 'package:meta/meta.dart';
import '../../../data/models/order_requested_model.dart';
import '../../../data/models/order_socket_model.dart';
import '../../../data/models/update_order_status_model.dart';

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

class GetIncomingOrdersLoadingState extends OrdersState {}

class GetIncomingOrdersSuccessState extends OrdersState {
  final List<OrderRequestedModel> orders;

  GetIncomingOrdersSuccessState(this.orders);
}

class GetIncomingOrdersErrorState extends OrdersState {
  final String error;

  GetIncomingOrdersErrorState(this.error);
}

class GetPreparingOrdersLoadingState extends OrdersState {}

class GetPreparingOrdersSuccessState extends OrdersState {
  final List<OrderRequestedModel> orders;

  GetPreparingOrdersSuccessState(this.orders);
}

class GetPreparingOrdersErrorState extends OrdersState {
  final String error;

  GetPreparingOrdersErrorState(this.error);
}

class UpdateOrderStatusLoadingState extends OrdersState {}

class UpdateOrderStatusSuccessState extends OrdersState {
  final UpdateOrderStatusModel updatedStatus;

  UpdateOrderStatusSuccessState(this.updatedStatus);
}

class UpdateOrderStatusErrorState extends OrdersState {
  final String error;

  UpdateOrderStatusErrorState(this.error);
}