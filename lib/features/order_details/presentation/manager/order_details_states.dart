import '../../data/models/order_details_model.dart';

abstract class OrderDetailsState {}

class OrderDetailsInitialState extends OrderDetailsState {}

class OrderDetailsLoadingState extends OrderDetailsState {}

class OrderDetailsSuccessState extends OrderDetailsState {
  final OrderDetailsModel orderDetails;

  OrderDetailsSuccessState(this.orderDetails);
}

class OrderDetailsFailureState extends OrderDetailsState {
  final String errMessage;

  OrderDetailsFailureState(this.errMessage);
}