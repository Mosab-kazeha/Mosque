import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/features/curriculum/data/models/curriculum_node_model.dart';

class TodayLessonHeroSection extends StatelessWidget {
  final CurriculumNodeModel? todayLesson;
  final VoidCallback? onStartLesson;
  final bool isLessonStarted;
  final VoidCallback? onCancel;
  final VoidCallback? onFinish;

  const TodayLessonHeroSection({
    super.key,
    required this.todayLesson,
    this.onStartLesson,
    this.isLessonStarted = false,
    this.onCancel,
    this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    if (todayLesson == null) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppPalette.backgroundColor.withOpacity(0.8),
              AppPalette.backgroundColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'لا يوجد درس اليوم',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppPalette.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppPalette.backgroundColor.withOpacity(0.8),
            AppPalette.backgroundColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'درس اليوم',
            style: TextStyle(
              fontSize: 16,
              color: AppPalette.white,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 12),
          Text(
            todayLesson!.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppPalette.white,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          Text(
            todayLesson!.description,
            style: TextStyle(
              fontSize: 14,
              color: AppPalette.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${todayLesson!.estimatedDurationMinutes} دقيقة',
                style: TextStyle(
                  fontSize: 12,
                  color: AppPalette.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.access_time,
                size: 16,
                color: AppPalette.white.withOpacity(0.9),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (!isLessonStarted)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onStartLesson,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.white,
                  foregroundColor: AppPalette.backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'بدء الدرس',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          if (isLessonStarted)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      foregroundColor: AppPalette.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'إلغاء',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onFinish,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade400,
                      foregroundColor: AppPalette.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'إنهاء',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
