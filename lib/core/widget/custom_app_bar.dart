// import 'package:flutter/material.dart';
// import 'package:saas_mosque/core/style/font_style.dart';
// import 'package:saas_mosque/core/widget/responsive_text.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: const Color(0xFF2b836b),
//       elevation: 0,
//       // leading: IconButton(
//       //   icon: const Icon(Icons.arrow_back, color: Colors.white),
//       //   onPressed: () {},
//       //   // onPressed: () => _logoutAndGoToLogin(context),
//       // ),
//       title: const Align(
//         alignment: Alignment.center,
//         child: ResponsiveText(
//           'الدورات',
//           textAlign: TextAlign.end,
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontSize: FontTextSize.headingFontSize,
//         ),
//       ),
//       centerTitle: false,
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppPalette.backgroundColor,
      elevation: 0,
      centerTitle: true,
      title: ResponsiveText(
        title,
        fontSize: FontTextSize.headingFontSize,
        color: AppPalette.white,
        fontWeight: FontWeight.bold,
      ),
      actions: actions,
      // actions:
      // [
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //         child: IconButton(
      //           icon: const Icon(Icons.menu, color: Colors.white),
      //           onPressed: () => Scaffold.of(context).openDrawer(),
      //         ),
      //       ),
      //     ],
      leading: leading,
      // leading:
      // const Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 16.0),
      //       child: Icon(Icons.notifications_none, color: Colors.white),
      //     )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
