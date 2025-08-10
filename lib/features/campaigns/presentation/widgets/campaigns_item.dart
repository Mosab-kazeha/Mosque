import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saas_mosque/core/router/routes_config.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/campaigns/data/models/campaign_model.dart';

class CampaignsItem extends StatelessWidget {
  final int index;
  final CampaignModel campaign;
  const CampaignsItem({super.key, required this.index, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2b836b),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color:
              index % 2 == 0
                  ? const Color(0xFF249e7c)
                  : const Color(0xFF2b836b),
          width: 2,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: const Color(0xFF249e7c).withAlpha(2),
        onTap: () {
          context.push(AppRoutes.kRoomScreen);
          // await _saveCampaignId(campaign.id);
          // Navigator.pushReplacementNamed(context, '/groups');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ResponsiveText(
                campaign.name,
                color: AppPalette.white,
                fontWeight: FontWeight.bold,
                fontSize: FontTextSize.titleFontSize,
              ),
              const VerticalSpace(8),
              ResponsiveText(
                campaign.mosque.name,
                color: Colors.white70,
                fontSize: FontTextSize.bodyFontSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
