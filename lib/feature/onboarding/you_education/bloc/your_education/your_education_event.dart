// education_event.dart  (updated)

abstract class EducationEvent {}

class FetchEducationEvent extends EducationEvent {
  final String flowType;
  FetchEducationEvent({this.flowType = 'marriage'});
}

class SelectEducationEvent extends EducationEvent {
  final String education;
  SelectEducationEvent(this.education);
}