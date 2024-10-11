import 'package:blog_app/core/constants/loading.dart';
import 'package:blog_app/core/widgets/custom_app_bar.dart';
import 'package:blog_app/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/snakbar.dart';

class MainProfileScreen extends StatefulWidget {
  const MainProfileScreen({super.key});

  @override
  State<MainProfileScreen> createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AuthBloc, AuthStates>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const AppLoader();
          } else if (state is AuthError) {
            snakBar(context, state.message);
          }
          return Scaffold(
            appBar: const CustomAppBar(),
            body: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/favorite_posts');
                        },
                        child: const Text('Favorite Posts'),),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'name : ${state is AuthSuccess ? state.user.name : 'unKnown'}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              'email : ${state is AuthSuccess ? state.user.email : 'unKnown'}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  title: const Text('Sign Out'),
                                  content: const Text(
                                      'Are you sure you want to sign out?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          BlocProvider.of<AuthBloc>(context)
                                              .add(AuthSignOutEvent());

                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  LoginScreen.rout(),
                                                  (route) => false);
                                        },
                                        child: const Text('Sign Out')),
                                  ]);
                            });
                      },
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
