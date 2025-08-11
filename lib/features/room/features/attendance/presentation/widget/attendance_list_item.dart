import 'package:flutter/material.dart';import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/features/room/features/attendance/presentation/widget/status_button.dart';
import '../../../../../../core/utils/educational_text.dart';
import '../../../../data/model/student_model.dart';

class AttendanceListItem extends StatelessWidget {
  final StudentModel student;
  final int? selectedDelay;
  final Function(int) onSetDelay;

  const AttendanceListItem({
    super.key,
    required this.student,
    required this.selectedDelay,
    required this.onSetDelay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              StatusButton(
                label: 'متأخر',
                delayValue: 500,
                color: Colors.orange,
                onSetDelay: onSetDelay,
                selected: selectedDelay,

              ),
              StatusButton(
                label: 'غائب',
                delayValue: 1000,
                color: Colors.pink,
                onSetDelay: onSetDelay,
                selected: selectedDelay,
              ),
              StatusButton(
                label: 'حاضر',
                delayValue: 0,
                color: Colors.lightBlue,
                onSetDelay: onSetDelay,
                selected: selectedDelay,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ResponsiveText(
                "${student.firstName} ${student.lastName}",
                fontSize: FontTextSize.bodyFontSize,
                fontWeight: FontWeight.bold,
              ),
              EducationalClassText(classNumber: student.educationalClass),
            ],
          ),
        ],
      ),
    );
  }
}
