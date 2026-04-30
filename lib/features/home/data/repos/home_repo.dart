import 'package:cheif_homemade_food/core/models/dish_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';


abstract interface class HomeRepo {
  Future<Either<Failure, DishModel>> getChefDishes({
    required String token,
  });

}
