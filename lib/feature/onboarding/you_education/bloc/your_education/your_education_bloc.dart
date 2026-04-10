// education_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staybea_app/feature/onboarding/you_education/bloc/your_education/your_education_event.dart';
import 'package:staybea_app/feature/onboarding/you_education/bloc/your_education/your_education_state.dart';

import '../../repository/your_education_repository.dart';


class EducationBloc extends Bloc<EducationEvent, EducationState> {
  final EducationRepository repository;

  EducationBloc(this.repository) : super(EducationInitial()) {
    on<FetchEducationEvent>(_onFetchEducation);
    on<SelectEducationEvent>(_onSelectEducation);
  }

  Future<void> _onFetchEducation(
      FetchEducationEvent event,
      Emitter<EducationState> emit,
      ) async {
    try {
      emit(EducationLoading());
      final response = await repository.fetchEducation(flowType: event.flowType);
      emit(EducationLoaded(response: response));
    } catch (e) {
      emit(EducationError(e.toString()));
    }
  }

  void _onSelectEducation(
      SelectEducationEvent event,
      Emitter<EducationState> emit,
      ) {
    if (state is EducationLoaded) {
      final current = state as EducationLoaded;
      emit(current.copyWith(selectedEducation: event.education));
    }
  }
}