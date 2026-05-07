import 'package:cheif_homemade_food/core/errors/failures.dart';
import 'package:cheif_homemade_food/core/models/category_model.dart';
import 'package:cheif_homemade_food/core/utilities/api_service.dart';
import 'package:cheif_homemade_food/features/edit_dish/data/repos/edit_dish_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/models/dish_model.dart';
import '../models/dish_image_model.dart';

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
  @override
  Future<Either<Failure, DishModel>> updateDish({
    required int dishId,
    required Map<String, dynamic> dishData,
    required String token,
  }) async {
    try {
      var response = await apiService.patchData(
        endpoint: '/api/dishes/chef/$dishId/',
        data: dishData,
        token: token,
      );
      return right(DishModel.fromJson(response?.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
  @override
  Future<Either<Failure, DishImageModel>> uploadDishImage({
    required int dishId,
    required String token,
    required XFile imageFile,
  }) async {
    final multipartFile = await MultipartFile.fromFile(
      imageFile.path,
      filename: imageFile.name,
    );

    try {
      final res = await apiService.postData(
        endpoint: '/api/dishes/$dishId/images/create/',
        token: token,
        data: FormData.fromMap({
          'image': multipartFile,
          'is_primary': true,
        }),
      );

      final uploadedImage = DishImageModel.fromJson(res!.data);

      print('Image uploaded successfully');
      return right(uploadedImage);

    } on DioException catch (e) {
      print(e.toString());
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }
}