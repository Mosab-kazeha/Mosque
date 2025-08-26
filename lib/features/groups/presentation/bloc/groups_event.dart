part of 'groups_bloc.dart';

@immutable
sealed class GroupsEvent {
  const GroupsEvent();
}

final class GetGroups extends GroupsEvent {}

final class GetPermessions extends GroupsEvent {
  // final int campaignId;

  // const GetPermessions(this.campaignId);
}
