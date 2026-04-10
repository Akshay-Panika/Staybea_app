import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/interested_for_date_repository.dart';
import 'interested_for_date_event.dart';
import 'interested_for_date_state.dart';

class InterestedForDateBloc
    extends Bloc<InterestedForDateEvent, InterestedForDateState> {
  final InterestedForDateRepository repository;

  InterestedForDateBloc(this.repository)
      : super(InterestedForDateInitial()) {
    on<FetchInterestedForDateEvent>(_onFetch);
  }

  Future<void> _onFetch(
      FetchInterestedForDateEvent event,
      Emitter<InterestedForDateState> emit,
      ) async {
    emit(InterestedForDateLoading());

    try {
      final data = await repository.getInterestedForDate();
      emit(InterestedForDateLoaded(data));
    } catch (e) {
      emit(InterestedForDateError(e.toString()));
    }
  }
}