import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:saas_mosque/core/error/failure.dart';
import 'package:saas_mosque/core/network/dio_helper.dart';
import 'package:saas_mosque/core/network/end_point.dart';
import 'package:saas_mosque/features/splash/data/repositories/splash_repo.dart';
import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SplashRepoImpl extends SplashRepo {
  final DioHelper _dioHelper;

  SplashRepoImpl(DioHelper dioHelper) : _dioHelper = dioHelper;

  @override
  Future<Either<Failure, void>> getProfile() async {
    try {
      final token = serviceLocater.get<SharedPreferences>().getString('token');
      if (token != null) {
        final response = await _dioHelper.postData(
          url: EndPoint.profile,
          token: token,
        );
        log("Get Profile Success: ${response.data}");
        log("Profile Response Full Data: ${response.data}");

        final teacherId = response.data['id'];
        log("Teacher ID from profile response: $teacherId");

        await serviceLocater.get<SharedPreferences>().setString(
          "teacher-id",
          teacherId.toString(),
        );

        // Verify teacher-id was saved
        final savedTeacherId = serviceLocater
            .get<SharedPreferences>()
            .getString("teacher-id");
        log("Teacher ID saved to SharedPreferences: $savedTeacherId");

        return right(null);
      }
      throw Exception('Tkoen is null');
    } catch (e) {
      log("Get Profile Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
