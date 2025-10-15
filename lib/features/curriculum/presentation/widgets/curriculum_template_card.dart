import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/features/curriculum/data/models/curriculum_template_model.dart';

class CurriculumTemplateCard extends StatelessWidget {
  final CurriculumTemplateModel template;
  final VoidCallback onTap;

  const CurriculumTemplateCard({
    super.key,
    required this.template,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                template.curriculum.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppPalette.backgroundColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                template.curriculum.description,
                style: const TextStyle(fontSize: 14, color: AppPalette.grey),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.book, size: 16, color: AppPalette.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${template.nodes.length} درس',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppPalette.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
