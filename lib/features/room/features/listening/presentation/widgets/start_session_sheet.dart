import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saas_mosque/core/router/routes_config.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/custom_snack_bar.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/room/data/model/student_model.dart';

class StartSessionSheet extends StatefulWidget {
  final List<StudentModel> students;
  const StartSessionSheet({super.key, required this.students});

  @override
  State<StartSessionSheet> createState() => _StartSessionSheetState();
}

class _StartSessionSheetState extends State<StartSessionSheet> {
  StudentModel? selectedStudent;
  late final TextEditingController startPageController;
  late final TextEditingController endPageController;

  @override
  void initState() {
    startPageController = TextEditingController();
    endPageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    startPageController.dispose();
    endPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 16,
        left: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const ResponsiveText(
              "جلسة تسميع جديدة",
              fontSize: FontTextSize.bodyFontSize,
              fontWeight: FontWeight.bold,
            ),
            const VerticalSpace(12),
            DropdownButtonFormField<StudentModel>(
              value: selectedStudent,
              items:
                  widget.students.map((StudentModel student) {
                    return DropdownMenuItem<StudentModel>(
                      value: student,
                      child: ResponsiveText(
                        "${student.firstName} ${student.lastName}",
                      ),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedStudent = value;
                });
              },
              decoration: const InputDecoration(
                labelText: "اسم الطالب",
                border: OutlineInputBorder(),
              ),
            ),
            const VerticalSpace(12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: startPageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "صفحة البداية",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const HorizontalSpace(10),
                Expanded(
                  child: TextField(
                    controller: endPageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "صفحة النهاية",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const HorizontalSpace(20),
            SizedBox(
              width: double.infinity,
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (selectedStudent == null ||
                          startPageController.text.isEmpty ||
                          endPageController.text.isEmpty) {
                        CustomSnackBar.show(context, 'يرجى تعبئة جميع الحقول');
                        return;
                      }

                      context.pop();

                      context.push(AppRoutes.kSessionScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPalette.buttonColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const ResponsiveText(
                      "بدء جلسة التسميع",
                      color: AppPalette.white,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
