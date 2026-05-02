import 'package:cheif_homemade_food/core/errors/failures.dart';
import 'package:cheif_homemade_food/core/models/profile_model.dart';
import 'package:cheif_homemade_food/features/profile/data/models/toggle_chef_online_status_model.dart';
import 'package:cheif_homemade_food/features/profile/data/repos/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/utilities/api_service.dart';
import '../models/logout_model.dart';

class ProfileRepoImp implements ProfileRepo {
  final ApiService apiService;

  ProfileRepoImp(this.apiService);

  @override
  Future<Either<Failure, ProfileModel>> getChefProfile({
    required String token,
    required int? id,
  }) async {
    try {
      final data = await apiService.get(
        endPoint: '/api/auth/profile/$id/',
        token: token,

      );

      var profileModel = ProfileModel.fromJson(data);

      return right(profileModel);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ToggleChefOnlineStatusModel>> toggleChefStatus({
    required String token,
  }) async {
    try {
      final response = await apiService.postData(
        endpoint: '/api/auth/chef/toggle-online/',
        token: token,
        data: {},
      );

      if (response?.data != null && response?.data is Map<String, dynamic>) {
        var result = ToggleChefOnlineStatusModel.fromJson(response!.data);
        return right(result);
      } else {
        return left(ServerFailure("Unexpected response format from server"));
      }

    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
  @override
  Future<Either<Failure, LogoutModel>> logout({required String token}) async {
    try {
      var data = await apiService.postData(
        endpoint: '/api/auth/logout/',
        token: token,
      );
      return Right(LogoutModel.fromJson(data!.data));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
