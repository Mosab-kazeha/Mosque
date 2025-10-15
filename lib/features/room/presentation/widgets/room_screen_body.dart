import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/data/models/group_model.dart';
import 'package:saas_mosque/core/utils/permessions.dart';
import 'package:saas_mosque/core/widget/custom_circular_progress_indicator.dart';
import 'package:saas_mosque/core/widget/custom_failur_screen.dart';
import 'package:saas_mosque/features/curriculum/data/repositories/curriculum_repo.dart';
import 'package:saas_mosque/features/curriculum/presentation/bloc/curriculum_bloc.dart';
import 'package:saas_mosque/features/curriculum/presentation/screens/curriculum_templates_screen.dart';
import 'package:saas_mosque/features/room/features/attendance/data/repositories/attendance_repo.dart';
import 'package:saas_mosque/features/room/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:saas_mosque/features/room/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:saas_mosque/features/room/features/home/presentation/presentation/screens/home_screen.dart';
import 'package:saas_mosque/features/room/features/listening/data/repositories/listening_repo.dart';
import 'package:saas_mosque/features/room/features/listening/presentation/bloc/listening_bloc.dart';
import 'package:saas_mosque/features/room/features/listening/presentation/screens/listening_screen.dart';
import 'package:saas_mosque/features/room/presentation/bloc/room_bloc.dart';
import 'package:saas_mosque/injection_container.dart';

class RoomScreenBody extends StatelessWidget {
  final GroupModel group;
  final int currentIndex;
  const RoomScreenBody({
    super.key,
    required this.group,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomBloc, RoomState>(
      builder: (context, state) {
        if (state is RoomLoading) {
          return const Center(child: CustomCircularProgressIndicator());
        }
        if (state is RoomFailure) {
          return FailureScreen(
            onPressed: () {
              log("the RoomFailure message is${state.message}");
              context.read<RoomBloc>().add(GetPermessions());
            },
          );
        }
        if (state is PermessionsSuccess) {
          // state.permessions = [
          //   Permessions.ATTENDANCE_MANAGEMENT,
          //   Permessions.SAVING_SESSION_MANAGEMENT,
          // ];
          // if (currentIndex >= pages.length) {
          //   currentIndex = 0;
          // }
          return _getPagesByPermessions(state.permessions)[currentIndex];
        }
        return const SizedBox();
      },
    );
  }

  List<Widget> _getPagesByPermessions(List<Permessions> permessions) {
    final pages = <Widget>[];

    pages.add(HomeScreen(group: group));

    if (permessions.contains(Permessions.ATTENDANCE_MANAGEMENT)) {
      pages.add(
        BlocProvider(
          create:
              (context) => AttendanceBloc(serviceLocater.get<AttendanceRepo>()),
          // value: serviceLocater.get<AttendanceBloc>(),
          child: AttendanceScreen(group: group),
        ),
      );
    }

    // if (true) {
    if (permessions.contains(Permessions.SAVING_SESSION_MANAGEMENT)) {
      pages.add(
        BlocProvider(
          create:
              (context) => ListeningBloc(serviceLocater.get<ListeningRepo>()),
          child: ListeningScreen(students: group.students),
        ),
      );

      // pages.add(
      //   BlocProvider(
      //     create:
      //         (context) =>
      //             ListeningBloc(serviceLocater.get<ListeningRepo>())
      //               ..add(FetchListeningData()),
      //     // value: serviceLocater.get<ListeningBloc>()..add(FetchListeningData()),
      //     child: ListeningScreen(students: group.students),
      //   ),
      // );
    }

    // Always show curriculum page for testing - change back to permission check later
    if (permessions.contains(Permessions.CIRRUCULUM_MANAGEMENT)) {
      pages.add(
        BlocProvider(
          create:
              (context) => CurriculumBloc(serviceLocater.get<CurriculumRepo>()),
          child: CurriculumTemplatesScreen(group: group),
        ),
      );
    }

    return pages;
  }
}
