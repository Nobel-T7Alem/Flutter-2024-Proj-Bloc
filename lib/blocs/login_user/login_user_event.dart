import 'package:equatable/equatable.dart';

abstract class LoginUserEvent extends Equatable {
  const LoginUserEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginUserEvent {}

class NavigateToSignupEvent extends LoginUserEvent {}
