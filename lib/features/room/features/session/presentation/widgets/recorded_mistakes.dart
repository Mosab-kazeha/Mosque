import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/room/features/session/data/models/mistake_model.dart';
import 'package:saas_mosque/features/room/features/session/presentation/bloc/session_bloc.dart';
import 'package:saas_mosque/features/room/features/session/presentation/widgets/recorded_mistake_item.dart';

class RecordedMistakes extends StatelessWidget {
  final List<MistakeModel> mistakes;
  const RecordedMistakes({super.key, required this.mistakes});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      buildWhen:
          (previous, current) =>
              current is AddMistakeSuccess || current is RemoveMistakeSuccess,
      builder: (context, state) {
        if (mistakes.isEmpty) {
          return const SizedBox();
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppPalette.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ResponsiveText(
                'الأخطاء المسجلة',
                fontSize: FontTextSize.bodyFontSize,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.right,
              ),
              const VerticalSpace(8),
              // if (mistakes.isEmpty)
              //   const Center(
              //     child: ResponsiveText(
              //       'لا يوجد أخطاء بعد',
              //       fontSize: FontTextSize.bodyFontSize,
              //     ),
              //   ),
              ...List.generate(
                mistakes.length,
                (index) => Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: .15),
                    border: Border.all(
                      color: Colors.redAccent.withValues(alpha: .5),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: RecordedMistakeItem(
                    mistake: mistakes[index],
                    index: index,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
