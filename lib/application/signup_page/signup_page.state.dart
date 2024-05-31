import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupNavigationSuccess extends SignupState {
  final String route;

  const SignupNavigationSuccess(this.route);

  @override
  List<Object> get props => [route];
}
