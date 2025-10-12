import 'package:flutter/material.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';

import '../../../../../../../core/style/font_style.dart';
import '../../../../../../../core/data/models/group_model.dart';

class ClassInfoCard extends StatelessWidget {
  final GroupModel group;

  const ClassInfoCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ResponsiveText(
            group.title,
            fontSize: FontTextSize.bodyFontSize,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
