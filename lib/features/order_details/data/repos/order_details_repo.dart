import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../models/order_details_model.dart';

abstract class OrderDetailsRepo {
  Future<Either<Failure, OrderDetailsModel>> getOrderDetails({
    required String token,
    required String orderId,
  });
}