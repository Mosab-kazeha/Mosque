part of 'listening_bloc.dart';

@immutable
sealed class ListeningEvent {
  const ListeningEvent();
}

final class FetchListeningData extends ListeningEvent {}

// final class FetchEvaluationsData extends ListeningEvent {}

// final class EndSession extends ListeningEvent {
//   final SubmitSessionModel session;

//   const EndSession(this.session);
// }

// final class EndPage extends ListeningEvent {}

// final class FetchMistakes extends ListeningEvent {}
