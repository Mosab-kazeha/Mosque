import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saas_mosque/features/room/model/student_model.dart';
import 'package:saas_mosque/features/room/features/home/presentation/data/model/group_model.dart';

import '../../data/model/home_data_model.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeBlocInitial()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        // final data = await repo.getHomeData();
        // emit(HomeLoaded(data));
      } catch (e, stackTrace) {
        print("❌ Error: $e");
        print("📌 StackTrace: $stackTrace");
        emit(HomeError(""));
      }
    });
    on<SetSelectedGroup>((event, emit) async {
      emit(HomeGroupSelected(event.group, event.students));
    });
  }
}
