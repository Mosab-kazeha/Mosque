import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saas_mosque/core/router/routes_config.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/features/room/features/session/presentation/bloc/session_bloc.dart';

class StartSessionButton extends StatelessWidget {
  const StartSessionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, kBottomNavigationBarHeight),
        ),
        onPressed: () {
          final bloc = context.read<SessionBloc>();
          log(bloc.selectedPages.toString());
          if (bloc.selectedPages.isEmpty) {
            // CustomSnackBar.show(
            //   context,
            //   'يجب اختيار الصفحات المراد تسميعها',
            //   type: SnackBarType.error,
            //   atTop: true,
            // );
            return;
          }
          bloc.selectedPages.sort(
            (a, b) => a.pageNumber.compareTo(b.pageNumber),
          );
          context.pushReplacement(AppRoutes.kSessionScreen);
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow_outlined, color: AppPalette.white, size: 20),
            ResponsiveText(
              'ابدأ الجلسة',
              fontSize: FontTextSize.bodyFontSize,
              fontWeight: FontWeight.bold,
              color: AppPalette.white,
            ),
          ],
        ),
      ),
    );
  }
}
