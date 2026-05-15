class OrderModel {
  final String? orderId;
  final String? customerName;
  final String? chefName;
  final String? status;
  final String? totalAmount;
  final String? createdAt;
  final int? itemsCount;
  final String? estimatedReadyTime;

  OrderModel({
    this.orderId,
    this.customerName,
    this.chefName,
    this.status,
    this.totalAmount,
    this.createdAt,
    this.itemsCount,
    this.estimatedReadyTime,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['order_id'] as String?,
      customerName: json['customer_name'] as String?,
      chefName: json['chef_name'] as String?,
      status: json['status'] as String?,
      totalAmount: json['total_amount'] as String?,
      createdAt: json['created_at'] as String?,
      itemsCount: json['items_count'] as int?,
      estimatedReadyTime: json['estimated_ready_time'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'customer_name': customerName,
      'chef_name': chefName,
      'status': status,
      'total_amount': totalAmount,
      'created_at': createdAt,
      'items_count': itemsCount,
      'estimated_ready_time': estimatedReadyTime,
    };
  }
}
