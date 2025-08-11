import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failure.dart';
import '../model/attendace_model.dart';

abstract class AttendanceRepo {
  Future<Either<Failure, void>> sendAttendance(
    List<AttendanceModel> attendence,
  );
}
