import 'package:blog/features/auth/domain/entities/user.dart';
import 'package:blog/features/auth/domain/usecases/sign_in.dart';
import 'package:blog/features/auth/domain/usecases/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUp _signUp;
  final SignIn _signIn;
  AuthBloc({required SignUp signUp, required SignIn signIn})
      : _signUp = signUp,
        _signIn = signIn,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);

    on<AuthSignIn>(_onAuthSignIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    // Loading State emitted
    emit(AuthLoading());
    // Auth Signup process
    final response = await _signUp(SignUpParams(
        name: event.name, email: event.email, password: event.password));

    response.fold(
        (l) => emit(AuthFailure(l.message)), (user) => emit(AuthSuccess(user)));
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    // Loading state emitted
    emit(AuthLoading());
    // Auth Signin process
    final response = await _signIn(
        SignInParams(email: event.email, password: event.password));
    response.fold(
        (l) => emit(AuthFailure(l.message)), (user) => emit(AuthSuccess(user)));
  }
}
