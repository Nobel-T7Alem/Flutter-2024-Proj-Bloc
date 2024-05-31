import 'package:equatable/equatable.dart';
import '../../data/models/validate_form.dart';

abstract class VolunteerSignupEvent extends Equatable {
  const VolunteerSignupEvent();

  @override
  List<Object> get props => [];
}

class SignupButtonPressed extends VolunteerSignupEvent {
  const SignupButtonPressed();
}
class VolunteerSignupInitialEvent extends VolunteerSignupEvent {
  const VolunteerSignupInitialEvent();
}


class LoginButtonPressed extends VolunteerSignupEvent {}

class NameChangedEvent extends VolunteerSignupEvent {
  const NameChangedEvent({ required this.name});
  final ValidateForm name;
}

class EmailChangedEvent extends VolunteerSignupEvent {
  const EmailChangedEvent({ required this.email});
  final ValidateForm email;
}

class UsernameChangedEvent extends VolunteerSignupEvent {
  const UsernameChangedEvent({ required this.username});
  final ValidateForm username;
}

class PasswordChangedEvent extends VolunteerSignupEvent {
  const PasswordChangedEvent({ required this.password});
  final ValidateForm password;
}
class ConfirmPasswordChangedEvent extends VolunteerSignupEvent {
  const ConfirmPasswordChangedEvent({ required this.confirmPassword});
  final ValidateForm confirmPassword;
}