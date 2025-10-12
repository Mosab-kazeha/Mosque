import 'package:flutter/widgets.dart';
import 'package:saas_mosque/core/utils/educational_text.dart';

class StudentClassLevel extends StatelessWidget {
  final int educationalClass;
  const StudentClassLevel({super.key, required this.educationalClass});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xffd8f4f0),
        borderRadius: BorderRadius.circular(32),
      ),
      child: EducationalClassText(classNumber: educationalClass),
    );
  }
}
