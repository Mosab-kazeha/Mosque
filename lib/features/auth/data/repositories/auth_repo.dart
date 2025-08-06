import 'package:dartz/dartz.dart';
import 'package:saas_mosque/core/error/failure.dart';

abstract  class AuthRepo {
  Future<Either<Failure, void>> login({required String phone,required String password});
}
