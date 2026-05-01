import 'package:cheif_homemade_food/features/home/data/models/dishes_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utilities/api_service.dart';
import '../../../../core/utilities/service_locator.dart';
import 'home_repo.dart';

class HomeRepoImp implements HomeRepo {
  @override
  Future<Either<Failure, DishesResponseModel>> getChefDishes({
    required String token,
  }) async {
    try {
      var response = await getIt.get<ApiService>().get(
        endPoint: '/api/dishes/chef/',
        token: token,
      );
      return right(DishesResponseModel.fromJson(response));
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}