import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/data/models/group_model.dart';
import 'package:saas_mosque/core/widget/custom_app_bar.dart';
import 'package:saas_mosque/features/groups/presentation/bloc/groups_bloc.dart';
import 'package:saas_mosque/features/groups/presentation/widgets/groups_list.dart';
import 'package:saas_mosque/features/room/presentation/widgets/custom_drawer.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  @override
  void initState() {
    // serviceLocater<GroupsBloc>().add(GetGroups());
    context.read<GroupsBloc>().add(GetGroups());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الحلقات'),
      endDrawer: const CustomDrawer(),
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
