part of 'campaigns_bloc.dart';

@immutable
sealed class CampaignsEvent {}

final class GetCampaigns extends CampaignsEvent {}
