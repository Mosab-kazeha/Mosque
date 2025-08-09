import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:saas_mosque/features/auth/data/repositories/auth_repo.dart';
import 'package:saas_mosque/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:saas_mosque/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/dio_helper.dart';

final serviceLocater = GetIt.instance;

void init() async {
  serviceLocater.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://halakat-backend.vercel.app',
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    ),
  );

  serviceLocater.registerLazySingleton<DioHelper>(
    () => DioHelper(serviceLocater()),
  );

  serviceLocater.registerSingleton(await SharedPreferences.getInstance());

  serviceLocater.registerLazySingleton<AuthRepo>(() {
    return AuthRepoImpl(serviceLocater());
  });

  serviceLocater.registerLazySingleton(() => AuthBloc(serviceLocater()));
}
