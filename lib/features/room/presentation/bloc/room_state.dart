part of 'room_bloc.dart';

@immutable
sealed class RoomState {
  const RoomState();
}

final class RoomInitial extends RoomState {}

final class RoomLoading extends RoomState {}

final class PermessionsSuccess extends RoomState {
  final List<Permessions> permessions;

  const PermessionsSuccess(this.permessions);
}

final class RoomFailure extends RoomState {
  final String message;

  const RoomFailure(this.message);
}
