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

final class ListeningFailure extends ListeningState {
  final String message;

  const ListeningFailure(this.message);
}
