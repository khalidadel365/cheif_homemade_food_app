import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/models/profile_model.dart';
import '../models/toggle_chef_online_status_model.dart';

abstract interface class ProfileRepo {
  Future<Either<Failure, ProfileModel>> getChefProfile({
    required String token,
    required int? id,
  });

  Future<Either<Failure, ToggleChefOnlineStatusModel>> toggleChefStatus({
    required String token,
  });
}
