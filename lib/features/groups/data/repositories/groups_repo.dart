import 'package:dartz/dartz.dart';
import 'package:saas_mosque/core/data/models/group_model.dart';
import 'package:saas_mosque/core/error/failure.dart';

abstract class GroupsRepo {
  Future<Either<Failure, List<GroupModel>>> getGroups();
}
