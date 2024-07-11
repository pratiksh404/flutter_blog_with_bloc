import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/core/entities/user.dart';
import 'package:blog/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class SignIn implements UseCase<User, SignInParams> {
  final AuthRepository authRepository;

  SignIn({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    return await authRepository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}
