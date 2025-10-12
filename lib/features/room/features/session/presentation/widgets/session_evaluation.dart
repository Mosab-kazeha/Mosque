import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/features/room/features/session/data/models/evaluation_model.dart';

class SessionEvaluation extends StatelessWidget {
  final EvaluationModel? evaluation;
  const SessionEvaluation({super.key, required this.evaluation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ResponsiveText(
          'التقييم الحالي',
          fontSize: FontTextSize.defaultFontSize,
          color: AppPalette.grey,
        ),
        ResponsiveText(
          _text(evaluation),
          fontSize: FontTextSize.bodyFontSize,
          fontWeight: FontWeight.bold,
          color: _color(evaluation),
        ),
      ],
    );
  }

  String _text(EvaluationModel? evaluation) {
    final isFail = evaluation == null;
    return isFail ? 'راسب' : evaluation.title;
  }

  Color _color(EvaluationModel? evaluation) {
    final isFail = evaluation == null;
    return isFail ? Colors.red : Colors.teal;
  }
}
