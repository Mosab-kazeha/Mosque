import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:saas_mosque/core/error/failure.dart';
import 'package:saas_mosque/core/network/dio_helper.dart';
import 'package:saas_mosque/core/network/end_point.dart';
import 'package:saas_mosque/features/campaigns/data/models/campaign_model.dart';
import 'package:saas_mosque/features/campaigns/data/repositories/campaigns_repo.dart';
import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampaignsRepoImpl extends CampaignsRepo {
  final DioHelper _dioHelper;

  CampaignsRepoImpl(DioHelper dioHelper) : _dioHelper = dioHelper;

  @override
  Future<Either<Failure, List<CampaignModel>>> getCampaigns() async {
    try {
      final response = await _dioHelper.getData(
        url: EndPoint.campaigns,
        token: serviceLocater.get<SharedPreferences>().getString('token'),
      );
      log("Get Campaigns Success: ${response.data}");

      if (response.data is List) {
        final List<CampaignModel> campaigns = [];
        for (var campaign in response.data) {
          campaigns.add(CampaignModel.fromJson(campaign));
        }
        return right(campaigns);
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      log("Get Campaigns Failure: ${e.toString()}");
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
