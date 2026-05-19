import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utilities/api_service.dart';
import '../models/order_details_model.dart';
import 'order_details_repo.dart';

class OrderDetailsRepoImpl implements OrderDetailsRepo {
  final ApiService apiService;

  OrderDetailsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, OrderDetailsModel>> getOrderDetails({
    required String token,
    required String orderId,
  }) async {
    try {
      var data = await apiService.get(
        endPoint: '/api/orders/$orderId/',
        token: token,
      );

      return right(OrderDetailsModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}