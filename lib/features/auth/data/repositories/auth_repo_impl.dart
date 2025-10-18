import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:saas_mosque/core/error/failure.dart';
import 'package:saas_mosque/core/network/dio_helper.dart';
import 'package:saas_mosque/core/network/end_point.dart';
import 'package:saas_mosque/features/auth/data/repositories/auth_repo.dart';
import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AuthRepoImpl extends AuthRepo {
  final DioHelper _dioHelper;

  AuthRepoImpl(DioHelper dioHelper) : _dioHelper = dioHelper;

  @override
  Future<Either<Failure, void>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _dioHelper.postData(
        url: EndPoint.login,
        data: {'mobile_phone_number': phone, 'password': password},
      );
      log("Login Success: ${response.data}");
      log("Login Response Full Data: ${response.data}");

      // Check if teacher-id is in login response
      if (response.data['id'] != null) {
        log("Teacher ID found in login response: ${response.data['id']}");
      } else {
        log("Teacher ID NOT found in login response");
      }

      final token = response.data['access_token'];
      if (token != null) {
        await serviceLocater.get<SharedPreferences>().setString('token', token);
        log("Token saved successfully: $token");
      } else {
        log("Token is null in login response");
      }
      return right(null);
    } catch (e) {
      log("Login Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
