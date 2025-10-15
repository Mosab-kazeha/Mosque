import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/style/app_palette.dart';
import 'package:saas_mosque/core/utils/permessions.dart';
import 'package:saas_mosque/features/room/presentation/bloc/room_bloc.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTap;
  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomBloc, RoomState>(
      builder: (context, state) {
        if (state is PermessionsSuccess) {
          // state.permessions = [
          //   Permessions.ATTENDANCE_MANAGEMENT,
          //   Permessions.SAVING_SESSION_MANAGEMENT,
          // ];
          final items = _getItemsByPermessions(state.permessions);

          // if (items.length < 2) {
          //   return const SizedBox();
          // }

          return BottomNavigationBar(
            currentIndex: currentIndex,
            items: items,
            onTap: onTap,
            selectedItemColor: AppPalette.backgroundColor,
            unselectedItemColor: AppPalette.grey,
          );
        }
        return const SizedBox();
      },
    );
  }

  List<BottomNavigationBarItem> _getItemsByPermessions(
    List<Permessions> permessions,
  ) {
    final items = <BottomNavigationBarItem>[];

    items.add(
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
    );

    if (permessions.contains(Permessions.ATTENDANCE_MANAGEMENT)) {
      items.add(
        const BottomNavigationBarItem(icon: Icon(Icons.check), label: 'الحضور'),
      );
    }

    // if (true) {
    if (permessions.contains(Permessions.SAVING_SESSION_MANAGEMENT)) {
      items.add(
        const BottomNavigationBarItem(icon: Icon(Icons.book), label: 'التسميع'),
      );
    }

    // Always show curriculum tab for testing - change back to permission check later
    if (permessions.contains(Permessions.CIRRUCULUM_MANAGEMENT)) {
      items.add(
        const BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'الدروس',
        ),
      );
    }

    return items;
  }
}
