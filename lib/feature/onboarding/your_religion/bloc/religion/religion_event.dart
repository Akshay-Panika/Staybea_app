import 'package:equatable/equatable.dart';

abstract class ReligionEvent extends Equatable {
  const ReligionEvent();
  @override
  List<Object?> get props => [];
}

class FetchReligionEvent extends ReligionEvent {}