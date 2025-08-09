import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:saas_mosque/core/network/end_point.dart';
import 'package:saas_mosque/features/room/features/home/presentation/data/model/home_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../../core/error/failure.dart';
import '../../../../../../../core/network/dio_helper.dart';
import '../../../../../../../injection_container.dart';
import 'home_repo.dart';

final class HomeRepoImpl extends HomeRepo {
  final DioHelper _dioHelper;

  HomeRepoImpl(DioHelper dioHelper) : _dioHelper = dioHelper;

  @override
  Future<Either<Failure, HomeDataModel>> fetchHomeData() async {
    try {
      final teacherId = serviceLocater.get<SharedPreferences>().getInt(
        'teacher_id',
      );
      print("انا محفوظ بال كاش${teacherId}");
      final response = await _dioHelper.getData(
        url: EndPoint.home + teacherId!.toString(),
      );
      log("Login Success: ${response.data}");

      return right(HomeDataModel.fromJson(response.data));
    } catch (e) {
      log("Login Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}

// Future<MainDataModel> fetchMainData() async {
//   final teacherId = await SessionManager.getTeacherId(); // 🔥 نحصل على ID
//   print("انا محفوظ بال كاش${teacherId}");
//   if (teacherId == null) {
//     throw Exception("Teacher ID is null. Please login again.");
//   }

//   final response = await dio.get(
//     '${AppConstants.baseUrl}/teachers/mobile/$teacherId',
//   );
//   return MainDataModel.fromJson(response.data);
// }
