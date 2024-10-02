import 'package:blog_app/core/connection_checker/connection_checker.dart';
import 'package:blog_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/auth_signin_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/auth_signup_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/session_usecase.dart';
import 'package:blog_app/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:blog_app/features/blog/data/data_source/blog_data_source.dart';
import 'package:blog_app/features/blog/data/repository/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:blog_app/features/profile/presentation/bloc/bottom_nav_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/constants/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/cubit/presist_user_login_cubit/persist_login_cubit.dart';
import 'core/cubit/toggle_password_obsecure_cubit/obsecure_password_cubit.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final supabaseClient = await Supabase.initialize(
    url: Constants.supaBaseUrl,
    anonKey: Constants.supaBaseAnonKey,
  );
  locator.registerLazySingleton(() => supabaseClient.client);
  locator.registerFactory(() => InternetConnection());

  locator.registerLazySingleton<ConnectionChecker>(() => ConnectionCheckerImpl(locator()));
  _onAuthLocators();
}

void _onAuthLocators() {
  locator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerFactory(
    () => SignUpUseCase(
      locator(),
    ),
  );
  locator.registerFactory(
    () => BottomNavCubit(),
  );

  locator.registerFactory(
    () => LoginUseCase(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SessionUseCase(
      repository: locator(),
    ),
  );
  locator.registerFactory<BlogDataSource>(
    () => BlogDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(locator(), locator()),
  );
  locator.registerFactory(
    () => UploadBlogUseCase(
      locator(),
    ),
  );

  locator.registerFactory(
    () => AuthBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => BlogBloc(
      locator(),
    ),
  );
  locator.registerLazySingleton<ObscurePasswordCubit>(
    () => ObscurePasswordCubit(),
  );
  locator.registerLazySingleton<PersistLoginCubit>(
    () => PersistLoginCubit(),
  );
}
