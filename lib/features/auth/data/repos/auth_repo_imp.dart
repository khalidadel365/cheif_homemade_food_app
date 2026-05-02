import 'package:cheif_homemade_food/core/models/profile_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/models/account_info.dart';
import '../../../../core/utilities/api_service.dart';
import '../models/login_model.dart';
import 'auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  AuthRepoImp(this.apiService);
  final ApiService apiService;
  @override
  Future<Either<Failure, LoginModel>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      var response = await apiService.postData(
        endpoint: '/api/auth/login/',
        data: {'email': email, 'password': password},
      );
      return right(LoginModel.fromJson(response?.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, AccountInfo>> updateProfileImage({
    required String token,
    required XFile imageProfile,
  }) async {
    final multipartFile = await MultipartFile.fromFile(
      imageProfile.path,
      filename: imageProfile.name,
    );
    try {
      final res = await apiService.postData(
        endpoint: '/api/auth/profile-picture/',
        data: FormData.fromMap({'profile_picture': multipartFile}),
        token: token,
      );

      final accountInfoModel = AccountInfo.fromJson(res!.data);

      return right(accountInfoModel);
    } on DioException catch (e) {
      print(e.toString());
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> setupProfile({
    required String? email,
    required String? password,
    required String? firstName,
    required String? lastName,
    required String? phone,
    required int yearsOfExp,
    required String bio,
    String? address = '21 Street',
  }) async {
    try {
      var response = await apiService.postData(
        endpoint: '/api/auth/signup/',
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'password': password,
          'phone_number': phone,
          'bio': bio,
          'years_of_experience': yearsOfExp,
          'address_longitude': 1.556,
          'address_latitude': 5.66,
          'user_type': "chef",
        },
      );
      return right(ProfileModel.fromJson(response?.data));
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
