import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:saas_mosque/core/error/failure.dart';
import 'package:saas_mosque/core/network/dio_helper.dart';
import 'package:saas_mosque/core/network/end_point.dart';
import 'package:saas_mosque/features/room/features/session/data/models/evaluation_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/mistake_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/surah_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/submit_session_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/surah_template_model.dart';
import 'package:saas_mosque/features/room/features/session/data/repositories/session_repo.dart';
import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionRepoImpl extends SessionRepo {
  final DioHelper _dioHelper;

  SessionRepoImpl(DioHelper dioHelper) : _dioHelper = dioHelper;

  @override
  Future<Either<Failure, List<EvaluationModel>>> fetchEvaluations() async {
    try {
      final response = await _dioHelper.getData(
        url: EndPoint.evaluations,
        token: serviceLocater.get<SharedPreferences>().getString('token'),
        headers: {
          'campaign_id': serviceLocater.get<SharedPreferences>().getInt(
            'campaign-id',
          ),
        },
      );

      log("Fetch Evaluation Data Success: ${response.data}");

      if (response.data is List) {
        final List<EvaluationModel> evaluations = [];
        for (var evaluation in response.data) {
          evaluations.add(EvaluationModel.fromJson(evaluation));
        }
        return right(evaluations);
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      log("Fetch Evaluations Data Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> endSession(SubmitSessionModel session) async {
    try {
      log(session.sessionData.toString());

      final response = await _dioHelper.postData(
        url: EndPoint.endSession,
        token: serviceLocater.get<SharedPreferences>().getString('token'),
        data: session.sessionData,
      );

      log("End Session Success: ${response.data}");

      return right(null);
    } catch (e) {
      log("End Session Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MistakeModel>>> fetchMistakes() async {
    try {
      final response = await _dioHelper.getData(
        url: EndPoint.fetchMistakes(
          serviceLocater.get<SharedPreferences>().getInt('campaign-id')!,
        ),
        token: serviceLocater.get<SharedPreferences>().getString('token'),
      );

      log("Fetch Mistakes Success: ${response.data}");

      if (response.data is List) {
        final List<MistakeModel> mistakes = [];
        for (var mistake in response.data) {
          mistakes.add(MistakeModel.fromJson(mistake));
        }
        return right(mistakes);
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      log("Fetch Mistakes Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SurahModel>>> fetchSurahs() async {
    try {
      final response = await _dioHelper.getData(url: EndPoint.fetchSurahs);

      log("Fetch Surahs Success: ${response.data}");

      if (response.data is List) {
        final List<SurahModel> surahs = [];
        for (var surah in response.data) {
          surahs.add(SurahModel.fromJson(surah));
        }
        return right(surahs);
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      log("Fetch Surahs Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SurahTemplateModel>>> fetchSurahTemplates(
    int surahNumber,
  ) async {
    try {
      final response = await _dioHelper.getData(
        url: "${EndPoint.fetchSurahTemplates}/$surahNumber",
      );

      log("Fetch Surah Templates Success: ${response.data}");

      if (response.data is List) {
        final List<SurahTemplateModel> surahTemplates = [];
        for (var surahTemplate in response.data) {
          surahTemplates.add(SurahTemplateModel.fromJson(surahTemplate));
        }
        return right(surahTemplates);
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      log("Fetch Surah Templates Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
