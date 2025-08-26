import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:saas_mosque/core/data/models/group_model.dart';
import 'package:saas_mosque/core/error/failure.dart';
import 'package:saas_mosque/core/network/dio_helper.dart';
import 'package:saas_mosque/core/network/end_point.dart';
import 'package:saas_mosque/features/groups/data/repositories/groups_repo.dart';
import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupsRepoImpl extends GroupsRepo {
  final DioHelper _dioHelper;

  GroupsRepoImpl(DioHelper dioHelper) : _dioHelper = dioHelper;

  @override
  Future<Either<Failure, List<GroupModel>>> getGroups() async {
    try {
      final response = await _dioHelper.getData(
        url: EndPoint.groups,
        token: serviceLocater.get<SharedPreferences>().getString('token'),
        headers: {
          'campaign-id': serviceLocater.get<SharedPreferences>().getInt(
            'campaign-id',
          ),
        },
      );
      log("Get Groups Success: ${response.data}");

      if (response.data is List) {
        final List<GroupModel> groups = [];
        for (var group in response.data) {
          groups.add(GroupModel.fromJson(group));
        }
        return right(groups);
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      log("Get Groups Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, List<Permessions>>> getPermessions() async {
  //   try {
  //     final response = await _dioHelper.postData(
  //       url: EndPoint.myPermessions,
  //       token: serviceLocater.get<SharedPreferences>().getString('token'),
  //       headers: {
  //         'campaign_id': serviceLocater.get<SharedPreferences>().getInt(
  //           'campaign-id',
  //         ),
  //       },
  //     );
  //     log("Get My Permessions Success: ${response.data}");

  //     if (response.data['permissions'] is List) {
  //       final List<Permessions> permessions = [];
  //       for (String permession in response.data['permissions']) {
  //         permessions.add(
  //           Permessions.values.firstWhere(
  //             (element) => element.toString() == permession,
  //           ),
  //         );
  //       }
  //       return right(permessions);
  //     } else {
  //       throw Exception('Unexpected response format');
  //     }
  //   } catch (e) {
  //     log("Get My Permessions Failure: ${e.toString()}");
  //     if (e is DioException) {
  //       return left(ServerFailure.fromDioException(e));
  //     }
  //     return left(ServerFailure(e.toString()));
  //   }
  // }
}
