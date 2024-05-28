import 'package:equatable/equatable.dart';

abstract class VolunteerSignupEvent extends Equatable {
  const VolunteerSignupEvent();

  @override
  List<Object> get props => [];
}

class SignupButtonPressed extends VolunteerSignupEvent {}

class LoginButtonPressed extends VolunteerSignupEvent {}
