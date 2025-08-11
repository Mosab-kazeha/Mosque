import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/data/models/group_model.dart';
import 'package:saas_mosque/features/groups/data/repositories/groups_repo.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final GroupsRepo _groupsRepo;

  GroupsBloc(GroupsRepo groupsRepo)
    : _groupsRepo = groupsRepo,
      super(GroupsInitial()) {
    on<GetGroups>((event, emit) async {
      emit(GroupsLoading());
      (await _groupsRepo.getGroups()).fold(
        (l) => emit(GroupsFailure(l.errorMessege)),
        (r) => emit(GroupsSuccess(r)),
      );
    });
  }
}
