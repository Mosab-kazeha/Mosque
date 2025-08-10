part of 'campaigns_bloc.dart';

@immutable
sealed class GroupsState {
  const GroupsState();
}

final class GroupsInitial extends GroupsState {}

final class GroupsLoading extends GroupsState {}

final class GroupsSuccess extends GroupsState {
  final List<GroupModel> groups;

  const GroupsSuccess(this.groups);
}

final class GroupsFailure extends GroupsState {
  final String message;

  const GroupsFailure(this.message);
}
