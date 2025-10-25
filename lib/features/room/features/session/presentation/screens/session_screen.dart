import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/utils/size_config.dart';
import 'package:saas_mosque/core/widget/custom_circular_progress_indicator.dart';
import 'package:saas_mosque/core/widget/custom_snack_bar.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/room/features/session/data/models/surah_template_model.dart';
import 'package:saas_mosque/features/room/features/session/presentation/bloc/session_bloc.dart';
import 'package:saas_mosque/features/room/features/session/presentation/widgets/recorded_mistakes.dart';
import 'package:saas_mosque/features/room/features/session/presentation/widgets/session_action_buttons.dart';
import 'package:saas_mosque/features/room/features/session/presentation/widgets/session_details.dart';
import 'package:saas_mosque/features/room/features/session/presentation/widgets/session_timer.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  void initState() {
    final bloc = context.read<SessionBloc>();
    bloc.sessionCurrentPage = bloc.selectedPages.first.pageNumber;
    for (SurahTemplateModel s in bloc.selectedPages) {
      bloc.sessionMistakes[s.id] = [];
    }
    bloc.add(FetchEvaluationsData());
    // bloc.sessionCurrentPage ??= int.parse(bloc.startPageController.text);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionBloc>();
    // final startPage = int.parse(bloc.startPageController.text);
    // final endPage = int.parse(bloc.endPageController.text);
    // final currentPage = bloc.sessionCurrentPage;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppPalette.backgroundColor,
        body: SingleChildScrollView(
          child: BlocConsumer<SessionBloc, SessionState>(
            listener: (context, state) {
              if (state is EndSessionSuccess) {
                context
                  ..pop()
                  ..pop();
                CustomSnackBar.show(context, "تم انهاء الجلسة بنجاح");
              }
            },
            builder: (context, state) {
              if (state is SessionLoading) {
                return SizedBox(
                  height: SizeConfig.height,
                  child: const Center(
                    child: CustomCircularProgressIndicator(
                      color: AppPalette.white,
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  const VerticalSpace(48),
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: IconButton(
                  //     icon: const Icon(Icons.arrow_back, color: Colors.white),
                  //     onPressed: () => context.pop(),
                  //   ),
                  // ),
                  const VerticalSpace(24),
                  const SessionTimer(),
                  const VerticalSpace(32),
                  SessionActionButtons(student: bloc.selectedStudent!),
                  const VerticalSpace(32),
                  const SessionDetails(
                    // student: bloc.selectedStudent!,
                    // currentPage: bloc.sessionCurrentPage!,
                    // startPage: bloc.selectedPages.first,
                    // endPage: bloc.selectedPages.last,
                    // mistakes: bloc.sessionMistakes,
                    // evaluations: const [],
                  ),
                  // BlocBuilder<SessionBloc, SessionState>(
                  //   builder: (context, state) {
                  //     if (state is EvaluationsSuccess) {
                  //       return SessionDetails(
                  //         student: bloc.selectedStudent!,
                  //         currentPage: bloc.sessionCurrentPage!,
                  //         // currentPage: currentPage ?? startPage,
                  //         startPage: bloc.selectedPages.first,
                  //         // startPage: startPage,
                  //         endPage: bloc.selectedPages.last,
                  //         // endPage: endPage,
                  //         mistakes: bloc.sessionMistakes,
                  //         evaluations: state.evaluations,
                  //       );
                  //     }
                  //     return const SizedBox();
                  //   },
                  // ),
                  const VerticalSpace(32),
                  RecordedMistakes(
                    mistakes:
                        bloc.sessionMistakes[bloc.selectedPages
                            .firstWhere(
                              (e) => e.pageNumber == bloc.sessionCurrentPage,
                            )
                            .id] ??
                        [],
                  ),
                  const VerticalSpace(8),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
