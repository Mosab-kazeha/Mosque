import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/data/models/group_model.dart';
import 'package:saas_mosque/core/widget/custom_app_bar.dart';
import 'package:saas_mosque/features/room/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:saas_mosque/features/room/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:saas_mosque/features/room/features/home/presentation/presentation/screens/home_screen.dart';
import 'package:saas_mosque/features/room/features/listening/presentation/screens/listening_screen.dart';
import 'package:saas_mosque/features/room/presentation/widgets/custom_drawer.dart';
import 'package:saas_mosque/features/room/presentation/widgets/custom_navigation_bar.dart';
import 'package:saas_mosque/injection_container.dart';

class RoomScreen extends StatefulWidget {
  final GroupModel group;
  const RoomScreen({super.key, required this.group});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f6fb),
      appBar: const CustomAppBar(title: 'منصة حلقات'),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      endDrawer: const CustomDrawer(),
      body: IndexedStack(
        index: currentIndex,
        children: [
          BlocProvider(
            create: (context) => serviceLocater.get<AttendanceBloc>(),
            child: AttendanceScreen(group: widget.group),
          ),
          HomeScreen(group: widget.group),
          const ListeningScreen(),
        ],
      ),
    );
  }
}
