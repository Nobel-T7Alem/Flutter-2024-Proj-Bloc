import 'package:equatable/equatable.dart';

abstract class LoginUserEvent extends Equatable {
  const LoginUserEvent();

  @override
  List<Object> get props => [];
}

class LoginUserRequested extends LoginUserEvent {
  final String email;
  final String password;

  const LoginUserRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
