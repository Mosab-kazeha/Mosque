import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/features/room/data/model/student_model.dart';
import 'package:saas_mosque/features/room/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:saas_mosque/features/room/features/attendance/presentation/widget/attendance_list_item.dart';
import 'package:saas_mosque/injection_container.dart';

class AttendanceList extends StatefulWidget {
  final List<StudentModel> students;
  final Map<int, int> delays;
  const AttendanceList({super.key, required this.students, required this.delays});

  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  // Map<int, int> delays = {};

  int? selectedDelay(int studentId) => widget.delays[studentId];

  void setDelay(int studentId, int delay) {
    setState(() => widget.delays[studentId] = delay);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocater.get<AttendanceBloc>(),
      child: Expanded(
        child: ListView.builder(
          itemCount: widget.students.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == widget.students.length - 1 ? 0 : 12,
              ),
              child: AttendanceListItem(
                student: widget.students[index],
                selectedDelay: selectedDelay(widget.students[index].id),
                onSetDelay:
                    (delay) => setDelay(widget.students[index].id, delay),
              ),
            );
          },
        ),
      ),
    );
  }
}
