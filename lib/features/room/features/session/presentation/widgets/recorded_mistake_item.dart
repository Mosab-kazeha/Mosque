import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/utils/size_config.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/room/features/session/data/models/mistake_model.dart';
import 'package:saas_mosque/features/room/features/session/presentation/bloc/session_bloc.dart';

class RecordedMistakeItem extends StatelessWidget {
  final MistakeModel mistake;
  final int index;
  const RecordedMistakeItem({
    super.key,
    required this.mistake,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: InkWell(
        onTap: () {
          final bloc = context.read<SessionBloc>();
          bloc.add(
            RemoveMistake(
              mistake: mistake,
              templateId:
                  bloc.selectedPages
                      .firstWhere(
                        (e) => e.pageNumber == bloc.sessionCurrentPage,
                      )
                      .id,
            ),
          );
        },
        child: const Icon(Icons.close, color: AppPalette.grey),
      ),
      trailing: SizedBox(
        width: SizeConfig.width / 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(48),
              ),
              child: ResponsiveText(
                '-${mistake.reducedMarks} نقاط',
                fontSize: FontTextSize.defaultFontSize,
                color: AppPalette.white,
              ),
            ),
            const HorizontalSpace(8),
            ResponsiveText(
              mistake.title,
              fontSize: FontTextSize.defaultFontSize,
            ),
            const HorizontalSpace(4),
            const Icon(Icons.error_outline, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
