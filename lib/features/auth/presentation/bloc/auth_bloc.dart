import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/core/entities/user.dart';
import 'package:blog/features/auth/domain/usecases/current_user.dart';
import 'package:blog/features/auth/domain/usecases/sign_in.dart';
import 'package:blog/features/auth/domain/usecases/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUp _signUp;
  final SignIn _signIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc(
      {required SignUp signUp,
      required SignIn signIn,
      required CurrentUser currentUser,
      required AppUserCubit appUserCubit})
      : _signUp = signUp,
        _signIn = signIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));

    on<AuthSignUp>(_onAuthSignUp);

    on<AuthSignIn>(_onAuthSignIn);

    on<AuthCheck>(_isUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    // Auth Signup process
    final response = await _signUp(SignUpParams(
        name: event.name, email: event.email, password: event.password));

    response.fold((l) => emit(AuthFailure(l.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    // Auth Signin process
    final response = await _signIn(
        SignInParams(email: event.email, password: event.password));
    response.fold((l) => emit(AuthFailure(l.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _isUserLoggedIn(AuthCheck event, Emitter<AuthState> emit) async {
    final response = await _currentUser(NoParams());
    response.fold((l) => emit(AuthFailure(l.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> state) {
    emit(AuthSuccess(user));
    _appUserCubit.updateUser(user);
  }
}
