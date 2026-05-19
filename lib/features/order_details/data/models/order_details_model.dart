class OrderDetailsModel {
  final String? orderId;
  final int? customer;
  final String? customerName;
  final int? chef;
  final String? chefName;
  final String? status;
  final String? subtotal;
  final String? deliveryFee;
  final String? totalAmount;
  final int? estimatedPreparationMinutes;
  final String? estimatedReadyTime;
  final String? deliveryAddress;
  final String? deliveryLongitude;
  final String? deliveryLatitude;
  final String? estimatedDeliveryTime;
  final String? specialInstructions;
  final String? createdAt;
  final String? updatedAt;
  final String? acceptedAt;
  final String? outForDeliveryAt;
  final String? deliveredAt;
  final String? cancelledAt;
  final int? cancelledBy;
  final String? cancellationReason;
  final List<OrderItemModel>? items;

  OrderDetailsModel({
    this.orderId,
    this.customer,
    this.customerName,
    this.chef,
    this.chefName,
    this.status,
    this.subtotal,
    this.deliveryFee,
    this.totalAmount,
    this.estimatedPreparationMinutes,
    this.estimatedReadyTime,
    this.deliveryAddress,
    this.deliveryLongitude,
    this.deliveryLatitude,
    this.estimatedDeliveryTime,
    this.specialInstructions,
    this.createdAt,
    this.updatedAt,
    this.acceptedAt,
    this.outForDeliveryAt,
    this.deliveredAt,
    this.cancelledAt,
    this.cancelledBy,
    this.cancellationReason,
    this.items,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      orderId: json['order_id'] as String?,
      customer: json['customer'] as int?,
      customerName: json['customer_name'] as String?,
      chef: json['chef'] as int?,
      chefName: json['chef_name'] as String?,
      status: json['status'] as String?,
      subtotal: json['subtotal'] as String?,
      deliveryFee: json['delivery_fee'] as String?,
      totalAmount: json['total_amount'] as String?,
      estimatedPreparationMinutes: json['estimated_preparation_minutes'] as int?,
      estimatedReadyTime: json['estimated_ready_time'] as String?,
      deliveryAddress: json['delivery_address'] as String?,
      deliveryLongitude: json['delivery_longitude'] as String?,
      deliveryLatitude: json['delivery_latitude'] as String?,
      estimatedDeliveryTime: json['estimated_delivery_time'] as String?,
      specialInstructions: json['special_instructions'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      acceptedAt: json['accepted_at'] as String?,
      outForDeliveryAt: json['out_for_delivery_at'] as String?,
      deliveredAt: json['delivered_at'] as String?,
      cancelledAt: json['cancelled_at'] as String?,
      cancelledBy: json['cancelled_by'] as int?,
      cancellationReason: json['cancellation_reason'] as String?,
      items: json['items'] != null
          ? (json['items'] as List).map((i) => OrderItemModel.fromJson(i)).toList()
          : null,
    );
  }
}

class OrderItemModel {
  final int? id;
  final String? dishName;
  final String? dishBasePrice;
  final int? quantity;
  final String? unitPrice;
  final String? itemTotal;
  final String? specialRequests;
  final List<dynamic>? varietySelections;

  OrderItemModel({
    this.id,
    this.dishName,
    this.dishBasePrice,
    this.quantity,
    this.unitPrice,
    this.itemTotal,
    this.specialRequests,
    this.varietySelections,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as int?,
      dishName: json['dish_name'] as String?,
      dishBasePrice: json['dish_base_price'] as String?,
      quantity: json['quantity'] as int?,
      unitPrice: json['unit_price'] as String?,
      itemTotal: json['item_total'] as String?,
      specialRequests: json['special_requests'] as String?,
      varietySelections: json['variety_selections'] as List<dynamic>?,
    );
  }
}