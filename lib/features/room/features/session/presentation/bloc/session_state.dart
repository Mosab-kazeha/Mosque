part of 'session_bloc.dart';

@immutable
sealed class SessionState {
  const SessionState();
}

final class SessionInitial extends SessionState {}

final class SessionLoading extends SessionState {}

final class MistakeLoading extends SessionState {}

final class SessionFailure extends SessionState {
  final String message;

  const SessionFailure(this.message);
}

final class EvaluationsSuccess extends SessionState {
  final List<EvaluationModel> evaluations;

  const EvaluationsSuccess(this.evaluations);
}

final class EndSessionSuccess extends SessionState {}

final class FetchMistakesSuccess extends SessionState {
  final List<MistakeModel> mistakes;

  const FetchMistakesSuccess(this.mistakes);
}

final class AddMistakeSuccess extends SessionState {}

final class RemoveMistakeSuccess extends SessionState {}

final class FetchSurahsSuccess extends SessionState {
  final List<SurahModel> surahs;

  const FetchSurahsSuccess(this.surahs);
}

final class FetchSurahTemplatesSuccess extends SessionState {
  final List<SurahTemplateModel> surahTemplates;

  const FetchSurahTemplatesSuccess(this.surahTemplates);
}

final class EndPageSuccess extends SessionState {}

// final class ListeningSuccess extends ListeningState {
//   final List<ListeningModel> listenings;

//   const ListeningSuccess(this.listenings);
// }
