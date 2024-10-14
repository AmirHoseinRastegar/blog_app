import 'package:blog_app/core/cubit/presist_user_login_cubit/persist_login_cubit.dart';
import 'package:blog_app/features/blog/domain/entites/hive_manager.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:blog_app/features/bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:blog_app/features/profile/presentation/bloc/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'core/cubit/toggle_password_obsecure_cubit/obsecure_password_cubit.dart';
import 'core/theme/theme.dart';
import 'features/auth/presentation/blocs/auth_bloc.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'locator.dart';
import 'main_wrapper.dart';

void main() async {
  await HiveManager.init();
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => locator<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => locator<BookmarkBloc>(),
      ),
      BlocProvider(
        create: (context) => locator<ObscurePasswordCubit>(),
      ),
      BlocProvider(
        create: (context) => locator<PersistLoginCubit>(),
      ),
      BlocProvider(
        create: (context) => locator<BottomNavCubit>(),
      ),
      BlocProvider(
        create: (context) => locator<BlogBloc>(),
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
    context.read<AuthBloc>().add(IsUserLoggedInEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        home: BlocSelector<PersistLoginCubit, PersistLoginState, bool>(
          selector: (state) {
            return state is PersistLoginCubit;
          },
          builder: (context, isLoggedIn) {
            if (isLoggedIn) {
              return MainWrapper2();
            } else {
              return const LoginScreen();
            }
          },
        ));
  }
}
