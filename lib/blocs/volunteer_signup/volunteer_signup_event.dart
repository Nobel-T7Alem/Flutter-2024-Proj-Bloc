import 'package:equatable/equatable.dart';

import '../../data/models/volunteer_signup_form.dart';

abstract class VolunteerSignupEvent extends Equatable {
  const VolunteerSignupEvent();

  @override
  List<Object> get props => [];
}

class SignupButtonPressed extends VolunteerSignupEvent {
  final String name;
  final String email;
  final String password;
  final String username;
  const SignupButtonPressed({
    required this.name,
    required this.email,
    required this.password,
    required this.username
  });
}
class VolunteerSignupInitialEvent extends VolunteerSignupEvent {
  const VolunteerSignupInitialEvent();
}
class ValidateForm extends VolunteerSignupEvent {
  final String name;
  final String email;
  final String username;
  final String password;

  const ValidateForm({
    required this.name,
    required this.email,
    required this.username,
    required this.password,
  });
}

class LoginButtonPressed extends VolunteerSignupEvent {}

class NameChangedEvent extends VolunteerSignupEvent {
  const NameChangedEvent({ required this.name});
  final VolunteerSignupForm name;
}

class EmailChangedEvent extends VolunteerSignupEvent {
  const EmailChangedEvent({ required this.email});
  final VolunteerSignupForm email;
}

class UsernameChangedEvent extends VolunteerSignupEvent {
  const UsernameChangedEvent({ required this.username});
  final VolunteerSignupForm username;
}

class PasswordChangedEvent extends VolunteerSignupEvent {
  const PasswordChangedEvent({ required this.password});
  final VolunteerSignupForm password;
}
class ConfirmPasswordChangedEvent extends VolunteerSignupEvent {
  const ConfirmPasswordChangedEvent({ required this.confirmPassword});
  final VolunteerSignupForm confirmPassword;
}