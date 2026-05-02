import 'package:cheif_homemade_food/core/models/category_model.dart';
import 'package:cheif_homemade_food/core/models/dish_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract interface class AddDishRepo {
  Future<Either<Failure, List<CategoryModel>>> getCategories();

  Future<Either<Failure, DishModel>> addDish({
    required Map<String, dynamic> dishData,
    required String token,
  });
}
