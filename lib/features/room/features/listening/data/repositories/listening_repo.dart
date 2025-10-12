import 'package:dartz/dartz.dart';
import 'package:saas_mosque/core/error/failure.dart';
import 'package:saas_mosque/features/room/features/listening/data/models/listening_model.dart';

abstract class ListeningRepo {
  Future<Either<Failure, List<ListeningModel>>> fetchListeningData();

  // Future<Either<Failure, void>> startListeningSession({
  //   required int studentId,
  //   required int startPage,
  //   required int endPage,
  // });

  // Future<Either<Failure, List<EvaluationModel>>> fetchEvaluations();

  // Future<Either<Failure, void>> endSession(SubmitSessionModel session);

  // Future<Either<Failure, List<MistakeModel>>> fetchMistakes();
}
