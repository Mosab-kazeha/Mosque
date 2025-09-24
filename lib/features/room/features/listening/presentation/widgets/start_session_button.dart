import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/features/room/data/model/student_model.dart';
import 'package:saas_mosque/features/room/features/listening/presentation/widgets/start_session_sheet.dart';

class StartSessionButton extends StatelessWidget {
  final List<StudentModel> students;
  const StartSessionButton({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPalette.buttonColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => StartSessionSheet(students: students),
              );
            },

            child: const ResponsiveText(
              "بدء جلسة تسميع",
              fontSize: FontTextSize.smallFontSize,
              color: AppPalette.white,
            ),
          ),
          const Spacer(),
          const ResponsiveText(
            "جلسات التسميع",
            fontSize: FontTextSize.titleFontSize,
          ),
        ],
      ),
    );
  }
}
