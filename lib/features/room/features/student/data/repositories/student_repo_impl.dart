import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:saas_mosque/core/error/failure.dart';
import 'package:saas_mosque/core/network/end_point.dart';
import 'package:saas_mosque/features/room/data/model/student_model.dart';
import 'package:saas_mosque/features/room/features/attendance/data/model/attendace_model.dart';
import 'package:saas_mosque/features/room/features/listening/data/models/listening_model.dart';
import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/network/dio_helper.dart';
import 'student_repo.dart';

class StudentRepoImpl extends StudentRepo {
  final DioHelper _dioHelper;

  StudentRepoImpl(DioHelper dioHelper) : _dioHelper = dioHelper;
  @override
  Future<Either<Failure, List<AttendanceModel>>> fetchAttendance({
    required int studentId,
  }) async {
    try {
      final int? groupId = serviceLocater.get<SharedPreferences>().getInt(
        'group-id',
      );
      final int? campainId = serviceLocater.get<SharedPreferences>().getInt(
        'campaign-id',
      );
      final Response response = await _dioHelper.getData(
        url: EndPoint.studentAttendance(
          groupId: groupId!,
          studentId: studentId,
        ),
        token: serviceLocater.get<SharedPreferences>().getString("token"),
        headers: {'campaign_id': campainId},
      );
      log("Get Student Attendence Success: ${response.data}");

      if (response.data is List) {
        final List<AttendanceModel> studentAttendence = [];
        for (var group in response.data) {
          studentAttendence.add(AttendanceModel.fromJson(group));
        }
        return right(studentAttendence);
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      log("Get Student Attendence Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StudentModel>> fetchStudentById({
    required int studentId,
  }) async {
    try {
      String? token = serviceLocater.get<SharedPreferences>().getString(
        "token",
      );
      final Response response = await _dioHelper.getData(
        url: EndPoint.studentInfo + studentId.toString(),
        token: token,
      );
      log("Get Student Info Success: ${response.data}");
      final StudentModel studentInfo = StudentModel.fromJson(response.data);

      return right(studentInfo);
    } catch (e) {
      log("Get Student Info Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ListeningModel>>> fetchSavingSessions({
    required int studentId,
  }) async {
    try {
      final response = await _dioHelper.getData(
        url: EndPoint.fetchListeningData,
        query: {
          'campaignId': serviceLocater.get<SharedPreferences>().getInt(
            'campaign-id',
          ),
          'teacherId': serviceLocater.get<SharedPreferences>().getInt(
            'teacher-id',
          ),
          'studentId': studentId,
        },
      );

      log("Fetch Saving Sessions Success: ${response.data}");

      if (response.data is List) {
        final List<ListeningModel> sessions = [];
        for (var listening in response.data) {
          sessions.add(ListeningModel.fromJson(listening));
        }
        return right(sessions);
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      log("Fetch Saving Sessions Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
