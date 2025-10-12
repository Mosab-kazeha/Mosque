import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas_mosque/features/room/features/listening/data/models/listening_model.dart';
import 'package:saas_mosque/features/room/features/listening/data/repositories/listening_repo.dart';
import 'package:flutter/material.dart';

part 'listening_event.dart';
part 'listening_state.dart';

class ListeningBloc extends Bloc<ListeningEvent, ListeningState> {
  final ListeningRepo _listeningRepo;

  // int sessionDurationSeconds = 0;

  // late final TextEditingController startPageController;
  // late final TextEditingController endPageController;
  // int? sessionCurrentPage;

  // final List<MistakeModel> sessionMistakes = [];
  // final List<EvaluationModel> sessionE = [];

  ListeningBloc(ListeningRepo listeningRepo)
    : _listeningRepo = listeningRepo,
      // startPageController = TextEditingController(),
      // endPageController = TextEditingController(),
      super(ListeningInitial()) {
    on<FetchListeningData>((event, emit) async {
      emit(ListeningLoading());
      (await _listeningRepo.fetchListeningData()).fold(
        (l) => emit(ListeningFailure(l.errorMessege)),
        (r) => emit(ListeningSuccess(r)),
      );
    });
    // on<FetchEvaluationsData>((event, emit) async {
    //   emit(ListeningLoading());
    //   (await _listeningRepo.fetchEvaluations()).fold(
    //     (l) => emit(ListeningFailure(l.errorMessege)),
    //     (r) => emit(EvaluationsSuccess(r)),
    //   );
    // });
    // on<EndSession>((event, emit) async {
    //   emit(ListeningLoading());
    //   (await _listeningRepo.endSession(event.session)).fold(
    //     (l) => emit(ListeningFailure(l.errorMessege)),
    //     (r) => emit(EndSessionSuccess()),
    //   );
    // });
    // on<EndPage>((event, emit) {
    //   final int startPage = int.parse(startPageController.text);
    //   final int endPage = int.parse(endPageController.text);
    //   if (sessionCurrentPage == null) {
    //     sessionCurrentPage = startPage + 1;
    //   } else {
    //     if (sessionCurrentPage! < endPage) {
    //       sessionCurrentPage = sessionCurrentPage! + 1;
    //     }
    //   }
    //   emit(EndPageSuccess());
    // });
    // on<FetchMistakes>((event, emit) async {
    //   emit(ListeningLoading());
    //   (await _listeningRepo.fetchMistakes()).fold(
    //     (l) => emit(ListeningFailure(l.errorMessege)),
    //     (r) => emit(FetchMistakesSuccess(r)),
    //   );
    // });
  }

  // @override
  // Future<void> close() {
  //   startPageController.dispose();
  //   endPageController.dispose();
  //   return super.close();
  // }
}
