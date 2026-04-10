import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/your_things_love_repository.dart';
import 'your_things_love_event.dart';
import 'your_things_love_state.dart';

class YourThingsLoveBloc
    extends Bloc<YourThingsLoveEvent, YourThingsLoveState> {
  final YourThingsLoveRepository repository;

  YourThingsLoveBloc(this.repository)
      : super(YourThingsLoveInitial()) {
    on<FetchYourThingsLoveEvent>(_onFetch);
    on<ToggleThingsLoveOptionEvent>(_onToggle);
  }

  Future<void> _onFetch(
      FetchYourThingsLoveEvent event,
      Emitter<YourThingsLoveState> emit,
      ) async {
    try {
      emit(YourThingsLoveLoading());

      final response = await repository.fetchThingsLove(
        category: event.category,
        screen: event.screen,
      );

      emit(YourThingsLoveLoaded(response: response));
    } catch (e) {
      emit(YourThingsLoveError(e.toString()));
    }
  }

  void _onToggle(
      ToggleThingsLoveOptionEvent event,
      Emitter<YourThingsLoveState> emit,
      ) {
    if (state is YourThingsLoveLoaded) {
      final current = state as YourThingsLoveLoaded;

      final updated =
      Map<String, List<String>>.from(current.multiSelections);

      final list =
      List<String>.from(updated[event.questionId] ?? []);

      if (list.contains(event.optionValue)) {
        list.remove(event.optionValue);
      } else {
        list.add(event.optionValue);
      }

      updated[event.questionId] = list;

      emit(current.copyWith(multiSelections: updated));
    }
  }
}