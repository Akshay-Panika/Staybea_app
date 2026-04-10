abstract class YourThingsLoveEvent {}

class FetchYourThingsLoveEvent extends YourThingsLoveEvent {
  final String category;
  final String screen;

  FetchYourThingsLoveEvent({
    this.category = 'DATE_TO_MARRY',
    this.screen = 'THINGS_U_LOVE',
  });
}

class ToggleThingsLoveOptionEvent extends YourThingsLoveEvent {
  final String questionId;
  final String optionValue;

  ToggleThingsLoveOptionEvent({
    required this.questionId,
    required this.optionValue,
  });
}