import '../model/interest_hobby_model.dart';

abstract class InterestHobbyState {}

class InterestHobbyInitial extends InterestHobbyState {}

class InterestHobbyLoading extends InterestHobbyState {}

class InterestHobbyLoaded extends InterestHobbyState {
  final InterestHobbyModel model;

  InterestHobbyLoaded(this.model);
}

class InterestHobbyError extends InterestHobbyState {
  final String message;

  InterestHobbyError(this.message);
}