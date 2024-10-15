import 'package:blog_app/core/connection_checker/connection_checker.dart';
import 'package:blog_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/auth_signin_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/auth_signup_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/session_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:blog_app/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:blog_app/features/blog/data/data_source/blog_data_source.dart';
import 'package:blog_app/features/blog/data/data_source/local_blog_data_source.dart';
import 'package:blog_app/features/blog/data/repository/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/entites/hive_manager.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:blog_app/features/bookmark/data/repository/bookmark_repositoryimpl.dart';
import 'package:blog_app/features/bookmark/domain/repository/bookmark_repository.dart';
import 'package:blog_app/features/bookmark/domain/use_cases/get_all_bookmarks_usecase.dart';
import 'package:blog_app/features/bookmark/domain/use_cases/toggle_bookmark_usecase.dart';

import 'package:blog_app/features/profile/presentation/bloc/bottom_nav_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/constants/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/cubit/presist_user_login_cubit/persist_login_cubit.dart';
import 'core/cubit/toggle_password_obsecure_cubit/obsecure_password_cubit.dart';
import 'features/bookmark/data/data_source/local_bookmark_data_source.dart';
import 'features/bookmark/domain/entities/bookmark_entity.dart';
import 'features/bookmark/presentation/bloc/bookmark_bloc.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // Initialize Hive
  Hive.initFlutter();

  // Register the adapter and box
  Hive.registerAdapter(BookMarkEntityAdapter());

  _onAuthLocators();

  final supabaseClient = await Supabase.initialize(
    url: Constants.supaBaseUrl,
    anonKey: Constants.supaBaseAnonKey,
  );
  locator.registerLazySingleton(() => supabaseClient.client);
  locator.registerFactory(() => InternetConnection());

  locator.registerLazySingleton<Box>(() => HiveManager.box);

  locator.registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(locator()));
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
      connectionChecker: locator(),
    ),
  );
  locator.registerSingletonAsync<Box<BookMarkEntity>>(() async {
    return await Hive.openBox<BookMarkEntity>('bookmarks');
  });
  locator.registerSingletonWithDependencies<BookmarkRepository>(
        () => BookMarkRepositoryImpl(
      locator<Box<BookMarkEntity>>(),
      localDataSource: locator(),
    ),
    dependsOn: [Box<BookMarkEntity>], // Ensure the box is ready before registering the repository
  );

  locator.registerFactory(
    () => SignUpUseCase(
      locator(),
    ),
  );
  locator.registerFactory(
    () => ToggleBookmarkUseCase(
      locator(),
    ),
  );
  locator.registerFactory(
    () => GetBookmarksUseCase(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SignOutUseCase(
      authRepository: locator(),
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
    () => GetAllBlogsUseCase(blogRepository: locator()),
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
  locator.registerFactory<LocalBlogDataSource>(
    () => LocalBlogDataSourceImpl(
      locator(),
    ),
  );  locator.registerFactory<BookmarkLocalDataSource>(
    () => BookmarkLocalDataSourceImpl(
       box:  locator<Box<BookMarkEntity>>(),
    ),
  );

  locator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(
      locator(),
      locator(),
      locator(),
    ),
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
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => BlogBloc(
      locator(),
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => BookmarkBloc(
      locator(),
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
