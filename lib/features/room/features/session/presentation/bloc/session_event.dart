part of 'session_bloc.dart';

@immutable
sealed class SessionEvent {
  const SessionEvent();
}

final class FetchEvaluationsData extends SessionEvent {}

final class EndSession extends SessionEvent {
  final SubmitSessionModel session;

  const EndSession(this.session);
}

final class EndPage extends SessionEvent {}

final class FetchMistakes extends SessionEvent {}

final class AddMistake extends SessionEvent {
  final int templateId;
  final MistakeModel mistake;

  const AddMistake({required this.templateId, required this.mistake});
}

final class RemoveMistake extends SessionEvent {
  final int templateId;
  final MistakeModel mistake;

  const RemoveMistake({required this.templateId, required this.mistake});
}

final class FetchSurahs extends SessionEvent {}

final class FetchSurahTemplates extends SessionEvent {
  final int surahNumber;

  const FetchSurahTemplates(this.surahNumber);
}

// final class BackToSurahsScreen extends SessionEvent {}
