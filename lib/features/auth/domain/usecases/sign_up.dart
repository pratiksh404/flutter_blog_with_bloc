import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class SignUp implements UseCase<String, SignUpParams> {
  final AuthRepository authRepository;

  SignUp({required this.authRepository});
  @override
  Future<Either<Failure, String>> call(SignUpParams params) async {
    return await authRepository.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams {
  final String name;
  final String email;
  final String password;

  SignUpParams(
      {required this.name, required this.email, required this.password});
}
