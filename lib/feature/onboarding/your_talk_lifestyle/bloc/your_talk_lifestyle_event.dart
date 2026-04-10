// your_talk_lifestyle_event.dart

abstract class LifestyleEvent {}

class FetchLifestyleEvent extends LifestyleEvent {
  final String category;
  final String screen;

  FetchLifestyleEvent({
    this.category = 'DATE_TO_MARRY',
    this.screen = 'LIFESTYLE',
  });
}

class SelectSingleOptionEvent extends LifestyleEvent {
  final String questionId;
  final String optionValue;

  SelectSingleOptionEvent({
    required this.questionId,
    required this.optionValue,
  });
}

class ToggleMultiOptionEvent extends LifestyleEvent {
  final String questionId;
  final String optionValue;

  ToggleMultiOptionEvent({
    required this.questionId,
    required this.optionValue,
  });
}