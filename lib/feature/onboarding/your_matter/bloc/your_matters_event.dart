// your_matters_event.dart

abstract class YouMattersEvent {}

class FetchYouMattersEvent extends YouMattersEvent {
  final String category;
  final String screen;

  FetchYouMattersEvent({
    this.category = 'DATE_TO_MARRY',
    this.screen = 'REAL_U_MATTERS',
  });
}

class SelectSingleMattersOptionEvent extends YouMattersEvent {
  final String questionId;
  final String optionValue;

  SelectSingleMattersOptionEvent({
    required this.questionId,
    required this.optionValue,
  });
}

class ToggleMultiMattersOptionEvent extends YouMattersEvent {
  final String questionId;
  final String optionValue;

  ToggleMultiMattersOptionEvent({
    required this.questionId,
    required this.optionValue,
  });
}