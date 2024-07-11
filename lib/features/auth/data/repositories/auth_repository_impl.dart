import 'package:fpdart/src/either.dart';

import 'package:blog/core/error/exceptions.dart';
import 'package:blog/core/error/failures.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog/core/entities/user.dart';
import 'package:blog/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, User>> signIn(
      {required String email, required String password}) async {
    return _getUser(() async =>
        await authRemoteDataSource.signIn(email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUp(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(() async => await authRemoteDataSource.signUp(
        name: name, email: email, password: password));
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final User user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final User? user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not found'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
