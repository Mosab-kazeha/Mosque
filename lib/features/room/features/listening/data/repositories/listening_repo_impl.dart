import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:saas_mosque/core/error/failure.dart';
import 'package:saas_mosque/core/network/dio_helper.dart';
import 'package:saas_mosque/core/network/end_point.dart';
import 'package:saas_mosque/features/room/features/listening/data/models/listening_model.dart';
import 'package:saas_mosque/features/room/features/listening/data/repositories/listening_repo.dart';
import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListeningRepoImpl extends ListeningRepo {
  final DioHelper _dioHelper;

  ListeningRepoImpl(DioHelper dioHelper) : _dioHelper = dioHelper;

  @override
  Future<Either<Failure, List<ListeningModel>>> fetchListeningData() async {
    try {
      final response = await _dioHelper.getData(
        url: EndPoint.fetchListeningData,
        query: {
          "dateTo": "2025-12-31",
          "dateFrom": "2024-01-01",
          "teacherId": serviceLocater.get<SharedPreferences>().get(
            'teacher-id',
          ),
          "campaignId": serviceLocater.get<SharedPreferences>().get(
            'campaign-id',
          ),
        },
      );

      log("Fetch Listening Data Success: ${response.data}");

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
      log("Fetch Listening Data Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> startListeningSession({
    required int studentId,
    required int startPage,
    required int endPage,
  }) async {
    try {
      final response = await _dioHelper.postData(
        url: EndPoint.startListeningSession,
        data: {
          'student_id': studentId,
          'start_page': startPage,
          'end_page': endPage,
        },
      );

      log("Start Listening Sessions Success: ${response.data}");

      return right(null);
    } catch (e) {
      log("Start Listening Sessions Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
