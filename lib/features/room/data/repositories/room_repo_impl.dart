import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:saas_mosque/core/error/failure.dart';
import 'package:saas_mosque/core/network/dio_helper.dart';
import 'package:saas_mosque/core/network/end_point.dart';
import 'package:saas_mosque/core/utils/permessions.dart';
import 'package:saas_mosque/features/room/data/repositories/room_repo.dart';
import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomRepoImpl extends RoomRepo {
  final DioHelper _dioHelper;

  RoomRepoImpl(DioHelper dioHelper) : _dioHelper = dioHelper;

  @override
  Future<Either<Failure, List<Permessions>>> getPermessions() async {
    try {
      final response = await _dioHelper.postData(
        url: EndPoint.myPermessions,
        token: serviceLocater.get<SharedPreferences>().getString('token'),
        headers: {
          'campaign_id': serviceLocater.get<SharedPreferences>().getInt(
            'campaign-id',
          ),
        },
      );
      log("Get My Permessions Success: ${response.data}");

      if (response.data['permissions'] is List) {
        final permessions = List<String>.from(response.data['permissions']);
        await serviceLocater.get<SharedPreferences>().setStringList(
          'permessions',
          permessions,
        );
        return right(getPermessionsList(null));
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      log("Get My Permessions Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
