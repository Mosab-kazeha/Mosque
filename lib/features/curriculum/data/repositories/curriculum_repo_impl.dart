import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:saas_mosque/core/error/failure.dart';
import 'package:saas_mosque/core/network/dio_helper.dart';
import 'package:saas_mosque/core/network/end_point.dart';
import 'package:saas_mosque/features/curriculum/data/models/curriculum_template_model.dart';
import 'package:saas_mosque/features/curriculum/data/repositories/curriculum_repo.dart';
import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurriculumRepoImpl extends CurriculumRepo {
  final DioHelper _dioHelper;

  CurriculumRepoImpl(DioHelper dioHelper) : _dioHelper = dioHelper;

  @override
  Future<Either<Failure, List<CurriculumTemplateModel>>> getCurriculumTemplates(
    int groupId,
  ) async {
    try {
      final response = await _dioHelper.getData(
        url: EndPoint.getCurriculumTemplates(groupId),
        token: serviceLocater.get<SharedPreferences>().getString('token'),
      );
      log("Get Curriculum Templates Success: ${response.data}");

      if (response.data is List) {
        final List<CurriculumTemplateModel> templates = [];
        for (var template in response.data) {
          templates.add(CurriculumTemplateModel.fromJson(template));
        }
        return right(templates);
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      log("Get Curriculum Templates Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createLessonSession(
    CreateLessonSessionRequest request,
  ) async {
    try {
      final response = await _dioHelper.postData(
        url: EndPoint.createLessonSession,
        data: request.toJson(),
        token: serviceLocater.get<SharedPreferences>().getString('token'),
      );
      log("Create Lesson Session Success: ${response.data}");
      return right(null);
    } catch (e) {
      log("Create Lesson Session Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> startLessonSession(int nodeId) async {
    // Placeholder for future API implementation
    try {
      log("Start Lesson Session (Placeholder): Node ID $nodeId");
      // TODO: Implement API call when endpoint is ready
      // final response = await _dioHelper.postData(
      //   url: EndPoint.startLessonSession,
      //   data: {'node_id': nodeId},
      //   token: serviceLocater.get<SharedPreferences>().getString('token'),
      // );
      return right(null);
    } catch (e) {
      log("Start Lesson Session Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
