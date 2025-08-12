part of 'attendance_bloc.dart';

@immutable
sealed class AttendanceState {
  const AttendanceState();
}

final class AttendanceInitial extends AttendanceState {}

final class AttendanceLoading extends AttendanceState {}

final class AttendanceSuccess extends AttendanceState {}

final class AttendanceFailure extends AttendanceState {
  final String message;

  const AttendanceFailure(this.message);
}
