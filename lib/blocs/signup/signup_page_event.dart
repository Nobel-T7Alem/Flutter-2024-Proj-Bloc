import 'package:equatable/equatable.dart';

abstract class SignupPageEvent extends Equatable {
  const SignupPageEvent();

  @override
  List<Object> get props => [];
}

class SubmitSignup extends SignupPageEvent {
  final String username;
  final String email;
  final String password;

  const SubmitSignup(this.username, this.email, this.password);

  @override
  List<Object> get props => [username, email, password];
}
