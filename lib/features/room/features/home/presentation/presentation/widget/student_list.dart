import 'package:flutter/material.dart';
import 'package:saas_mosque/core/widget/spaces.dart';

import '../../../../../../../core/utils/educational_text.dart';
import '../../../../../model/student_model.dart';

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
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder:
            //         (context) => StudentDetailsScreen(
            //           student: student,
            //           groupId: groupId,
            //         ),
            //   ),
            // );
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffd8f4f0),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: EducationalClassText(
                    classNumber: student.educationalClass,
                  ),
                ),
                // Expanded(
                //   child: Text(
                //     "${student.firstName} ${student.lastName}",
                //     textAlign: TextAlign.right,
                //     style: FontStyles.bodyText.copyWith(
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                const HorizontalSpace(12),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    student.imageUrl ?? 'https://via.placeholder.com/150',
                  ),
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
