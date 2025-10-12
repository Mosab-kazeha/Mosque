import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';

class SessionMark extends StatelessWidget {
  final int currentMark;
  const SessionMark({super.key, required this.currentMark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const ResponsiveText(
          'العلامة الحالية',
          fontSize: FontTextSize.defaultFontSize,
          color: AppPalette.grey,
        ),
        ResponsiveText(
          currentMark.toString(),
          fontSize: FontTextSize.titleFontSize,
          color: Colors.teal,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
