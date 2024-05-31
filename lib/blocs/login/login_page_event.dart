// login_event.dart
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class AdminLoginPressed extends LoginEvent {}

class UserLoginPressed extends LoginEvent {}

class SignUpPressed extends LoginEvent {}
