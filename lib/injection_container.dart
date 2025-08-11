import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:saas_mosque/features/auth/data/repositories/auth_repo.dart';
import 'package:saas_mosque/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:saas_mosque/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:saas_mosque/features/groups/data/repositories/groups_repo.dart';
import 'package:saas_mosque/features/groups/data/repositories/groups_repo_impl.dart';
import 'package:saas_mosque/features/groups/presentation/bloc/groups_bloc.dart';
import 'package:saas_mosque/features/room/features/attendance/data/repositories/attendance_repo.dart';
import 'package:saas_mosque/features/room/features/attendance/data/repositories/attendance_repo_impl.dart';
import 'package:saas_mosque/features/room/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:saas_mosque/features/room/features/listening/data/repositories/listening_repo.dart';
import 'package:saas_mosque/features/room/features/listening/data/repositories/listening_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/dio_helper.dart';
import 'features/campaigns/data/repositories/campaigns_repo.dart';
import 'features/campaigns/data/repositories/campaigns_repo_impl.dart';
import 'features/campaigns/presentation/bloc/campaigns_bloc.dart';

final serviceLocater = GetIt.instance;

void init() async {
  
  serviceLocater.registerSingleton(await SharedPreferences.getInstance());
  
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

  serviceLocater.registerLazySingleton<AuthRepo>(() {
    return AuthRepoImpl(serviceLocater());
  });

  serviceLocater.registerLazySingleton(() => AuthBloc(serviceLocater()));

  serviceLocater.registerLazySingleton<CampaignsRepo>(() {
    return CampaignsRepoImpl(serviceLocater());
  });

  serviceLocater.registerLazySingleton(() => CampaignsBloc(serviceLocater()));

  serviceLocater.registerLazySingleton<GroupsRepo>(() {
    return GroupsRepoImpl(serviceLocater());
  });

  serviceLocater.registerLazySingleton(() => GroupsBloc(serviceLocater()));

  serviceLocater.registerLazySingleton<AttendanceRepo>(() {
    return AttendanceRepoImpl(serviceLocater());
  });

  serviceLocater.registerLazySingleton(() => AttendanceBloc(serviceLocater()));

  serviceLocater.registerLazySingleton<ListeningRepo>(() {
    return ListeningRepoImpl(serviceLocater());
  });

  // serviceLocater.registerLazySingleton<HomeRepo>(() {
  //   return HomeRepoImpl(serviceLocater());
  // });

  // serviceLocater.registerLazySingleton(() => HomeBloc(serviceLocater()));
}
