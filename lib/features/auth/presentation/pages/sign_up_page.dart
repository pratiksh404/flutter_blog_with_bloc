import 'package:blog/core/theme/palette.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/pages/sign_in_page.dart';
import 'package:blog/features/auth/presentation/widgets/gradient_button.dart';
import 'package:blog/features/auth/presentation/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Dispose controllers
  @override
  void dispose() {
    nameController.dispose();
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
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextForm(
                hintText: "Name",
                controller: nameController,
              ),
              const SizedBox(height: 10),
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
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                            AuthSignUp(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                    }
                  },
                  text: "Sign Up"),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SignInPage()));
                },
                child: RichText(
                    text: const TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.white),
                        children: [
                      TextSpan(
                          text: " Sign In",
                          style: TextStyle(color: Palette.gradient2))
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
