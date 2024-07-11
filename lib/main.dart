import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blog/core/init_dependencies.dart';
import 'package:blog/core/theme/theme.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/pages/sign_in_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

// Dependencies initialization
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthCheck());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          return isLoggedIn
              ? const Scaffold(
                  body: const Center(child: const Text('Logged In')))
              : const SignInPage();
        },
      ),
    );
  }
}
