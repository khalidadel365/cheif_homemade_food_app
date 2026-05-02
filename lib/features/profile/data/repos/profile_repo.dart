import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/models/profile_model.dart';
import '../../../auth/data/models/account_info.dart';
import '../models/logout_model.dart';
import '../models/toggle_chef_online_status_model.dart';

abstract interface class ProfileRepo {
  Future<Either<Failure, ProfileModel>> getChefProfile({
    required String token,
    required int? id,
  });

  Future<Either<Failure, ToggleChefOnlineStatusModel>> toggleChefStatus({
    required String token,
  });
  Future<Either<Failure, LogoutModel>> logout({required String token});
  Future<Either<Failure, ProfileModel>> editUserData(
      {required String token,
        required Map<String, dynamic> data,
        required int? id});
  Future<Either<Failure, AccountInfo>> updateProfileImage(
      {required String token, required XFile imageProfile});
}
