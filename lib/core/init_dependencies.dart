import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:blog/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog/features/auth/domain/usecases/current_user.dart';
import 'package:blog/features/auth/domain/usecases/sign_in.dart';
import 'package:blog/features/auth/domain/usecases/sign_up.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Dependencies
  _dependencies();
  // Env initialization
  await dotenv.load(fileName: ".env");

  // Firebase initialization
  final supabase = await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_KEY'),
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  // Core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

// Dependencies
void _dependencies() {
  _initAuth();
}

// Auth
void _initAuth() {
  // Auth data source dependencies
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() =>
        AuthRemoteDataSourceImpl(client: serviceLocator<SupabaseClient>()))
    // Auth repository dependencies
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
          authRemoteDataSource: serviceLocator<AuthRemoteDataSource>(),
        ))
    // SignUp usecase dependencies
    ..registerFactory(
      () => SignUp(
        authRepository: serviceLocator<AuthRepository>(),
      ),
    )
    // SignIn usecase dependencies
    ..registerFactory(
      () => SignIn(
        authRepository: serviceLocator<AuthRepository>(),
      ),
    )
    // Current User usecase dependencies
    ..registerFactory(
      () => CurrentUser(authRepository: serviceLocator<AuthRepository>()),
    )
    // Auth bloc dependencies
    ..registerLazySingleton(
      () => AuthBloc(
        signUp: serviceLocator<SignUp>(),
        signIn: serviceLocator<SignIn>(),
        currentUser: serviceLocator<CurrentUser>(),
        appUserCubit: serviceLocator<AppUserCubit>(),
      ),
    );
}
