import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/interest_hobby_repository.dart';
import 'interest_hobby_event.dart';
import 'interest_hobby_state.dart';

class InterestHobbyBloc extends Bloc<InterestHobbyEvent, InterestHobbyState> {
  final InterestHobbyRepository repository;

  InterestHobbyBloc(this.repository) : super(InterestHobbyInitial()) {
    on<FetchInterestHobbyEvent>(_onFetch);
  }

  Future<void> _onFetch(
      FetchInterestHobbyEvent event,
      Emitter<InterestHobbyState> emit,
      ) async {
    emit(InterestHobbyLoading());

    try {
      final data = await repository.fetchInterestHobby();
      emit(InterestHobbyLoaded(data));
    } catch (e) {
      emit(InterestHobbyError(e.toString()));
    }
  }
}