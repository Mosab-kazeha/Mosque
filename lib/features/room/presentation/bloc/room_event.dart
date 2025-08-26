part of 'room_bloc.dart';

@immutable
sealed class RoomEvent {
  const RoomEvent();
}

final class GetPermessions extends RoomEvent {}
