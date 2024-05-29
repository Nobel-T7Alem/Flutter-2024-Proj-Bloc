import 'package:equatable/equatable.dart';
import "../../data/models/agency_signup_form.dart";
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
  final AgencySignupForm name;
}

class EmailChangedEvent extends AgencySignupEvent {
  const EmailChangedEvent({ required this.email});
  final AgencySignupForm email;
}

class UsernameChangedEvent extends AgencySignupEvent {
  const UsernameChangedEvent({ required this.username});
  final AgencySignupForm username;
}

class PasswordChangedEvent extends AgencySignupEvent {
  const PasswordChangedEvent({ required this.password});
  final AgencySignupForm password;
}
class ConfirmPasswordChangedEvent extends AgencySignupEvent {
  const ConfirmPasswordChangedEvent({ required this.confirmPassword});
  final AgencySignupForm confirmPassword;
}

class NavigateToLogin extends AgencySignupEvent {
}
