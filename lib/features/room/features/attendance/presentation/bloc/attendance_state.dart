
// import '../widget/enum_attendance.dart';

// class AttendanceState {
//   final Map<int, AttendanceEnumStatus> studentStatus;
//   final bool submitting;
//   final bool success;
//   final String? error;

//   AttendanceState({
//     required this.studentStatus,
//     this.submitting = false,
//     this.success = false,
//     this.error,
//   });

//   AttendanceState copyWith({
//     Map<int, AttendanceEnumStatus>? studentStatus,
//     bool? submitting,
//     bool? success,
//     String? error,
//   }) {
//     return AttendanceState(
//       studentStatus: studentStatus ?? this.studentStatus,
//       submitting: submitting ?? this.submitting,
//       success: success ?? this.success,
//       error: error,
//     );
//   }
// }


part of 'attendance_bloc.dart';





@immutable
sealed class AttendanceState {
  const AttendanceState();
}

final class AttendanceInitial extends AttendanceState {}

final class AttendanceLoading extends AttendanceState {}

final class AttendanceSuccess extends AttendanceState {
  
}

final class AttendanceFailure extends AttendanceState {
  final String message;

  const AttendanceFailure(this.message);
}
