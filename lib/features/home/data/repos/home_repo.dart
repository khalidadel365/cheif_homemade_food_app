import 'package:cheif_homemade_food/core/models/dish_model.dart';
import 'package:cheif_homemade_food/features/home/data/models/dishes_response_model.dart';
import 'package:cheif_homemade_food/features/home/data/models/order_model.dart';
import 'package:cheif_homemade_food/features/home/data/models/update_order_status_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract interface class HomeRepo {
  void initOrdersSocket({required String token});

  Stream<dynamic> listenToOrders();

  void closeSocket();

  Future<Either<Failure, List<OrderModel>>> getOrders({
    required String token,
    required String status,
  });

  Future<Either<Failure, DishesResponseModel>> getChefDishes({
    required String token,
  });

  Future<Either<Failure, void>> deleteChefDish({
    required String token,
    required int dishId,
  });
  Future<Either<Failure, UpdateOrderStatusModel>> updateOrderStatus({
    required String token,
    required String orderId,
    required String status,
  });
  Future<Either<Failure, DishModel>> changeDishAvailability({
    required String token,
    required int dishId,
    required bool isAvailable,
  });
}
