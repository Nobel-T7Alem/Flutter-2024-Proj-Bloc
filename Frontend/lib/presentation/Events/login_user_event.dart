import 'package:Sebawi/data/models/validate_form.dart';
import 'package:equatable/equatable.dart';

abstract class LoginUserEvent extends Equatable {
  const LoginUserEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginUserEvent {
  const LoginSubmitted();
}

class LoginUserInitialEvent extends LoginUserEvent {
  const LoginUserInitialEvent();
}

class NavigateToUserHomeEvent extends LoginUserEvent {}

class NavigateToAgencyHomeEvent extends LoginUserEvent {}

class UsernameChangedEvent extends LoginUserEvent {
  const UsernameChangedEvent({required this.username});
  final ValidateForm username;
}

class PasswordChangedEvent extends LoginUserEvent {
  const PasswordChangedEvent({required this.password});
  final ValidateForm password;
}

class NavigateToSignupEvent extends LoginUserEvent {}
