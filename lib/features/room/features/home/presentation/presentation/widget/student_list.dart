import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saas_mosque/core/router/routes_config.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/utils/permessions.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/room/features/home/presentation/presentation/widget/student_class_level.dart';
import '../../../../../../../core/style/font_style.dart';
import '../../../../../data/model/student_model.dart';

class StudentsList extends StatelessWidget {
  final List<StudentModel> students;
  final int groupId;

  const StudentsList({
    super.key,
    required this.students,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: students.length,
      separatorBuilder: (_, __) => const VerticalSpace(12),
      itemBuilder: (context, index) {
        final student = students[index];
        return InkWell(
          onTap: () {
            final permessions = getPermessionsList(null);
            if (!(permessions.contains(Permessions.ATTENDANCE_MANAGEMENT) ||
                permessions.contains(Permessions.SAVING_SESSION_MANAGEMENT))) {
              return;
            }
            context.push(AppRoutes.kStudentScreen, extra: student);
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _StudentActions(student),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ResponsiveText(
                      "${student.firstName} ${student.lastName}",
                      textAlign: TextAlign.right,
                      fontSize: FontTextSize.subTitleFontSize,
                    ),
                    const VerticalSpace(8),
                    StudentClassLevel(
                      educationalClass: student.educationalClass,
                    ),
                  ],
                ),
                const HorizontalSpace(12),
                const CircleAvatar(
                  // backgroundImage: NetworkImage(
                  //   student.imageUrl ?? 'https://via.placeholder.com/150',
                  // ),
                  backgroundColor: AppPalette.cardBorderColor1,
                  radius: 24,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StudentActions extends StatelessWidget {
  final StudentModel student;
  const _StudentActions(this.student);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            context.push(AppRoutes.kSurahsScreen, extra: student);
          },
          child: const Icon(Icons.play_arrow_outlined, size: 24),
        ),
        // const HorizontalSpace(8),
        // InkWell(
        //   borderRadius: BorderRadius.circular(100),
        //   onTap: () {},
        //   child: const Icon(Icons.add, size: 24),
        // ),
      ],
    );
  }
}
