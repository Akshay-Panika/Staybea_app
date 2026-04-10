import '../model/health_wellness_model.dart';

abstract class HealthWellnessState {}

class HealthWellnessInitial extends HealthWellnessState {}

class HealthWellnessLoading extends HealthWellnessState {}

class HealthWellnessLoaded extends HealthWellnessState {
  final List<HealthWellnessModel> questions;

  HealthWellnessLoaded(this.questions);
}

class HealthWellnessError extends HealthWellnessState {
  final String message;

  HealthWellnessError(this.message);
}