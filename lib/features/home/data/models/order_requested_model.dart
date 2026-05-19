import 'package:intl/intl.dart';

class OrderRequestedModel {
  final String? orderId;
  final String? customerName;
  final String? chefName;
  final String? status;
  final String? totalAmount;
  final String? createdAt;
  final int? itemsCount;
  final String? estimatedReadyTime;

  OrderRequestedModel({
    this.orderId,
    this.customerName,
    this.chefName,
    this.status,
    this.totalAmount,
    this.createdAt,
    this.itemsCount,
    this.estimatedReadyTime,
  });

  String get displayOrderCode {
    if (orderId == null || orderId!.isEmpty) return "ORD-UNKNOWN";
    String shortId = orderId!.length > 6
        ? orderId!.substring(0, 6).toUpperCase()
        : orderId!.toUpperCase();
    return "ORD-$shortId";
  }

  String get formattedDate {
    if (createdAt == null || createdAt!.isEmpty) return "";
    try {
      DateTime dateTime = DateTime.parse(createdAt!).toLocal();
      return DateFormat('MMM d, hh:mm a').format(dateTime);
    } catch (e) {
      return createdAt!;
    }
  }

  int get remainingSecondsToCancel {
    if (createdAt == null || createdAt!.isEmpty) return 300;
    try {
      DateTime createdDate = DateTime.parse(createdAt!).toLocal();
      DateTime now = DateTime.now();
      int differenceInSeconds = now.difference(createdDate).inSeconds;
      int remaining = 300 - differenceInSeconds;
      return remaining > 0 ? remaining : 0;
    } catch (e) {
      return 300;
    }
  }

  int get remainingSecondsToPrepare {
    if (estimatedReadyTime == null || estimatedReadyTime!.isEmpty) return 0;
    try {
      final readyTime = DateTime.parse(estimatedReadyTime!).toLocal();
      final now = DateTime.now();

      final difference = readyTime.difference(now);
      return difference.inSeconds > 0 ? difference.inSeconds : 0;
    } catch (e) {
      return 0;
    }
  }

  factory OrderRequestedModel.fromJson(Map<String, dynamic> json) {
    return OrderRequestedModel(
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