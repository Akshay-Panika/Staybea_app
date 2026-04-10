// education_state.dart

import '../../model/your_education_model.dart';

abstract class EducationState {}

class EducationInitial extends EducationState {}

class EducationLoading extends EducationState {}

class EducationLoaded extends EducationState {
  final EducationResponse response;
  final String? selectedEducation;

  EducationLoaded({required this.response, this.selectedEducation});

  EducationLoaded copyWith({String? selectedEducation}) {
    return EducationLoaded(
      response: response,
      selectedEducation: selectedEducation ?? this.selectedEducation,
    );
  }
}

class EducationError extends EducationState {
  final String message;
  EducationError(this.message);
}