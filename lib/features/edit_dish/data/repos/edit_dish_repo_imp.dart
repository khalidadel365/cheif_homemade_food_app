import 'package:cheif_homemade_food/core/errors/failures.dart';
import 'package:cheif_homemade_food/core/models/category_model.dart';
import 'package:cheif_homemade_food/core/utilities/api_service.dart';
import 'package:cheif_homemade_food/features/edit_dish/data/repos/edit_dish_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/models/dish_model.dart';

class EditDishRepoImp implements EditDishRepo{
  final ApiService apiService;
  EditDishRepoImp(this.apiService);

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
  Future<Either<Failure, DishModel>> fetchDishDetails(
      {required int dishId}) async {
    try {
      var data = await apiService.get(
        endPoint: '/api/dishes/$dishId/',
      );
      DishModel dish = DishModel.fromJson(data);
      return right(dish);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}