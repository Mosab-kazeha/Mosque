import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/features/room/data/model/student_model.dart';
import 'package:saas_mosque/features/room/features/home/presentation/data/model/group_model.dart';
import 'package:saas_mosque/features/room/features/home/presentation/data/repositories/home_repo.dart';

import '../../data/model/home_data_model.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepo _homeRepo;

  HomeBloc(HomeRepo homeRepo) : _homeRepo = homeRepo, super(HomeBlocInitial()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());
      (await _homeRepo.fetchHomeData()).fold(
        (l) => emit(HomeFailure(l.errorMessege)),
        (r) => emit(HomeLoaded(r)),
      );
    });
    on<SetSelectedGroup>((event, emit) async {
      emit(HomeGroupSelected(event.group, event.students));
    });
  }
}
