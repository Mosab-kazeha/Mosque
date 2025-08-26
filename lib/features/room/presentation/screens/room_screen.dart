import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/data/models/group_model.dart';
import 'package:saas_mosque/core/widget/custom_app_bar.dart';
import 'package:saas_mosque/features/room/presentation/bloc/room_bloc.dart';
import 'package:saas_mosque/features/room/presentation/widgets/custom_drawer.dart';
import 'package:saas_mosque/features/room/presentation/widgets/room_screen_body.dart';
import 'package:saas_mosque/features/room/presentation/widgets/custom_navigation_bar.dart';

class RoomScreen extends StatefulWidget {
  final GroupModel group;
  const RoomScreen({super.key, required this.group});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    // serviceLocater.get<RoomBloc>().add(GetPermessions());
    context.read<RoomBloc>().add(GetPermessions());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f6fb),
      appBar: const CustomAppBar(title: 'منصة حلقات'),
      endDrawer: const CustomDrawer(),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: RoomScreenBody(group: widget.group, currentIndex: currentIndex),
    );
  }
}
