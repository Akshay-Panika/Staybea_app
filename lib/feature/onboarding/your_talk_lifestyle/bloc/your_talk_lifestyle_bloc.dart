// your_talk_lifestyle_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/your_talk_lifestyle_repository.dart';
import 'your_talk_lifestyle_event.dart';
import 'your_talk_lifestyle_state.dart';

class LifestyleBloc extends Bloc<LifestyleEvent, LifestyleState> {
  final LifestyleRepository repository;

  LifestyleBloc(this.repository) : super(LifestyleInitial()) {
    on<FetchLifestyleEvent>(_onFetch);
    on<SelectSingleOptionEvent>(_onSelectSingle);
    on<ToggleMultiOptionEvent>(_onToggleMulti);
  }

  Future<void> _onFetch(
      FetchLifestyleEvent event,
      Emitter<LifestyleState> emit,
      ) async {
    try {
      emit(LifestyleLoading());
      final response = await repository.fetchLifestyle(
        category: event.category,
        screen: event.screen,
      );
      emit(LifestyleLoaded(response: response));
    } catch (e) {
      emit(LifestyleError(e.toString()));
    }
  }

  void _onSelectSingle(
      SelectSingleOptionEvent event,
      Emitter<LifestyleState> emit,
      ) {
    if (state is LifestyleLoaded) {
      final current = state as LifestyleLoaded;
      final updated = Map<String, String>.from(current.singleSelections);
      updated[event.questionId] = event.optionValue;
      emit(current.copyWith(singleSelections: updated));
    }
  }

  void _onToggleMulti(
      ToggleMultiOptionEvent event,
      Emitter<LifestyleState> emit,
      ) {
    if (state is LifestyleLoaded) {
      final current = state as LifestyleLoaded;
      final updated = Map<String, List<String>>.from(current.multiSelections);
      final currentList = List<String>.from(updated[event.questionId] ?? []);

      if (currentList.contains(event.optionValue)) {
        currentList.remove(event.optionValue);
      } else {
        currentList.add(event.optionValue);
      }

      updated[event.questionId] = currentList;
      emit(current.copyWith(multiSelections: updated));
    }
  }
}