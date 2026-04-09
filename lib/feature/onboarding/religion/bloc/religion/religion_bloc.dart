import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/religion_repository.dart';
import 'religion_event.dart';
import 'religion_state.dart';

class ReligionBloc extends Bloc<ReligionEvent, ReligionState> {
  final ReligionRepository repository;

  ReligionBloc(this.repository) : super(ReligionInitial()) {
    on<FetchReligionEvent>(_fetchReligions);
  }

  Future<void> _fetchReligions(
      FetchReligionEvent event,
      Emitter<ReligionState> emit,
      ) async {
    emit(ReligionLoading());
    try {
      final data = await repository.getReligions();
      emit(ReligionLoaded(data));
    } catch (e) {
      emit(ReligionError(e.toString()));
    }
  }
}