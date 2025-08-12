import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/room/data/model/student_model.dart';
import 'package:saas_mosque/features/room/features/student/presentation/bloc/student_bloc.dart';
import 'package:saas_mosque/features/room/features/student/presentation/widget/student_info_tabbar.dart';
import 'package:saas_mosque/features/room/features/student/presentation/widget/student_saving_sessions_tabbar.dart';

import '../widget/student_attendance_tabbar.dart';

class StudentDetailsScreen extends StatefulWidget {
  final StudentModel student;
  const StudentDetailsScreen({super.key, required this.student});

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);

    _tabController.addListener(() {
      // if (_tabController.index == 1) {
      //   context.read<StudentBloc>().add(
      //     GetStudentAttendance(studentId: widget.student.id),
      //   );
      // }

      if (!_tabController.indexIsChanging) {
        if (_tabController.index == 0) {
          context.read<StudentBloc>().add(
            GetStudentSavingSessions(studentId: widget.student.id),
          );
        }
        if (_tabController.index == 2) {
          context.read<StudentBloc>().add(
            GetStudentInfo(studentId: widget.student.id),
          );
        }
        if (_tabController.index == 1) {
          context.read<StudentBloc>().add(
            GetStudentAttendance(studentId: widget.student.id),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            VerticalSpace(width * 0.05),
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: AppPalette.grey.withAlpha(100),
                child: const Icon(
                  Icons.person,
                  size: 48,
                  color: AppPalette.white,
                ),
              ),
            ),
            VerticalSpace(width * 0.03),
            Center(
              child: ResponsiveText(
                '${widget.student.firstName} ${widget.student.lastName}',
                fontSize: FontTextSize.headingFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            VerticalSpace(width * 0.05),
            TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'تسميع'),
                Tab(text: 'حضور'),
                Tab(text: 'معلومات عامة'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  const StudentSavingSessionsTabbar(),
                  StudentAttendanceTabbar(studentId: widget.student.id),
                  const StudentInfoTabbar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
