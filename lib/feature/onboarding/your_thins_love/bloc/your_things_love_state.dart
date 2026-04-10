import '../model/your_things_love_model.dart';

abstract class YourThingsLoveState {}

class YourThingsLoveInitial extends YourThingsLoveState {}

class YourThingsLoveLoading extends YourThingsLoveState {}

class YourThingsLoveLoaded extends YourThingsLoveState {
  final YourThingsLoveResponse response;
  final Map<String, List<String>> multiSelections;

  YourThingsLoveLoaded({
    required this.response,
    this.multiSelections = const {},
  });

  YourThingsLoveLoaded copyWith({
    Map<String, List<String>>? multiSelections,
  }) {
    return YourThingsLoveLoaded(
      response: response,
      multiSelections: multiSelections ?? this.multiSelections,
    );
  }

  bool isSelected(String questionId, String value) {
    return multiSelections[questionId]?.contains(value) ?? false;
  }
}

class YourThingsLoveError extends YourThingsLoveState {
  final String message;
  YourThingsLoveError(this.message);
}