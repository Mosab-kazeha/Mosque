import 'package:dartz/dartz.dart';
import 'package:saas_mosque/features/room/data/model/student_model.dart';
import 'package:saas_mosque/features/room/features/attendance/data/model/attendace_model.dart';
import 'package:saas_mosque/features/room/features/listening/data/models/listening_model.dart';
import '../../../../../../core/error/failure.dart';

abstract class StudentRepo {
  Future<Either<Failure, List<AttendanceModel>>> fetchAttendance({
    required int studentId,
  });

  Future<Either<Failure, List<ListeningModel>>> fetchSavingSessions({
    required int studentId,
  });

  Future<Either<Failure, StudentModel>> fetchStudentById({
    required int studentId,
  });
}
