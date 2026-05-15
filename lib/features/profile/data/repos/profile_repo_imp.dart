import 'package:cheif_homemade_food/core/errors/failures.dart';
import 'package:cheif_homemade_food/core/models/profile_model.dart';
import 'package:cheif_homemade_food/features/profile/data/models/toggle_chef_online_status_model.dart';
import 'package:cheif_homemade_food/features/profile/data/repos/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utilities/api_service.dart';
import '../../../auth/data/models/account_info.dart';
import '../models/logout_model.dart';
import '../models/password_confirm_model.dart';
import '../models/password_reset_request_model.dart';

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
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> editUserData({
    required String token,
    required Map<String, dynamic> data,
    required int? id,
  }) async {
    Map<String, dynamic> finalBody = {};
    Map<String, dynamic> userFields = {};

    if (data.containsKey("first_name"))
      userFields["first_name"] = data["first_name"];
    if (data.containsKey("last_name"))
      userFields["last_name"] = data["last_name"];
    if (data.containsKey("phone_number"))
      userFields["phone_number"] = data["phone_number"];
    if (data.containsKey("email")) userFields["email"] = data["email"];

    if (userFields.isNotEmpty) {
      finalBody["user"] = userFields;
    }

    if (data.containsKey("bio")) finalBody["bio"] = data["bio"];
    if (data.containsKey("years_of_experience"))
      finalBody["years_of_experience"] = data["years_of_experience"];

    try {
      final res = await apiService.patchData(
        endpoint: '/api/auth/profile/$id/',
        data: finalBody,
        token: token,
      );

      final profileModel = ProfileModel.fromJson(res!.data);
      return right(profileModel);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  late PasswordResetRequestModel passwordResetMessage;

  @override
  Future<Either<Failure, PasswordResetRequestModel>> resetPasswordRequest({
    required String token,
    required String email,
  }) async {
    try {
      final res = await apiService.postData(
        endpoint: '/api/auth/password-reset/',
        data: {'email': email},
        token: token,
      );

      passwordResetMessage = PasswordResetRequestModel.fromJson(res!.data);

      return right(passwordResetMessage);
    } on DioException catch (e) {
      print(e.toString());
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PasswordConfirmModel>> confirmPassword({
    required String password,
  }) async {
    String uid = passwordResetMessage.uId!;
    String token = passwordResetMessage.token!;
    print(passwordResetMessage.uId!);
    print(passwordResetMessage.token!);
    try {
      final res = await apiService.postData(
        endpoint: '/api/auth/password-reset-confirm/',
        data: {"uid": uid, "token": token, "new_password": password},
      );

      final passwordConfirm = PasswordConfirmModel.fromJson(res!.data);

      return right(passwordConfirm);
    } on DioException catch (e) {
      print(e.toString());
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
