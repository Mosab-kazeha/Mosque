import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/features/campaigns/data/models/campaign_model.dart';
import 'package:saas_mosque/features/campaigns/data/repositories/campaigns_repo.dart';

part 'campaigns_event.dart';
part 'campaigns_state.dart';

class CampaignsBloc extends Bloc<CampaignsEvent, CampaignsState> {
  final CampaignsRepo _campaignsRepo;

  CampaignsBloc(CampaignsRepo campaignsRepo)
    : _campaignsRepo = campaignsRepo,
      super(CampaignsInitial()) {
    on<GetCampaigns>((event, emit) async {
      emit(CampaignsLoading());
      (await _campaignsRepo.getCampaigns()).fold(
        (l) => emit(CampaignsFailure(l.errorMessege)),
        (r) => emit(CampaignsSuccess(r)),
      );
    });
  }
}
