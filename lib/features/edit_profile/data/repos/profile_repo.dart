import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/models/profile_model.dart';

abstract interface class ProfileRepo {
  Future<Either<Failure, ProfileModel>> getChefProfile({
    required String token,
    required int? id,
  });
}
