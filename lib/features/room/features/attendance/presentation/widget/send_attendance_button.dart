import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/utils/size_config.dart';
import 'package:saas_mosque/core/widget/custom_snack_bar.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/features/room/features/attendance/data/model/attendace_model.dart';
import 'package:saas_mosque/features/room/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendAttendanceButton extends StatelessWidget {
  final Map<int, int> delays;
  final int groupId;
  const SendAttendanceButton({
    super.key,
    required this.delays,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final now = DateTime.now();
        final formattedDate =
            "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

        final valid = delays.entries.where((e) => e.value != -1).toList();

        if (valid.isEmpty) {
          CustomSnackBar.show(
            context,
            type: SnackBarType.error,
            "يرجى تحديد حالة حضور واحدة على الأقل",
          );
          return;
        }

        final attendanceList =
            valid.map((e) {
              final delay = e.value;
              String status;

              if (delay == 0) {
                status = "ATTEND";
              } else if (delay >= 1000) {
                status = "MISS";
              } else {
                status = "DELAY";
              }

              return AttendanceModel(
                studentId: e.key,
                campaignId:
                    serviceLocater.get<SharedPreferences>().getInt(
                      'campaign-id',
                    )!,
                delay: delay,
                status: status,
                date: formattedDate,
              );
            }).toList();

        context.read<AttendanceBloc>().add(SendAttendance(attendanceList));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2B836B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
        fixedSize: Size(SizeConfig.width, SizeConfig.height * 0.065),
      ),
      child: const ResponsiveText(
        'إرسال',
        color: AppPalette.backgroundColor,
        fontSize: FontTextSize.bodyFontSize,
        fontWeight: FontWeight.bold,
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
