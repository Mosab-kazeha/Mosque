import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/widget/custom_app_bar.dart';
import 'package:saas_mosque/core/widget/custom_failur_screen.dart';
import 'package:saas_mosque/features/campaigns/presentation/bloc/campaigns_bloc.dart';
import 'package:saas_mosque/features/campaigns/presentation/widgets/campaigns_list.dart';
import 'package:saas_mosque/features/room/presentation/widgets/custom_drawer.dart';

import '../../../../core/widget/custom_circular_progress_indicator.dart';

class CampaignsScreen extends StatefulWidget {
  const CampaignsScreen({super.key});

  @override
  State<CampaignsScreen> createState() => _CampaignsScreenState();
}

class _CampaignsScreenState extends State<CampaignsScreen> {
  @override
  void initState() {
    // serviceLocater<CampaignsBloc>().add(GetCampaigns());
    context.read<CampaignsBloc>().add(GetCampaigns());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الدورات'),
      endDrawer: const CustomDrawer(),
      body: BlocBuilder<CampaignsBloc, CampaignsState>(
        builder: (context, state) {
          if (state is CampaignsLoading) {
            return Center(child: CustomCircularProgressIndicator());
          }
          if (state is CampaignsFailure) {
            log("the CampaignsFailure message is${state.message}");
            return FailureScreen(
              onPressed: () {
                context.read<CampaignsBloc>().add(GetCampaigns());
              },
            );
          }
          if (state is CampaignsSuccess) {
            return CampaignsList(campaigns: state.campaigns);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
