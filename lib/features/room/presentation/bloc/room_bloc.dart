import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/core/utils/permessions.dart';
import 'package:saas_mosque/features/room/data/repositories/room_repo.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepo _roomRepo;

  RoomBloc(RoomRepo roomRepo) : _roomRepo = roomRepo, super(RoomInitial()) {
    on<GetPermessions>((event, emit) async {
      emit(RoomLoading());
      (await _roomRepo.getPermessions()).fold(
        (l) => emit(RoomFailure(l.errorMessege)),
        (r) => emit(PermessionsSuccess(r)),
      );
    });
  }
}
