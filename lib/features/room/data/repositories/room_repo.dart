import 'package:dartz/dartz.dart';
import 'package:saas_mosque/core/error/failure.dart';
import 'package:saas_mosque/core/utils/permessions.dart';

abstract class RoomRepo {
  Future<Either<Failure, List<Permessions>>> getPermessions();
}
