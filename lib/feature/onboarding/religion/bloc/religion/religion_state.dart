import 'package:equatable/equatable.dart';
import '../../model/religion_model.dart';

abstract class ReligionState extends Equatable {
  const ReligionState();
  @override
  List<Object?> get props => [];
}

class ReligionInitial extends ReligionState {}
class ReligionLoading extends ReligionState {}

class ReligionLoaded extends ReligionState {
  final ReligionResponse response;
  const ReligionLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class ReligionError extends ReligionState {
  final String message;
  const ReligionError(this.message);
  @override
  List<Object?> get props => [message];
}