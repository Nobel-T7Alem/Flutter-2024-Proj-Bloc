// login_state.dart
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class NavigateToAdminLogin extends LoginState {}

class NavigateToUserLogin extends LoginState {}

class NavigateToSignUp extends LoginState {}
