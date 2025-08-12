import 'package:dartz/dartz.dart';
import 'package:saas_mosque/core/error/failure.dart';

abstract class SplashRepo {
  Future<Either<Failure, void>> getProfile();
}
