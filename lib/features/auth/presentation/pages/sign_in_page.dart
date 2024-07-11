import 'package:blog/core/common/widgets/loader.dart';
import 'package:blog/core/theme/palette.dart';
import 'package:blog/core/utils/app_snackbar.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blog/features/auth/presentation/widgets/gradient_button.dart';
import 'package:blog/features/auth/presentation/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Dispose controllers
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              showSnackBar(context, "Sign In Successful");
            }
          },
          builder: (context, state) {
            return state is AuthLoading
                ? const Loader()
                : Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextForm(
                          hintText: "Email",
                          controller: emailController,
                        ),
                        const SizedBox(height: 10),
                        TextForm(
                          hintText: "Password",
                          controller: passwordController,
                        ),
                        const SizedBox(height: 20),
                        GradientButton(
                          text: "Sign In",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthSignIn(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignUpPage()));
                          },
                          child: RichText(
                              text: const TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(color: Colors.white),
                                  children: [
                                TextSpan(
                                    text: " Sign Up",
                                    style: TextStyle(color: Palette.gradient2))
                              ])),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
