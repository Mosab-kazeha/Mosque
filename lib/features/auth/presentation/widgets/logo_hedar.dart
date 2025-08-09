import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.mosque, size: 52, color: Colors.white),
        SizedBox(width: 10, height: 10),
        ResponsiveText(
          "منصة حلقات",
          fontSize: FontTextSize.headingFontSize,
          color: AppPalette.white,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
