import '../model/dream_plan_model.dart';

abstract class DreamPlanState {}

class DreamPlanInitial extends DreamPlanState {}

class DreamPlanLoading extends DreamPlanState {}

class DreamPlanLoaded extends DreamPlanState {
  final DreamPlanModel model;

  DreamPlanLoaded(this.model);
}

class DreamPlanError extends DreamPlanState {
  final String message;

  DreamPlanError(this.message);
}