import 'package:flutter/material.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/style/font_style.dart';
import 'package:saas_mosque/core/utils/permessions.dart';
import 'package:saas_mosque/core/widget/responsive_text.dart';
import 'package:saas_mosque/core/widget/spaces.dart';
import 'package:saas_mosque/features/room/data/model/student_model.dart';
import 'package:saas_mosque/features/room/features/student/presentation/widget/student_info_tabbar.dart';
import 'package:saas_mosque/features/room/features/student/presentation/widget/student_saving_sessions_tabbar.dart';
import '../../../../../../core/utils/size_config.dart';
import '../widget/student_attendance_tabbar.dart';

class StudentDetailsScreen extends StatefulWidget {
  final StudentModel student;
  const StudentDetailsScreen({super.key, required this.student});

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final List<Permessions> permessions;
  late final List<Tab> tabs;

  @override
  void initState() {
    super.initState();
    permessions = getPermessionsList(null);
    // permessions = [
    //   Permessions.ATTENDANCE_MANAGEMENT,
    //   Permessions.SAVING_SESSION_MANAGEMENT,
    // ];
    tabs = _getTabsByPermessions();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(iconTheme: const IconThemeData(color: AppPalette.black)),
        body: Column(
          children: [
            VerticalSpace(SizeConfig.width * 0.05),
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
            VerticalSpace(SizeConfig.width * 0.03),
            Center(
              child: ResponsiveText(
                '${widget.student.firstName} ${widget.student.lastName}',
                fontSize: FontTextSize.headingFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            VerticalSpace(SizeConfig.width * 0.05),
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              tabs: tabs,
            ),
            Expanded(
              child: TabBarView(
                children: _getTabBarViewChildrenByPermessions(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Tab> _getTabsByPermessions() {
    final tabs = <Tab>[];

    if (permessions.contains(Permessions.SAVING_SESSION_MANAGEMENT)) {
      tabs.add(const Tab(text: 'تسميع'));
    }

    if (permessions.contains(Permessions.ATTENDANCE_MANAGEMENT)) {
      tabs.add(const Tab(text: 'حضور'));
      tabs.add(const Tab(text: 'معلومات عامة'));
    }

    return tabs;
  }

  List<Widget> _getTabBarViewChildrenByPermessions() {
    final children = <Widget>[];
    if (permessions.contains(Permessions.SAVING_SESSION_MANAGEMENT)) {
      children.add(StudentSavingSessionsTabbar(studentId: widget.student.id));
    }

    if (permessions.contains(Permessions.ATTENDANCE_MANAGEMENT)) {
      children.add(StudentAttendanceTabbar(studentId: widget.student.id));
      children.add(StudentInfoTabbar(studentId: widget.student.id));
    }

    return children;
  }
}
