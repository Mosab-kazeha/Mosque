import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/utils/size_config.dart';
import 'package:saas_mosque/core/widget/custom_circular_progress_indicator.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/room/features/session/data/models/mistake_model.dart';
import 'package:saas_mosque/features/room/features/session/presentation/bloc/session_bloc.dart';

class AddMistakeBottomSheet extends StatefulWidget {
  const AddMistakeBottomSheet({super.key});

  @override
  State<AddMistakeBottomSheet> createState() => _AddMistakeBottomSheetState();
}

class _AddMistakeBottomSheetState extends State<AddMistakeBottomSheet> {
  MistakeModel? selectedMistake;

  @override
  void initState() {
    context.read<SessionBloc>().add(FetchMistakes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        if (state is MistakeLoading) {
          return SizedBox(
            height: SizeConfig.height / 3,
            child: const Center(child: CustomCircularProgressIndicator()),
          );
        }
        if (state is SessionFailure) {
          return SizedBox(
            height: SizeConfig.height / 3,
            child: Center(
              child: ResponsiveText(
                state.message,
                fontSize: FontTextSize.defaultFontSize,
              ),
            ),
          );
        }
        if (state is FetchMistakesSuccess) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 16, right: 16),
                child: ResponsiveText(
                  "إضافة خطأ",
                  fontSize: FontTextSize.bodyFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const VerticalSpace(12),
              ...List.generate(state.mistakes.length, (index) {
                return RadioListTile<MistakeModel>(
                  title: ResponsiveText(
                    state.mistakes[index].title,
                    fontSize: FontTextSize.defaultFontSize,
                  ),
                  value: state.mistakes[index],
                  groupValue: selectedMistake,
                  onChanged: (value) => setState(() => selectedMistake = value),
                );
              }),
              const VerticalSpace(12),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedMistake != null) {
                      context.pop(
                        MistakeModel(
                          id: selectedMistake!.id,
                          title: selectedMistake!.title,
                          campaignId: selectedMistake!.campaignId,
                          isRelated: selectedMistake!.isRelated,
                          reducedMarks: selectedMistake!.reducedMarks,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const ResponsiveText(
                    "إضافة",
                    fontSize: FontTextSize.defaultFontSize,
                    color: AppPalette.white,
                  ),
                ),
              ),
              const VerticalSpace(64),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
