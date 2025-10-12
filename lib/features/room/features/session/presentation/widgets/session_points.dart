import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/features/room/features/session/data/models/evaluation_model.dart';

class SessionPoints extends StatelessWidget {
  final EvaluationModel? evaluation;
  const SessionPoints({super.key, required this.evaluation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const ResponsiveText(
          'النقاط',
          fontSize: FontTextSize.defaultFontSize,
          color: AppPalette.grey,
        ),
        ResponsiveText(
          _text(evaluation),
          fontSize: FontTextSize.defaultFontSize,
          color: AppPalette.grey,
        ),
      ],
    );
  }

  String _text(EvaluationModel? evaluation) {
    final points = evaluation?.points ?? 0;
    return points.toString();
  }
}
