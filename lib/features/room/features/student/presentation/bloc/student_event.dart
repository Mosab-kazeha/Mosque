part of 'student_bloc.dart';

@immutable
sealed class StudentEvent {
  const StudentEvent();
}

final class GetStudentAttendance extends StudentEvent {
  final int studentId;

  const GetStudentAttendance({required this.studentId});
}

final class GetStudentSavingSessions extends StudentEvent {
  final int studentId;

  const GetStudentSavingSessions({required this.studentId});
}

final class GetStudentInfo extends StudentEvent {
  final int studentId;

  const GetStudentInfo({required this.studentId});
}
