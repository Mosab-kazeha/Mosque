import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/room/features/session/data/models/surah_template_model.dart';
import 'package:saas_mosque/features/room/features/session/presentation/bloc/session_bloc.dart';

class SurahPageGridItem extends StatefulWidget {
  final SurahTemplateModel surahTemplate;
  const SurahPageGridItem({super.key, required this.surahTemplate});

  @override
  State<SurahPageGridItem> createState() => _SurahPageGridItemState();
}

class _SurahPageGridItemState extends State<SurahPageGridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    // final bloc = context.read<SessionBloc>();

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _onSelectPage(context, pageNumber: widget.surahTemplate.pageNumber);
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        value: isSelected,
                        // value: bloc.selectedPages.any(
                        //   (element) =>
                        //       element.pageNumber ==
                        //       widget.surahTemplate.pageNumber,
                        // ),
                        onChanged: (value) {
                          _onSelectPage(
                            context,
                            pageNumber: widget.surahTemplate.pageNumber,
                          );
                        },
                      ),
                    ),
                  ),
                  ResponsiveText(
                    "الصفحة  ${widget.surahTemplate.pageNumber}",
                    textAlign: TextAlign.end,
                    fontSize: FontTextSize.defaultFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const VerticalSpace(8),
              const ResponsiveText(
                "السطور: 1 - 15",
                textAlign: TextAlign.end,
                fontSize: FontTextSize.defaultFontSize,
                color: AppPalette.grey,
              ),
              const VerticalSpace(4),
              const ResponsiveText(
                "الوزن: 1",
                textAlign: TextAlign.end,
                fontSize: FontTextSize.defaultFontSize,
                color: AppPalette.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelectPage(BuildContext context, {required int pageNumber}) {
    final bloc = context.read<SessionBloc>();
    // bool isSelected = bloc.selectedPages.any(
    //   (element) => element.pageNumber == widget.surahTemplate.pageNumber,
    // );

    if (isSelected) {
      setState(() {
        bloc.selectedPages.removeWhere(
          (element) => element.pageNumber == pageNumber,
        );
        // bloc.selectedPages.remove(widget.surahTemplate.pageNumber);
      });
    } else {
      setState(() {
        bloc.selectedPages.add(widget.surahTemplate);
      });
    }

    isSelected = !isSelected;
  }
}
