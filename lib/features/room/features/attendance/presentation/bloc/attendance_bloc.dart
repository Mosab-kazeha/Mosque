import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/features/room/features/attendance/data/model/attendace_model.dart';
import '../../data/repositories/attendance_repo.dart';
import 'package:flutter/material.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepo _attendanceRepo;

  Map<int, int> delays = {};

  AttendanceBloc(AttendanceRepo attendanceRepo)
    : _attendanceRepo = attendanceRepo,
      super(AttendanceInitial()) {
    on<SendAttendance>((event, emit) async {
      emit(AttendanceLoading());
      (await _attendanceRepo.sendAttendance(event.attendence)).fold(
        (l) => emit(AttendanceFailure(l.errorMessege)),
        (r) => emit(AttendanceSuccess()),
      );
    });
  }
}
