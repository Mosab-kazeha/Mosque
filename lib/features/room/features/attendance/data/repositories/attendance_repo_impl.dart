import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:saas_mosque/core/network/end_point.dart';
import 'package:saas_mosque/features/room/features/attendance/data/model/attendace_model.dart';
import 'package:saas_mosque/features/room/features/attendance/data/repositories/attendance_repo.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/dio_helper.dart';

class AttendanceRepoImpl extends AttendanceRepo {
  final DioHelper _dioHelper;

  AttendanceRepoImpl(DioHelper dioHelper) : _dioHelper = dioHelper;
  @override
  Future<Either<Failure, void>> sendAttendance(
    List<AttendanceModel> attendence,
  ) async {
    try {

      final  payload = attendence.map((e) => e.toJson()).toList();
      final Response response = await _dioHelper.postData(
        url: EndPoint.getAttendance,
        data: payload,
      );

      log("Send Attendance Success: ${response.data}");

     
      return right(null);
    } catch (e) {
      log("Send Attendence Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
