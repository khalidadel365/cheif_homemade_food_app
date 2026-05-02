import 'package:cheif_homemade_food/core/models/category_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract interface class AddDishRepo {
  Future<Either<Failure, List<CategoryModel>>> getCategories({
    required String token,
  });

}
