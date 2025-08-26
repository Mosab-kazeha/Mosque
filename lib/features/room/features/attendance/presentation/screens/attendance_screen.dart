import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/data/models/group_model.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/custom_snack_bar.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/room/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:saas_mosque/features/room/features/attendance/presentation/widget/attendance_list.dart';
import 'package:saas_mosque/features/room/features/attendance/presentation/widget/send_attendance_button.dart';

import '../../../../../../core/widget/custom_circular_progress_indicator.dart';

class AttendanceScreen extends StatelessWidget {
  // final List<StudentModel> students;
  // final int campaignId;
  // final int groupId;
  final GroupModel group;
  const AttendanceScreen({
    super.key,
    required this.group,
    // required this.students,
    // required this.campaignId,
    // required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AttendanceBloc>();
    return BlocConsumer<AttendanceBloc, AttendanceState>(
      listener: (context, state) {
        if (state is AttendanceSuccess) {
          CustomSnackBar.show(context, 'تم أخذ الحضور بنجاح');
          BlocProvider.of<AttendanceBloc>(context).delays = {};
        } else if (state is AttendanceFailure) {
          CustomSnackBar.show(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is AttendanceLoading) {
          return Center(child: CustomCircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const ResponsiveText(
                "التفقد والحضور",
                fontSize: FontTextSize.titleFontSize,
                fontWeight: FontWeight.bold,
              ),
              const VerticalSpace(10),
              AttendanceList(students: group.students, delays: bloc.delays),
              const VerticalSpace(10),
              SendAttendanceButton(delays: bloc.delays, groupId: group.id),
              const VerticalSpace(10),
            ],
          ),
        );
      },
    );
  }
}
