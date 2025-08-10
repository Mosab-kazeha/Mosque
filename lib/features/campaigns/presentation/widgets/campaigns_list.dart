import 'package:flutter/widgets.dart';
import 'package:saas_mosque/features/campaigns/data/models/campaign_model.dart';
import 'package:saas_mosque/features/campaigns/presentation/widgets/campaigns_item.dart';

class CampaignsList extends StatelessWidget {
  final List<CampaignModel> campaigns;
  const CampaignsList({super.key, required this.campaigns});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: campaigns.length,
      itemBuilder:
          (context, index) =>
              CampaignsItem(index: index, campaign: campaigns[index]),
    );
  }
}
