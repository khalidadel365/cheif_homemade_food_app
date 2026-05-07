import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/models/category_model.dart';
import '../../../../core/models/dish_model.dart';
import '../models/dish_image_model.dart';

abstract interface class EditDishRepo {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, DishModel>> fetchDishDetails({required int dishId});
  Future<Either<Failure, DishImageModel>> uploadDishImage({
    required int dishId,
    required String token,
    required XFile imageFile,
  });
  Future<Either<Failure, DishModel>> updateDish({
    required int dishId,
    required String token,
    required Map<String, dynamic> dishData,
  });
}