import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/models/category_model.dart';
import '../../../../core/models/dish_model.dart';

abstract interface class EditDishRepo {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, DishModel>> fetchDishDetails({required int dishId});

}