import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/custom_circular_progress_indicator.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/room/features/session/data/models/evaluation_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/mistake_model.dart';
import 'package:saas_mosque/features/room/features/session/presentation/bloc/session_bloc.dart';
import 'package:saas_mosque/features/room/features/session/presentation/widgets/session_evaluation.dart';
import 'package:saas_mosque/features/room/features/session/presentation/widgets/session_mark.dart';
import 'package:saas_mosque/features/room/features/session/presentation/widgets/session_points.dart';

class SessionDetails extends StatelessWidget {
  // final StudentModel student;
  // final int currentPage;
  // final int startPage;
  // final int endPage;
  // final List<MistakeModel> mistakes;
  // final List<EvaluationModel> evaluations;
  const SessionDetails({
    super.key,
    // required this.student,
    // required this.currentPage,
    // required this.startPage,
    // required this.endPage,
    // required this.mistakes,
    // required this.evaluations,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionBloc>();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(child: _SessionStudentName()),
              Expanded(child: _SessionHearedPages()),
            ],
          ),
          const VerticalSpace(16),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _SessionEvaluationBuilder(_currentEvaluation(context)),
                const HorizontalSpace(16),
                _SessionMarkBuilder(_currentMark(context)),
                const HorizontalSpace(16),
                SessionPoints(
                  evaluation: _currentEvaluation(
                    context,
                    // evaluations,
                    // _currentMark(context),
                  ),
                ),
              ],
            ),
          ),
          const VerticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PageLabel('الصفحة ${bloc.selectedPages.first.pageNumber}'),
              _PageLabel('الصفحة ${bloc.selectedPages.last.pageNumber}'),
            ],
          ),
        ],
      ),
    );
  }

  int _currentMark(BuildContext context) {
    final bloc = context.watch<SessionBloc>();

    final List<MistakeModel> mistakes =
        bloc.sessionMistakes[bloc.selectedPages
            .firstWhere((e) => e.pageNumber == bloc.sessionCurrentPage)
            .id] ??
        [];
    final int totalReduced = mistakes.fold(
      0,
      (sum, m) => sum + (m.reducedMarks!),
    );
    final int mark = 100 - totalReduced;
    return mark < 0 ? 0 : mark;
  }

  EvaluationModel? _currentEvaluation(
    BuildContext context,
    // List<EvaluationModel> evaluations,
    // int currentMark,
  ) {
    final bloc = context.read<SessionBloc>();

    final sorted = List<EvaluationModel>.from(bloc.evaluations)
      ..sort((a, b) => b.minimumMarks.compareTo(a.minimumMarks));

    for (final eval in sorted) {
      if (_currentMark(context) >= eval.minimumMarks) {
        return eval;
      }
    }
    return null;
  }
}

class _PageLabel extends StatelessWidget {
  final String text;
  const _PageLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text),
    );
  }
}

class _SessionStudentName extends StatelessWidget {
  const _SessionStudentName();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const ResponsiveText(
          'اسم الطالب',
          fontSize: FontTextSize.defaultFontSize,
          color: AppPalette.grey,
        ),
        ResponsiveText(
          "${bloc.selectedStudent!.firstName} ${bloc.selectedStudent!.lastName}",
          fontSize: FontTextSize.defaultFontSize,
        ),
      ],
    );
  }
}

class _SessionHearedPages extends StatelessWidget {
  const _SessionHearedPages();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const ResponsiveText(
          'الكمية المسمعة',
          fontSize: FontTextSize.defaultFontSize,
          color: AppPalette.grey,
        ),
        BlocBuilder<SessionBloc, SessionState>(
          buildWhen: (previous, current) => current is EndPageSuccess,
          builder: (context, state) {
            final hearedPages =
                bloc.sessionCurrentPage! - bloc.selectedPages.first.pageNumber;
            return ResponsiveText(
              '$hearedPages صفحات',
              fontSize: FontTextSize.defaultFontSize,
            );
          },
        ),
      ],
    );
  }
}

class _SessionMarkBuilder extends StatelessWidget {
  final int mark;

  const _SessionMarkBuilder(this.mark);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      buildWhen:
          (previous, current) =>
              current is AddMistakeSuccess ||
              current is RemoveMistakeSuccess ||
              current is EndPageSuccess,
      builder: (context, state) {
        return SessionMark(currentMark: mark);
      },
    );
  }
}

class _SessionEvaluationBuilder extends StatelessWidget {
  final EvaluationModel? evaluation;

  const _SessionEvaluationBuilder(this.evaluation);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      buildWhen:
          (previous, current) =>
              current is AddMistakeSuccess ||
              current is RemoveMistakeSuccess ||
              current is EndPageSuccess,
      builder: (context, state) {
        final bloc = context.read<SessionBloc>();

        if (bloc.evaluations.isEmpty) {
          return const SizedBox(
            width: 32,
            height: 32,
            child: CustomCircularProgressIndicator(),
          );
        }
        return SessionEvaluation(evaluation: evaluation);
      },
    );
  }
}
