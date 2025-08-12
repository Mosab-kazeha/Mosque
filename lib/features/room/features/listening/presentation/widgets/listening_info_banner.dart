import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';

class ListeningInfoBanner extends StatelessWidget {
  const ListeningInfoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPalette.backgroundColor2,
      padding: const EdgeInsets.all(12),
      child: const Row(
        children: [
          Icon(Icons.info, color: Colors.blue),
          HorizontalSpace(8),
          Expanded(
            child: ResponsiveText(
              "تقوم هذه الصفحة بعرض جميع جلسات التسميع",
              color: AppPalette.black,
              fontSize: FontTextSize.bodyFontSize,
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }
}
