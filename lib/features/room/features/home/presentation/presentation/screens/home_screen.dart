import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/features/room/data/model/student_model.dart';

import '../../data/model/group_model.dart';
import '../bloc/home_bloc_bloc.dart';
import '../widget/class_info_card.dart';
import '../widget/student_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeGroupSelected) {
          final group = state.group as GroupModel;
          final students = List<StudentModel>.from(state.students);
          return Column(
            children: [
              ClassInfoCard(group: group),
              Expanded(
                child: StudentsList(students: students, groupId: group.id),
              ),
            ],
          );
        }
        if (state is HomeLoaded) {
          // fallback: show a message or empty state, since we only support MyGroup now
          return const Center(
            child: Text('يرجى اختيار مجموعة من صفحة المجموعات'),
          );
        } else if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text("حدث خطأ أثناء تحميل البيانات"));
        }
      },
    );
  }
}
