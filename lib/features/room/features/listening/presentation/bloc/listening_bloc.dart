import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/features/room/features/listening/data/models/listening_model.dart';
import 'package:saas_mosque/features/room/features/listening/data/repositories/listening_repo.dart';
import 'package:flutter/material.dart';

part 'listening_event.dart';
part 'listening_state.dart';

class ListeningBloc extends Bloc<ListeningEvent, ListeningState> {
  final ListeningRepo _listeningRepo;

  ListeningBloc(ListeningRepo listeningRepo)
    : _listeningRepo = listeningRepo,
      super(ListeningInitial()) {
    on<FetchListeningData>((event, emit) async {
      emit(ListeningLoading());
      (await _listeningRepo.fetchListeningData()).fold(
        (l) => emit(ListeningFailure(l.errorMessege)),
        (r) => emit(ListeningSuccess(r)),
      );
    });
  }
}
