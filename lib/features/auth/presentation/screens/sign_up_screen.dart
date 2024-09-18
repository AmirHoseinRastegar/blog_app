import 'package:blog_app/core/constants/loading.dart';
import 'package:blog_app/core/utils/snakbar.dart';
import 'package:blog_app/features/auth/presentation/screens/login_screen.dart';
import 'package:blog_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/pallet.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../blocs/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  static rout() =>
      MaterialPageRoute(builder: (context) => const SignUpScreen());

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                return snakBar(context, state.message);
              } else if (state is AuthSuccess) {
                Navigator.pushAndRemoveUntil(
                    context, SignUpScreen.rout(), (route) => false);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const AppLoader();
              }
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                          hintText: 'Name', controller: _nameController),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          hintText: 'email', controller: _emailController),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          hintText: 'Password',
                          controller: _passwordController),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          title: 'Sign Up',

                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthSignUpEvent(
                                      email: _emailController.text.trim(),
                                      name: _nameController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
                                  );
                            }
                          }),
                      const SizedBox(
                        height: 200,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, LoginScreen.rout());
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account?  ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: 'Sign In',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Pallet.gradient2,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
