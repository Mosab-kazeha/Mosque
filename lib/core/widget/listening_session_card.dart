import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/room/features/listening/data/models/listening_model.dart';

class ListeningSessionCard extends StatelessWidget {
  final ListeningModel listeningData;
  const ListeningSessionCard({super.key, required this.listeningData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppPalette.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppPalette.black.withAlpha(5),
            // color: Colors.black.w(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getPerformanceColor(listeningData.evaluation.title),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ResponsiveText(
                    listeningData.evaluation.title,
                    color: AppPalette.white,
                    fontSize: FontTextSize.smallFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ResponsiveText(
                        "${listeningData.student.firstName} ${listeningData.student.lastName}",
                        fontSize: FontTextSize.bodyFontSize,
                        fontWeight: FontWeight.w600,
                        color: AppPalette.black,
                      ),
                      const VerticalSpace(2),
                      ResponsiveText(
                        "من ${listeningData.start} إلى ${listeningData.end}",
                        fontSize: FontTextSize.smallFontSize,
                        color: AppPalette.grey,
                      ),
                    ],
                  ),
                ),
                const HorizontalSpace(12),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: ResponsiveText(
                      "${listeningData.student.firstName[0]}${listeningData.student.lastName[0]}",
                      color: AppPalette.white,
                      fontWeight: FontWeight.bold,
                      fontSize: FontTextSize.bodyFontSize,
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpace(16),

            // Stats section with light background
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 16,
                              color: Colors.blue[600],
                            ),
                            const HorizontalSpace(4),
                            ResponsiveText(
                              "التقييم",
                              fontSize: FontTextSize.smallFontSize,
                              color: Colors.grey[600],
                            ),
                          ],
                        ),
                        const VerticalSpace(4),
                        ResponsiveText(
                          "${listeningData.evaluation.points}",
                          fontSize: FontTextSize.titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 16,
                              color: Colors.blue[600],
                            ),
                            const HorizontalSpace(4),
                            ResponsiveText(
                              "مدة التسميع",
                              fontSize: FontTextSize.smallFontSize,
                              color: Colors.grey[600],
                            ),
                          ],
                        ),
                        const VerticalSpace(4),
                        ResponsiveText(
                          _formatDuration(listeningData.duration),
                          fontSize: FontTextSize.titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline_rounded,
                              size: 16,
                              color: Colors.red[400],
                            ),
                            const HorizontalSpace(4),
                            ResponsiveText(
                              "الأخطاء",
                              fontSize: FontTextSize.smallFontSize,
                              color: Colors.grey[600],
                            ),
                          ],
                        ),
                        const VerticalSpace(4),
                        ResponsiveText(
                          "${listeningData.mistakes.length}",
                          fontSize: FontTextSize.titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Mistakes section (if any)
            if (listeningData.mistakes.isNotEmpty) ...[
              const VerticalSpace(12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children:
                          listeningData.mistakes.map((mistake) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.red[200]!),
                              ),
                              child: ResponsiveText(
                                mistake.title,
                                fontSize: FontTextSize.smallFontSize,
                                color: Colors.red[700],
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getPerformanceColor(String performance) {
    switch (performance.toLowerCase()) {
      case 'excellent':
        return const Color(0xFF10B981); // Green
      case 'good':
        return const Color(0xFF3B82F6); // Blue
      case 'average':
        return const Color(0xFFF59E0B); // Orange/Yellow
      case 'needs improvement':
        return const Color(0xFFEF4444); // Red
      default:
        return const Color(0xFF6B7280); // Gray
    }
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
