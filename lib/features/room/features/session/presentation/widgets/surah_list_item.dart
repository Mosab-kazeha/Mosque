import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saas_mosque/core/router/routes_config.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/features/room/features/session/data/models/surah_model.dart';

class SurahListItem extends StatelessWidget {
  final SurahModel surah;
  // final String name;
  // final int number;
  // final int startPage;
  // final int endPage;
  const SurahListItem({
    super.key,
    required this.surah,
    // required this.name,
    // required this.number,
    // required this.startPage,
    // required this.endPage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppPalette.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          context.push(AppRoutes.kSurahPagesScreen, extra: surah);
        },
        child: ListTile(
          trailing: CircleAvatar(
            backgroundColor: AppPalette.buttonColor,
            child: ResponsiveText(
              surah.number.toString(),
              fontSize: FontTextSize.headingFontSize,
            ),
          ),
          title: ResponsiveText(
            surah.name,
            fontSize: FontTextSize.bodyFontSize,
            textAlign: TextAlign.end,
          ),
          leading: const ResponsiveText(
            'الصفحات ${10} - ${5}',
            // 'الصفحات ${surah.startPage} - ${surah.endPage}',
            fontSize: FontTextSize.defaultFontSize,
          ),
        ),
      ),
    );
  }
}
