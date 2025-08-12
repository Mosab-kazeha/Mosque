part of 'listening_bloc.dart';

@immutable
sealed class ListeningEvent {
  const ListeningEvent();
}

final class FetchListeningData extends ListeningEvent {}
