import 'package:cheif_homemade_food/core/models/dish_model.dart';
import 'package:cheif_homemade_food/features/home/data/models/dishes_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract interface class HomeRepo {
  Future<Either<Failure, DishesResponseModel>> getChefDishes({
    required String token,
  });

  Future<Either<Failure, void>> deleteChefDish({
    required String token,
    required int dishId,
  });

  Future<Either<Failure, DishModel>> changeDishAvailability({
    required String token,
    required int dishId,
    required bool isAvailable,
  });
}
