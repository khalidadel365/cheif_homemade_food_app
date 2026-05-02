import 'package:cheif_homemade_food/core/models/category_model.dart';
import 'package:cheif_homemade_food/core/models/dish_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utilities/api_service.dart';
import 'add_dish_repo.dart';

class AddDishRepoImp implements AddDishRepo {
  final ApiService apiService;

  AddDishRepoImp(this.apiService);

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      var response = await apiService.get(endPoint: '/api/dishes/categories/');
      List<CategoryModel> categories = [];
      for (var item in response) {
        categories.add(CategoryModel.fromJson(item));
      }

      return right(categories);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, DishModel>> addDish({
    required Map<String, dynamic> dishData,
    required String token,
  }) async {
    try {
      var response = await apiService.postData(
        endpoint: '/api/dishes/chef/',
        data: dishData,
        token: token,
      );

      return right(DishModel.fromJson(response?.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
