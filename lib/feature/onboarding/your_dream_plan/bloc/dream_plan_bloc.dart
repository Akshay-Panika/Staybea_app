import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/dream_plan_repository.dart';
import 'dream_plan_event.dart';
import 'dream_plan_state.dart';

class DreamPlanBloc extends Bloc<DreamPlanEvent, DreamPlanState> {
  final DreamPlanRepository repository;

  DreamPlanBloc(this.repository) : super(DreamPlanInitial()) {
    on<FetchDreamPlanEvent>(_onFetch);
  }

  Future<void> _onFetch(
      FetchDreamPlanEvent event,
      Emitter<DreamPlanState> emit,
      ) async {
    emit(DreamPlanLoading());

    try {
      final data = await repository.fetchDreamPlan();
      emit(DreamPlanLoaded(data));
    } catch (e) {
      emit(DreamPlanError(e.toString()));
    }
  }
}