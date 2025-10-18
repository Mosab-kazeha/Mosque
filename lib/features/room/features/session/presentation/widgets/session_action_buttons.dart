import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/features/room/data/model/student_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/mistake_model.dart';
import 'package:saas_mosque/features/room/features/session/data/models/submit_session_model.dart';
import 'package:saas_mosque/features/room/features/session/presentation/bloc/session_bloc.dart';
import 'package:saas_mosque/features/room/features/session/presentation/widgets/add_mistake_bottom_sheet.dart';
import 'package:saas_mosque/features/room/features/session/presentation/widgets/session_button.dart';
import 'package:saas_mosque/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionActionButtons extends StatelessWidget {
  final StudentModel student;
  const SessionActionButtons({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SessionButton(
          text: 'إنهاء الجلسة',
          onPressed: () {
            _onEndSession(context);
          },
        ),
        SessionButton(
          text: 'إنهاء الصفحة',
          onPressed: () {
            _onEndPage(context);
          },
        ),
        SessionButton(
          text: 'إضافة خطأ',
          onPressed: () async {
            await _onAddMistake(context);
          },
        ),
      ],
    );
  }

  void _onEndSession(BuildContext context) {
    final bloc = context.read<SessionBloc>();

    final teacherIdString = serviceLocater.get<SharedPreferences>().getString(
      'teacher-id',
    );
    log(
      'SessionActionButtons: Retrieved teacher-id from SharedPreferences: $teacherIdString',
    );

    if (teacherIdString == null) {
      log(
        'SessionActionButtons: CRITICAL ERROR - teacher-id is NULL! This will cause a crash!',
      );
      // Handle null case gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('خطأ: معرف المعلم غير موجود')),
      );
      return;
    }

    final teacherId = int.parse(teacherIdString);
    final campaignId =
        serviceLocater.get<SharedPreferences>().getInt('campaign-id')!;

    final session = SubmitSessionModel(
      teacherId: teacherId,
      studentId: student.id,
      campaignId: campaignId,
      evaluationId: bloc.evaluations.first.id,
      startPage: bloc.selectedPages.first.pageNumber,
      endPage: bloc.selectedPages.last.pageNumber,
      rating: 10,
      durationSeconds: bloc.sessionDurationSeconds,
      totalScore: bloc.calculateSessionTotals()['total_score']!.toInt(),
      maxPossibleScore:
          bloc.calculateSessionTotals()['max_possible_score']!.toInt(),
      sessionSurahs: bloc.sessionSurahs,
    );

    bloc.add(EndSession(session));
  }

  void _onEndPage(BuildContext context) {
    final bloc = context.read<SessionBloc>();

    bloc.add(EndPage());
  }

  Future<void> _onAddMistake(BuildContext context) async {
    final bloc = context.read<SessionBloc>();

    await showModalBottomSheet<MistakeModel>(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => BlocProvider.value(
            value: serviceLocater.get<SessionBloc>(),
            child: const AddMistakeBottomSheet(),
          ),
    ).then((value) {
      if (value != null) {
        bloc.add(
          AddMistake(
            mistake: value.copyWith(pageNumber: bloc.sessionCurrentPage),
            templateId:
                bloc.selectedPages
                    .firstWhere(
                      (element) =>
                          element.pageNumber == bloc.sessionCurrentPage,
                    )
                    .id,
          ),
        );
      }
    });
  }
}
