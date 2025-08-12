part of 'student_bloc.dart';

@immutable
sealed class StudentState {}

final class StudentInitial extends StudentState {}

final class StudentAttendanceLoading extends StudentState {}

final class StudentAttendanceSuccess extends StudentState {
  final List<AttendanceModel> student;

  StudentAttendanceSuccess({required this.student});
}

final class StudentAttendanceFailure extends StudentState {
  final String message;

  StudentAttendanceFailure({required this.message});
}

final class StudentInfoLoading extends StudentState {}

final class StudentInfoSuccess extends StudentState {
  final List<Map> student;

  StudentInfoSuccess({required this.student});
}

final class StudentInfoFailure extends StudentState {
  final String message;

  StudentInfoFailure({required this.message});
}

final class StudentSavingSessionsLoading extends StudentState {}

final class StudentSavingSessionsSuccess extends StudentState {
  final List<ListeningModel> sessions;

  StudentSavingSessionsSuccess({required this.sessions});
}

final class StudentSavingSessionsFailure extends StudentState {
  final String message;

  StudentSavingSessionsFailure({required this.message});
}
