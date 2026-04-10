import 'package:flutter_bloc/flutter_bloc.dart';
import 'health_wellness_event.dart';
import 'health_wellness_state.dart';
import '../repository/health_wellness_repository.dart';

class HealthWellnessBloc
    extends Bloc<HealthWellnessEvent, HealthWellnessState> {
  final HealthWellnessRepository repository;

  HealthWellnessBloc(this.repository)
      : super(HealthWellnessInitial()) {
    on<FetchHealthWellnessEvent>(_onFetch);
  }

  Future<void> _onFetch(
      FetchHealthWellnessEvent event,
      Emitter<HealthWellnessState> emit,
      ) async {
    emit(HealthWellnessLoading());

    try {
      final data = await repository.fetchHealthWellness();
      emit(HealthWellnessLoaded(data));
    } catch (e) {
      emit(HealthWellnessError(e.toString()));
    }
  }
}