import 'package:equatable/equatable.dart';

abstract class VolunteerSignupState extends Equatable {
  const VolunteerSignupState();

  @override
  List<Object> get props => [];
}

class VolunteerSignupInitial extends VolunteerSignupState {}

class VolunteerSignupLoading extends VolunteerSignupState {}

class VolunteerSignupSuccess extends VolunteerSignupState {
  final String message;

  const VolunteerSignupSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class VolunteerSignupFailure extends VolunteerSignupState {
  final String error;

  const VolunteerSignupFailure(this.error);

  @override
  List<Object> get props => [error];
}
