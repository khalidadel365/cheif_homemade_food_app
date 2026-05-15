class OrderSocketModel {
  final String orderId;
  final String customerName;
  final String totalAmount;
  final int itemsCount;
  final String message;
  final String createdAt;

  OrderSocketModel({
    required this.orderId,
    required this.customerName,
    required this.totalAmount,
    required this.itemsCount,
    required this.message,
    required this.createdAt,
  });

  factory OrderSocketModel.fromJson(Map<String, dynamic> json) {
    return OrderSocketModel(
      orderId: json['order_id'],
      customerName: json['customer_name'],
      totalAmount: json['total_amount'],
      itemsCount: json['items_count'],
      message: json['message'],
      createdAt: json['created_at'],
    );
  }
}
