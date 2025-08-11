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
  Future<Either<Failure, List<ListeningModel>>> fetchSavingSessions({
    required int studentId,
  }) async {
    try {
      final campaignId = serviceLocater.get<SharedPreferences>().getInt(
        'campaign-id',
      );
      final response = await _dioHelper.getData(
        url: EndPoint.getSavingSessions,
        query: {
          'campaignId': campaignId,
          'teacherId': 1,
          'studentId': studentId,
        },
      );

      log("Fetch Saving Sessions Success: ${response.data}");

      if (response.data is List) {
        final List<ListeningModel> sessions = [];
        for (var session in response.data) {
          sessions.add(ListeningModel.fromJson(session));
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
