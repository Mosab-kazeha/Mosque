import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/features/room/data/model/student_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/evaluation_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/mistake_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/surah_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/submit_session_model.dart';
import 'package:flutter/material.dart';
import 'package:saas_mosque/features/room/features/session/data/models/surah_template_model.dart';
import 'package:saas_mosque/features/room/features/session/data/repositories/session_repo.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final SessionRepo _sessionRepo;

  final List<EvaluationModel> evaluations = [];
  StudentModel? selectedStudent;
  final List<SurahTemplateModel> selectedPages = [];
  final List<SessionSurahModel> sessionSurahs = [];
  int sessionDurationSeconds = 0;
  int? sessionCurrentPage;
  final Map<int, List<MistakeModel>> sessionMistakes = {};

  SessionBloc(SessionRepo sessionRepo)
    : _sessionRepo = sessionRepo,
      super(SessionInitial()) {
    on<FetchEvaluationsData>(_onFetchEvaluationData);
    on<EndSession>(_onEndSession);
    on<EndPage>(_onEndPage);
    on<FetchMistakes>(_onFetchMistakes);
    on<FetchSurahs>(_onFetchSurahs);
    on<FetchSurahTemplates>(_onFetchSurahTemplates);
    on<AddMistake>(_onAddMistake);
    on<RemoveMistake>(_onRemoveMistake);
  }

  void setSelectedStudent(StudentModel student) {
    selectedStudent = student;
  }

  // session calculations...

  double calculateRawScore(List<MistakeModel> mistakes) {
    const initialScore = 100;

    final totalReducedMarks = mistakes.fold<int>(
      0,
      (sum, mistake) => sum + mistake.reducedMarks!,
    );

    final rawScore = max(0, initialScore - totalReducedMarks).toDouble();

    return rawScore;
  }

  double calculateWeightedScore(double rawScore, SurahTemplateModel template) {
    final weightedScore = rawScore * template.weight;

    return weightedScore;
  }

  bool determinePassStatus(double rawScore, double minimumMarks) {
    return rawScore >= minimumMarks;
  }

  Map<String, double> calculateSessionTotals(
    // List<SessionSurahModel> sessionSurahs,
  ) {
    double totalScore = 0;
    double maxPossibleScore = 0;

    // final List<SessionSurahModel> sessionSurahs = getSessionSurahs();

    final completedSurahs =
        sessionSurahs.where((element) => element.isCompleted).toList();

    for (SessionSurahModel s in completedSurahs) {
      totalScore += s.weightedScore;
      maxPossibleScore += 100 * s.template.weight;
    }

    return {"total_score": totalScore, "max_possible_score": maxPossibleScore};
  }

  // event handlers...

  void _onFetchEvaluationData(
    FetchEvaluationsData event,
    Emitter<SessionState> emit,
  ) async {
    emit(SessionLoading());
    (await _sessionRepo.fetchEvaluations()).fold(
      (l) => emit(SessionFailure(l.errorMessege)),
      (r) {
        emit(EvaluationsSuccess(r));
        r.sort((a, b) => b.minimumMarks.compareTo(a.minimumMarks));
        evaluations.addAll(r);
      },
    );
  }

  void _onEndSession(EndSession event, Emitter<SessionState> emit) async {
    emit(SessionLoading());
    (await _sessionRepo.endSession(event.session)).fold(
      (l) => emit(SessionFailure(l.errorMessege)),
      (r) {
        emit(EndSessionSuccess());
        sessionMistakes.clear();
        selectedPages.clear();
      },
    );
  }

  void _onEndPage(EndPage event, Emitter<SessionState> emit) {
    final int endPage = selectedPages.last.pageNumber;

    final currentTemplate = selectedPages.firstWhere(
      (e) => e.pageNumber == sessionCurrentPage,
    );

    final rawScore = calculateRawScore(sessionMistakes[currentTemplate.id]!);

    final evaluationId =
        evaluations
            .firstWhere(
              (e) => rawScore >= e.minimumMarks,
              orElse: () => evaluations.first,
            )
            .id;

    if (sessionCurrentPage! < endPage) {
      // sessionCurrentPage = sessionCurrentPage! + 1;
      sessionCurrentPage =
          selectedPages[selectedPages.indexOf(currentTemplate) + 1].pageNumber;
      sessionSurahs.add(
        SessionSurahModel(
          template: currentTemplate,
          evaluationId: evaluationId,
          isPassed: determinePassStatus(rawScore, 70),
          score: (100 * currentTemplate.weight).toDouble(),
          rawScore: rawScore,
          weightedScore: calculateWeightedScore(rawScore, currentTemplate),
          isCompleted: determinePassStatus(rawScore, 70),
          notes: "tttesttt",
          mistakes: sessionMistakes[currentTemplate.id]!,
        ),
      );
    }
    emit(EndPageSuccess());
  }

  void _onFetchMistakes(FetchMistakes event, Emitter<SessionState> emit) async {
    emit(MistakeLoading());
    (await _sessionRepo.fetchMistakes()).fold(
      (l) => emit(SessionFailure(l.errorMessege)),
      (r) => emit(FetchMistakesSuccess(r)),
    );
  }

  void _onFetchSurahTemplates(
    FetchSurahTemplates event,
    Emitter<SessionState> emit,
  ) async {
    emit(SessionLoading());
    (await _sessionRepo.fetchSurahTemplates(event.surahNumber)).fold(
      (l) => emit(SessionFailure(l.errorMessege)),
      (r) => emit(FetchSurahTemplatesSuccess(r)),
    );
  }

  void _onFetchSurahs(FetchSurahs event, Emitter<SessionState> emit) async {
    emit(SessionLoading());
    (await _sessionRepo.fetchSurahs()).fold(
      (l) => emit(SessionFailure(l.errorMessege)),
      (r) => emit(FetchSurahsSuccess(r)),
    );
  }

  void _onAddMistake(AddMistake event, Emitter<SessionState> emit) {
    sessionMistakes[event.templateId]!.add(event.mistake);
    emit(AddMistakeSuccess());
  }

  void _onRemoveMistake(RemoveMistake event, Emitter<SessionState> emit) {
    sessionMistakes[event.templateId]?.removeWhere(
      (m) => m.id == event.mistake.id,
    );
    emit(RemoveMistakeSuccess());
  }
}
