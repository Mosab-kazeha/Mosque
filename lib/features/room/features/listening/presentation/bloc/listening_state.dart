part of 'listening_bloc.dart';

@immutable
sealed class ListeningState {
  const ListeningState();
}

final class ListeningInitial extends ListeningState {}

final class ListeningLoading extends ListeningState {}

final class ListeningSuccess extends ListeningState {
  final List<ListeningModel> listenings;

  const ListeningSuccess(this.listenings);
}

// final class EvaluationsSuccess extends ListeningState {
//   final List<EvaluationModel> evaluations;

//   const EvaluationsSuccess(this.evaluations);
// }

// final class EndSessionSuccess extends ListeningState {}

// final class EndPageSuccess extends ListeningState {}

// final class FetchMistakesSuccess extends ListeningState {
//   final List<MistakeModel> mistakes;

//   const FetchMistakesSuccess(this.mistakes);
// }

final class ListeningFailure extends ListeningState {
  final String message;

  const ListeningFailure(this.message);
}
