import 'package:flutter/material.dart';
import 'package:saas_mosque/core/widget/custom_app_bar.dart';
import 'package:saas_mosque/features/room/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:saas_mosque/features/room/features/home/presentation/presentation/screens/home_screen.dart';
import 'package:saas_mosque/features/room/features/listening/presentation/screens/listening_screen.dart';
import 'package:saas_mosque/features/room/presentation/widgets/custom_drawer.dart';
import 'package:saas_mosque/features/room/presentation/widgets/custom_navigation_bar.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'منصة حلقات'),
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
        children: const [AttendanceScreen(), HomeScreen(), ListeningScreen()],
      ),
    );
  }
}
