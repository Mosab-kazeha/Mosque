import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';

class EducationalClassText extends StatelessWidget {
  final int? classNumber;

  const EducationalClassText({super.key, this.classNumber});

  String getClassName(int? number) {
    if (number == null) return "لم يسجل";

    if (number >= 1 && number <= 12) {
      return "الصف ${_getArabicOrder(number)}";
    } else if (number > 12) {
      return "جامعي";
    } else {
      return "غير معروف";
    }
  }

  String _getArabicOrder(int number) {
    const orders = [
      "الأول",
      "الثاني",
      "الثالث",
      "الرابع",
      "الخامس",
      "السادس",
      "السابع",
      "الثامن",
      "التاسع",
      "العاشر",
      "الحادي عشر",
      "بكلوريا",
    ];
    return orders[number - 1];
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveText(
      getClassName(classNumber),
      color: AppPalette.backgroundColor,
      fontSize: FontTextSize.defaultFontSize,
    );
  }
}
