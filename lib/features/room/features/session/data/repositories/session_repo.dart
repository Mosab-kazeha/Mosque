import 'package:dartz/dartz.dart';
import 'package:saas_mosque/core/error/failure.dart';
import 'package:saas_mosque/features/room/features/session/data/models/evaluation_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/mistake_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/surah_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/submit_session_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/surah_template_model.dart';

abstract class SessionRepo {
  Future<Either<Failure, List<EvaluationModel>>> fetchEvaluations();

  Future<Either<Failure, void>> endSession(SubmitSessionModel session);

  Future<Either<Failure, List<MistakeModel>>> fetchMistakes();

  Future<Either<Failure, List<SurahModel>>> fetchSurahs();

  Future<Either<Failure, List<SurahTemplateModel>>> fetchSurahTemplates(
    int surahNumber,
  );
}
