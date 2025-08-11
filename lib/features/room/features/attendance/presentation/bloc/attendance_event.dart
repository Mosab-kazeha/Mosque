// import '../../data/model/attendace_model.dart';
// import '../widget/enum_attendance.dart';

// part of 'attendance_bloc.dart';

// abstract class AttendanceEvent {}

// class UpdateStudentAttendance extends AttendanceEvent {
//   final int studentId;
//   final AttendanceEnumStatus status;

//   UpdateStudentAttendance(this.studentId, this.status);
// }

// class UpdateAllAttendance extends AttendanceEvent {
//   final Map<int, AttendanceEnumStatus> statuses;
//   final Map<int, int> delays;

//   UpdateAllAttendance(this.statuses, this.delays);
// }

// class SubmitAttendance extends AttendanceEvent {
//   SubmitAttendance(List<AttendanceModel> list);
// }

part of 'attendance_bloc.dart';

@immutable
sealed class AttendanceEvent {
  const AttendanceEvent();
}

final class SendAttendance extends AttendanceEvent {
  final List<AttendanceModel> attendence;

  const SendAttendance(this.attendence);
}
