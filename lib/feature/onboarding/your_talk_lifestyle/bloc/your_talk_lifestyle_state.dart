// your_talk_lifestyle_state.dart

import '../model/your_talk_lifestyle_model.dart';

abstract class LifestyleState {}

class LifestyleInitial extends LifestyleState {}

class LifestyleLoading extends LifestyleState {}

class LifestyleLoaded extends LifestyleState {
  final LifestyleResponse response;

  // questionId -> single selected value
  final Map<String, String> singleSelections;

  // questionId -> multiple selected values
  final Map<String, List<String>> multiSelections;

  LifestyleLoaded({
    required this.response,
    this.singleSelections = const {},
    this.multiSelections = const {},
  });

  LifestyleLoaded copyWith({
    Map<String, String>? singleSelections,
    Map<String, List<String>>? multiSelections,
  }) {
    return LifestyleLoaded(
      response: response,
      singleSelections: singleSelections ?? this.singleSelections,
      multiSelections: multiSelections ?? this.multiSelections,
    );
  }

  // Helper: check if single option is selected
  bool isSingleSelected(String questionId, String value) {
    return singleSelections[questionId] == value;
  }

  // Helper: check if multi option is selected
  bool isMultiSelected(String questionId, String value) {
    return multiSelections[questionId]?.contains(value) ?? false;
  }
}

class LifestyleError extends LifestyleState {
  final String message;
  LifestyleError(this.message);
}