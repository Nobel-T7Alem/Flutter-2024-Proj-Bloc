import 'package:equatable/equatable.dart';

abstract class LoginPageEvent extends Equatable {
  const LoginPageEvent();

  @override
  List<Object> get props => [];
}

class NavigateToAdminPage extends LoginPageEvent {}

class NavigateToUserLogin extends LoginPageEvent {}

class NavigateToSignup extends LoginPageEvent {}
