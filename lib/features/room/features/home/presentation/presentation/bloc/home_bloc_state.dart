part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeBlocInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeDataModel data;
  HomeLoaded(this.data);
}

class HomeGroupSelected extends HomeState {
  final dynamic group;
  final List<StudentModel> students;
  HomeGroupSelected(this.group, this.students);
}

class HomeFailure extends HomeState {
  final String message;
  HomeFailure(this.message);
}
