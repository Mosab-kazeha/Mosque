import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // final VoidCallback? onMenuPressed;
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppPalette.backgroundColor,
      elevation: 0,
      centerTitle: true,
      title: const ResponsiveText(
        'منصة حلقات',
        fontSize: FontTextSize.headingFontSize,
        color: AppPalette.white,
        fontWeight: FontWeight.bold,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ],
      leading: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Icon(Icons.notifications_none, color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
