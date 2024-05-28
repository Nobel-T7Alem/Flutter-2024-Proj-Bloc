import 'package:equatable/equatable.dart';

abstract class VolunteerSignupState extends Equatable {
  const VolunteerSignupState();

  @override
  List<Object> get props => [];
}

class VolunteerSignupInitial extends VolunteerSignupState {}

class NavigateToUserHome extends VolunteerSignupState {}

class NavigateToUserLogin extends VolunteerSignupState {}
