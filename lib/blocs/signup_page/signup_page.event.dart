import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class NavigateToVolunteerSignupEvent extends SignupEvent {}

class NavigateToAgencySignupEvent extends SignupEvent {}
