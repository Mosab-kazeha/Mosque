import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/custom_failur_screen.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/features/room/features/attendance/data/model/attendace_model.dart';
import 'package:saas_mosque/features/room/features/student/presentation/bloc/student_bloc.dart';

import '../../../../../../core/widget/custom_circular_progress_indicator.dart';

class StudentAttendanceTabbar extends StatefulWidget {
  final int studentId;
  const StudentAttendanceTabbar({super.key, required this.studentId});

  @override
  State<StudentAttendanceTabbar> createState() =>
      _StudentAttendanceTabbarState();
}

class _StudentAttendanceTabbarState extends State<StudentAttendanceTabbar> {
  @override
  void initState() {
    context.read<StudentBloc>().add(
      GetStudentAttendance(studentId: widget.studentId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is StudentAttendanceSuccess) {
          return ListView.builder(
            itemCount: state.student.length,
            itemBuilder: (context, index) {
              final record = state.student[index];
              Map<String, dynamic> attendenceDetails = _statusDetails(
                record: state.student[index],
              );
              return Card(
                margin: const EdgeInsets.all(12),

                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: attendenceDetails["statusColor"],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ResponsiveText(
                      attendenceDetails["statusLabel"] ?? "22",
                      color: Colors.white,
                      fontSize: FontTextSize.smallFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: ResponsiveText(
                    _formatDate(record.date),
                    textAlign: TextAlign.right,
                    fontSize: FontTextSize.bodyFontSize,
                  ),
                  subtitle:
                      record.delay > 0
                          ? ResponsiveText(
                            'مدة التأخير: ${record.delay} دقيقة',
                            textAlign: TextAlign.right,
                            fontSize: FontTextSize.bodyFontSize,
                          )
                          : null,
                ),
              );
            },
          );
        } else if (state is StudentAttendanceFailure) {
          return FailureScreen(
            onPressed: () {
              log("the StudentAttendanceFailure message is${state.message}");
              context.read<StudentBloc>().add(
                GetStudentAttendance(studentId: widget.studentId),
              );
            },
          );
        } else if (state is StudentAttendanceLoading) {
          return const Center(child: CustomCircularProgressIndicator());
        }
        return const SizedBox();
      },
    );
  }

  Map<String, dynamic> _statusDetails({required AttendanceModel record}) {
    String statusLabel;
    Color statusColor;

    const appGreen = Color(0xFF2b836b);
    switch (record.status) {
      case 'ATTEND':
        statusLabel = 'حاضر';
        statusColor = appGreen;
        break;
      case 'MISS':
        statusLabel = 'غائب';
        statusColor = Colors.red;
        break;
      case 'DELAY':
        statusLabel = 'متأخر';
        statusColor = Colors.orange;
        break;
      default:
        statusLabel = record.status;
        statusColor = Colors.grey;
    }
    return {"statusLabel": statusLabel, "statusColor": statusColor};
  }

  String _formatDate(String iso) {
    try {
      final date = DateTime.parse(iso);
      return '${date.day}/${date.month}/${date.year}';
    } catch (_) {
      return iso;
    }
  }
}
