import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saas_mosque/core/style/app_palette.dart';

class LessonSessionData {
  final String notes;
  final int sessionNumber;
  final int durationMinutes;
  final bool isFinished;

  LessonSessionData({
    required this.notes,
    required this.sessionNumber,
    required this.durationMinutes,
    required this.isFinished,
  });
}

class LessonNotesBottomSheet extends StatefulWidget {
  final Function(LessonSessionData) onSubmit;

  const LessonNotesBottomSheet({super.key, required this.onSubmit});

  @override
  State<LessonNotesBottomSheet> createState() => _LessonNotesBottomSheetState();
}

class _LessonNotesBottomSheetState extends State<LessonNotesBottomSheet> {
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _sessionNumberController = TextEditingController(
    text: '1',
  );
  final TextEditingController _durationController = TextEditingController(
    text: '60',
  );
  bool _isFinished = true;

  @override
  void dispose() {
    _notesController.dispose();
    _sessionNumberController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'تفاصيل الجلسة',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Session Number Input
          TextField(
            controller: _sessionNumberController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: 'رقم الجلسة',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppPalette.backgroundColor,
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Duration Input
          TextField(
            controller: _durationController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: 'مدة الجلسة (بالدقائق)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppPalette.backgroundColor,
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Is Finished Switch
          Row(
            children: [
              const Text('هل تم إنهاء الجلسة؟', style: TextStyle(fontSize: 16)),
              const Spacer(),
              Switch(
                value: _isFinished,
                onChanged: (value) {
                  setState(() {
                    _isFinished = value;
                  });
                },
                activeColor: AppPalette.backgroundColor,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Notes Input
          TextField(
            controller: _notesController,
            maxLines: 4,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              labelText: 'ملاحظات الجلسة',
              hintText: 'أضف ملاحظاتك هنا...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppPalette.backgroundColor,
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final sessionData = LessonSessionData(
                  notes: _notesController.text,
                  sessionNumber:
                      int.tryParse(_sessionNumberController.text) ?? 1,
                  durationMinutes: int.tryParse(_durationController.text) ?? 60,
                  isFinished: _isFinished,
                );
                widget.onSubmit(sessionData);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.backgroundColor,
                foregroundColor: AppPalette.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'إرسال',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
