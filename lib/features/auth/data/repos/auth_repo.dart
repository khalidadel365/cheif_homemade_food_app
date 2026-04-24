import 'package:cheif_homemade_food/core/models/profile_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../models/login_model.dart';


abstract class AuthRepo {
  Future<Either<Failure, ProfileModel>> setupProfile({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
    required int yearsOfExp,
    required String bio,
    String? address = '21 Street',
  });

  Future<Either<Failure, LoginModel>> loginUser({
    required String email,
    required String password,
  });
}
