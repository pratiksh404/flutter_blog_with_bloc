import 'package:blog/features/auth/domain/usecases/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUp _signUp;
  AuthBloc({required SignUp signUp})
      : _signUp = signUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final response = await _signUp(SignUpParams(
          name: event.name, email: event.email, password: event.password));

      response.fold(
          (l) => emit(AuthFailure(l.message)), (uid) => emit(AuthSuccess(uid)));
    });
  }
}
