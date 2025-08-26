import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/room/features/student/presentation/bloc/student_bloc.dart';

import '../../../../../../core/style/font_style.dart';
import '../../../../../../core/widget/responsive_text.dart';

class StudentInfoTabbar extends StatefulWidget {
  final int studentId;
  const StudentInfoTabbar({super.key, required this.studentId});

  @override
  State<StudentInfoTabbar> createState() => _StudentInfoTabbarState();
}

class _StudentInfoTabbarState extends State<StudentInfoTabbar> {
  @override
  void initState() {
    context.read<StudentBloc>().add(
      GetStudentInfo(studentId: widget.studentId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is StudentInfoSuccess) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.student.length,
            separatorBuilder:
                (_, __) => const Divider(height: 24, color: AppPalette.grey),
            itemBuilder: (context, index) {
              final item = state.student[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: ResponsiveText(
                      item['value'] ?? '-',
                      fontSize: FontTextSize.bodyFontSize,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const VerticalSpace(12),
                  Expanded(
                    flex: 2,
                    child: ResponsiveText(
                      textAlign: TextAlign.right,
                      fontSize: FontTextSize.bodyFontSize,
                      item['label']!,
                      color: AppPalette.grey,
                    ),
                  ),
                ],
              );
            },
          );
        } else if (state is StudentInfoFailure) {
          return Center(
            child: ResponsiveText(
              state.message,
              fontSize: FontTextSize.bodyFontSize,
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
