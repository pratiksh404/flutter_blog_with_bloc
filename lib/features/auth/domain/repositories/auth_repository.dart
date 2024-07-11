import 'package:blog/core/error/failures.dart';
import 'package:blog/core/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signIn(
      {required String email, required String password});
  Future<Either<Failure, User>> signUp(
      {required String name, required String email, required String password});

  Future<Either<Failure, User>> currentUser();
}
