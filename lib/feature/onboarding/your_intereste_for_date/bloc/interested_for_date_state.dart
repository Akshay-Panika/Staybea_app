import '../model/interested_for_date_model.dart';

abstract class InterestedForDateState {}

class InterestedForDateInitial extends InterestedForDateState {}

class InterestedForDateLoading extends InterestedForDateState {}

class InterestedForDateLoaded extends InterestedForDateState {
  final InterestedForDateModel model;

  InterestedForDateLoaded(this.model);
}

class InterestedForDateError extends InterestedForDateState {
  final String message;

  InterestedForDateError(this.message);
}