import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTap;
  const CustomNavigationBar({
    super.key,
    this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: AppPalette.backgroundColor,
      unselectedItemColor: AppPalette.grey,
      selectedLabelStyle: TextStyle(
        fontSize: AppFontStyle.selectTextSize(FontTextSize.bodyFontSize),
        fontFamily: AppFontStyle.fontFamily,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: AppFontStyle.selectTextSize(FontTextSize.bodyFontSize),
        fontFamily: AppFontStyle.fontFamily,
        fontWeight: FontWeight.bold,
      ),
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.check), label: 'الحضور'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'التسميع'),
      ],
    );
  }
}
