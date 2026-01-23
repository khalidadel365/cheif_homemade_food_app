import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';import '../models/login_model.dart';

import '../models/signup_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, SignUpModel>> SignupUser({
    required String? email,
    required String? password,
    required String? firstName,
    required String? lastName,
    required String? phone,
  });

  Future<Either<Failure, LoginModel>> LoginUser({
    required String email,
    required String password,
});
}
