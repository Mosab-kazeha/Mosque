part of 'attendance_bloc.dart';

@immutable
sealed class AttendanceEvent {
  const AttendanceEvent();
}

final class SendAttendance extends AttendanceEvent {
  final List<AttendanceModel> attendence;

  const SendAttendance(this.attendence);
}
