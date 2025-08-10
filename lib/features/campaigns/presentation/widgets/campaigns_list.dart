import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:saas_mosque/core/router/routes_config.dart';
import 'package:saas_mosque/core/widget/custom_card.dart';
import 'package:saas_mosque/features/campaigns/data/models/campaign_model.dart';
import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampaignsList extends StatelessWidget {
  final List<CampaignModel> campaigns;
  const CampaignsList({super.key, required this.campaigns});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: campaigns.length,
      itemBuilder:
          (context, index) => CustomCard(
            index: index,
            title: campaigns[index].name,
            subTitle: campaigns[index].mosque.name,
            onTap: () async {
              await serviceLocater.get<SharedPreferences>().setInt(
                'campaign-id',
                campaigns[index].id,
              );

              // ignore: use_build_context_synchronously
              context.push(AppRoutes.kGroupsScreen);
            },
          ),
    );
  }
}
