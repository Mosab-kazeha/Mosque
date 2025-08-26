import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/widget/custom_failur_screen.dart';
import 'package:saas_mosque/features/room/data/model/student_model.dart';
import 'package:saas_mosque/features/room/features/listening/presentation/bloc/listening_bloc.dart';
import 'package:saas_mosque/features/room/features/listening/presentation/widgets/listening_info_banner.dart';
import 'package:saas_mosque/core/widget/listening_list.dart';
import 'package:saas_mosque/features/room/features/listening/presentation/widgets/start_session_button.dart';

import '../../../../../../core/widget/custom_circular_progress_indicator.dart';

class ListeningScreen extends StatelessWidget {
  final List<StudentModel> students;
  const ListeningScreen({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListeningBloc, ListeningState>(
      builder: (context, state) {
        if (state is ListeningLoading) {
          return Center(child: CustomCircularProgressIndicator());
        }
        if (state is ListeningFailure) {
          return FailureScreen(
            onPressed: () {
              log("the ListeningFailure message is${state.message}");

              context.read<ListeningBloc>().add(FetchListeningData());
            },
          );
        }
        if (state is ListeningSuccess) {
          return Column(
            children: [
              const ListeningInfoBanner(),
              StartSessionButton(students: students),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    // context.read<ListeningBloc>().add(LoadListening());
                  },
                  child: ListeningList(listenings: state.listenings),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
