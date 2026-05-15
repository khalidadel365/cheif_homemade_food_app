import 'order_socket_model.dart';

class OrderSocketResponse {
  final String type;
  final OrderSocketModel data;

  OrderSocketResponse({required this.type, required this.data});

  factory OrderSocketResponse.fromJson(Map<String, dynamic> json) {
    return OrderSocketResponse(
      type: json['type'],
      data: OrderSocketModel.fromJson(json['data']),
    );
  }
}
