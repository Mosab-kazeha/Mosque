import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';

class CustomCard extends StatelessWidget {
  final int index;
  final String title;
  final String subTitle;
  final void Function() onTap;
  const CustomCard({
    super.key,
    required this.index,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppPalette.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color:
              index % 2 == 0
                  ? AppPalette.cardBorderColor1
                  : AppPalette.cardBorderColor2,
          width: 2,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: AppPalette.cardBorderColor1.withAlpha(2),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ResponsiveText(
                title,
                color: AppPalette.white,
                fontWeight: FontWeight.bold,
                fontSize: FontTextSize.titleFontSize,
                textDirection: TextDirection.rtl,
              ),
              const VerticalSpace(8),
              ResponsiveText(
                subTitle,
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
