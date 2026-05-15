import 'package:cheif_homemade_food/core/models/dish_model.dart';
import 'package:cheif_homemade_food/features/home/data/models/dishes_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utilities/api_service.dart';
import '../service/orders_socket_service.dart';
import 'home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final ApiService apiService;
  final OrdersSocketService socketService;
  HomeRepoImp(this.apiService, this.socketService);

  @override
  void initOrdersSocket({required String token}) {
    //start connection with server
    //const String socketUrl = 'wss://homemadefood.onrender.com/ws/orders/';
    const String socketUrl = 'ws://localhost:8000/ws/orders/';
    socketService.connect('$socketUrl?token=$token');
  }

  @override
  Stream<dynamic> listenToOrders() {
    return socketService.stream;
  }

  @override
  Future<Either<Failure, DishesResponseModel>> getChefDishes({
    required String token,
  }) async {
    try {
      var response = await apiService.get(
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

  @override
  void closeSocket() {
    socketService.close();
  }

  @override
  Future<Either<Failure, void>> deleteChefDish({
    required String token,
    required int dishId,
  }) async {
    try {
      var response = await apiService.delete(
        endPoint: '/api/dishes/chef/$dishId/',
        token: token,
      );
      return right(null);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, DishModel>> changeDishAvailability({
    required String token,
    required int dishId,
    required bool isAvailable,
  }) async {
    try {
      var response = await apiService.patchData(
        endpoint: '/api/dishes/chef/$dishId/',
        token: token,
        data: {"is_available": isAvailable},
      );
      return right(DishModel.fromJson(response?.data ?? {}));
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
