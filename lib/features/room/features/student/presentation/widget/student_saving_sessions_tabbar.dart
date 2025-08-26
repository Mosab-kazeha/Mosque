import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/listening_list.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/features/room/features/student/presentation/bloc/student_bloc.dart';

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
          return const Center(child: CircularProgressIndicator());
        }
        if (state is StudentSavingSessionsFailure) {
          return Center(
            child: ResponsiveText(
              state.message,
              fontSize: FontTextSize.bodyFontSize,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
