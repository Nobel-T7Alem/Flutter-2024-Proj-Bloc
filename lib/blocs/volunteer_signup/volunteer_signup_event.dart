import 'package:equatable/equatable.dart';

abstract class VolunteerSignupEvent extends Equatable {
  const VolunteerSignupEvent();

  @override
  List<Object> get props => [];
}

class SubmitVolunteerSignup extends VolunteerSignupEvent {
  final String name;
  final String email;
  final String password;

  const SubmitVolunteerSignup(this.name, this.email, this.password);

  @override
  List<Object> get props => [name, email, password];
}
