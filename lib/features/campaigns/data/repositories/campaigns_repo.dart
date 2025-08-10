import 'package:dartz/dartz.dart';
import 'package:saas_mosque/core/error/failure.dart';
import 'package:saas_mosque/features/campaigns/data/models/campaign_model.dart';

abstract class CampaignsRepo {
  Future<Either<Failure, List<CampaignModel>>> getCampaigns();
}
