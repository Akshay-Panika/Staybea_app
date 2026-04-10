// your_matters_state.dart

import '../model/your_matters_model.dart';

abstract class YouMattersState {}

class YouMattersInitial extends YouMattersState {}

class YouMattersLoading extends YouMattersState {}

class YouMattersLoaded extends YouMattersState {
  final YouMattersResponse response;
  final Map<String, String> singleSelections;
  final Map<String, List<String>> multiSelections;

  YouMattersLoaded({
    required this.response,
    this.singleSelections = const {},
    this.multiSelections = const {},
  });

  YouMattersLoaded copyWith({
    Map<String, String>? singleSelections,
    Map<String, List<String>>? multiSelections,
  }) {
    return YouMattersLoaded(
      response: response,
      singleSelections: singleSelections ?? this.singleSelections,
      multiSelections: multiSelections ?? this.multiSelections,
    );
  }

  bool isSingleSelected(String questionId, String value) {
    return singleSelections[questionId] == value;
  }

  bool isMultiSelected(String questionId, String value) {
    return multiSelections[questionId]?.contains(value) ?? false;
  }
}

class YouMattersError extends YouMattersState {
  final String message;
  YouMattersError(this.message);
}