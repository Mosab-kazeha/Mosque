part of 'campaigns_bloc.dart';

@immutable
sealed class CampaignsState {
  const CampaignsState();
}

final class CampaignsInitial extends CampaignsState {}

final class CampaignsLoading extends CampaignsState {}

final class CampaignsSuccess extends CampaignsState {
  final List<CampaignModel> campaigns;

  const CampaignsSuccess(this.campaigns);
}

final class CampaignsFailure extends CampaignsState {
  final String message;

  const CampaignsFailure(this.message);
}
