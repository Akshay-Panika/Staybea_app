import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/your_matters_repository.dart';
import 'your_matters_event.dart';
import 'your_matters_state.dart';

class YouMattersBloc extends Bloc<YouMattersEvent, YouMattersState> {
  final YouMattersRepository repository;

  YouMattersBloc(this.repository) : super(YouMattersInitial()) {
    on<FetchYouMattersEvent>(_onFetch);
    // ✅ only toggle multi needed now
    on<ToggleMultiMattersOptionEvent>(_onToggleMulti);
  }

  Future<void> _onFetch(
      FetchYouMattersEvent event,
      Emitter<YouMattersState> emit,
      ) async {
    try {
      emit(YouMattersLoading());
      final response = await repository.fetchMatters(
        category: event.category,
        screen: event.screen,
      );
      emit(YouMattersLoaded(response: response));
    } catch (e) {
      emit(YouMattersError(e.toString()));
    }
  }

  void _onToggleMulti(
      ToggleMultiMattersOptionEvent event,
      Emitter<YouMattersState> emit,
      ) {
    if (state is YouMattersLoaded) {
      final current = state as YouMattersLoaded;
      final updated =
      Map<String, List<String>>.from(current.multiSelections);
      final currentList =
      List<String>.from(updated[event.questionId] ?? []);

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