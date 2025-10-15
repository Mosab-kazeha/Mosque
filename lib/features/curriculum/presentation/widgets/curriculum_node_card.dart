import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/features/curriculum/data/models/curriculum_node_model.dart';

class CurriculumNodeCard extends StatelessWidget {
  final CurriculumNodeModel node;

  const CurriculumNodeCard({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    node.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildStatusBadge(node.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              node.description,
              style: const TextStyle(fontSize: 14, color: AppPalette.grey),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: AppPalette.grey),
                const SizedBox(width: 4),
                Text(
                  '${node.estimatedDurationMinutes} دقيقة',
                  style: const TextStyle(fontSize: 12, color: AppPalette.grey),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.category, size: 16, color: AppPalette.grey),
                const SizedBox(width: 4),
                Text(
                  node.nodeType,
                  style: const TextStyle(fontSize: 12, color: AppPalette.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (status) {
      case 'PLANNED':
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade700;
        label = 'مخطط';
        break;
      case 'IN_PROGRESS':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade700;
        label = 'جاري';
        break;
      case 'COMPLETED':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade700;
        label = 'مكتمل';
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade700;
        label = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
