import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utilities/api_service.dart';
import '../../../../core/utilities/service_locator.dart';
import '../models/login_model.dart';
import '../models/signup_model.dart';
import 'auth_repo.dart';

class AuthRepoImp extends AuthRepo {
  @override
  Future<Either<Failure, LoginModel>> LoginUser({
    required String email,
    required String password,
  })async {
    try {
      var response =await getIt.get<ApiService>().postData(
          endpoint: '/api/auth/login/',
          data: {
            'email': email,
            'password': password,
          });
      return right(LoginModel.fromJson(response?.data));
          } on Exception catch (e) {
      if(e is DioException){
        return left(ServerFailure.fromDioException(e));
      }else{
        return left(ServerFailure(e.toString()));
      }
    }
    }
  @override
  Future<Either<Failure, SignUpModel>> SignupUser({
    required String? email,
    required String? password,
    required String? firstName,
    required String? lastName,
    required String? phone}) async {
    try {
      var response = await getIt
          .get<ApiService>()
          .postData(endpoint: '/api/auth/signup/', data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'phone_number': phone,
        'address_longitude': 1.556,
        'address_latitude': 5.66,
        'user_type': "chef",
      });
      return right(SignUpModel.fromJson(response?.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
