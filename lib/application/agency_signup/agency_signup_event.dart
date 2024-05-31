import 'package:equatable/equatable.dart';
import '../../data/models/validate_form.dart';
abstract class AgencySignupEvent extends Equatable {
  const AgencySignupEvent();

  @override
  List<Object> get props => [];
}

class AgencySignupButtonPressed extends AgencySignupEvent {
  const AgencySignupButtonPressed();
}

class AgencySignupInitialEvent extends AgencySignupEvent{
  const AgencySignupInitialEvent();
}

class LoginButtonPressed extends AgencySignupEvent {}

class NameChangedEvent extends AgencySignupEvent {
  const NameChangedEvent({ required this.name});
  final ValidateForm name;
}

class EmailChangedEvent extends AgencySignupEvent {
  const EmailChangedEvent({ required this.email});
  final ValidateForm email;
}

class UsernameChangedEvent extends AgencySignupEvent {
  const UsernameChangedEvent({ required this.username});
  final ValidateForm username;
}

class PasswordChangedEvent extends AgencySignupEvent {
  const PasswordChangedEvent({ required this.password});
  final ValidateForm password;
}
class ConfirmPasswordChangedEvent extends AgencySignupEvent {
  const ConfirmPasswordChangedEvent({ required this.confirmPassword});
  final ValidateForm confirmPassword;
}

class NavigateToLogin extends AgencySignupEvent {
}
