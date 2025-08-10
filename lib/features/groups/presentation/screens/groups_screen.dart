import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/data/models/group_model.dart';
import 'package:saas_mosque/core/widget/custom_app_bar.dart';
import 'package:saas_mosque/features/groups/presentation/bloc/campaigns_bloc.dart';
import 'package:saas_mosque/features/groups/presentation/widgets/groups_list.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الحلقات'),
      body: BlocBuilder<GroupsBloc, GroupsState>(
        builder: (context, state) {
          if (state is GroupsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GroupsFailure) {
            return Text(state.message);
          }
          if (state is GroupsSuccess) {
            return _checkGroupsData(state.groups);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _checkGroupsData(List<GroupModel> groups) {
    if (groups.isEmpty) {
      return const Text('No Groups');
    }
    return GroupsList(groups: groups);
  }
}
