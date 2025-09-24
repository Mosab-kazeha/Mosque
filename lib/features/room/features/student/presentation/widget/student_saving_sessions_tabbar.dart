import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/widget/custom_failur_screen.dart';
import 'package:saas_mosque/core/widget/listening_list.dart';
import 'package:saas_mosque/features/room/features/student/presentation/bloc/student_bloc.dart';

import '../../../../../../core/widget/custom_circular_progress_indicator.dart';

class StudentSavingSessionsTabbar extends StatefulWidget {
  final int studentId;
  const StudentSavingSessionsTabbar({super.key, required this.studentId});

  @override
  State<StudentSavingSessionsTabbar> createState() =>
      _StudentSavingSessionsTabbarState();
}

class _StudentSavingSessionsTabbarState
    extends State<StudentSavingSessionsTabbar> {
  @override
  void initState() {
    context.read<StudentBloc>().add(
      GetStudentSavingSessions(studentId: widget.studentId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is StudentSavingSessionsSuccess) {
          return ListeningList(listenings: state.sessions);
        }
        if (state is StudentSavingSessionsLoading) {
          return const Center(child: CustomCircularProgressIndicator());
        }
        if (state is StudentSavingSessionsFailure) {
          return FailureScreen(
            onPressed: () {
              log(
                "the StudentSavingSessionsFailure message is${state.message}",
              );
              context.read<StudentBloc>().add(
                GetStudentSavingSessions(studentId: widget.studentId),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
