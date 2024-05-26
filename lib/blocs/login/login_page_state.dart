import 'package:equatable/equatable.dart';

abstract class LoginPageState extends Equatable {
  const LoginPageState();

  @override
  List<Object> get props => [];
}

class LoginPageInitial extends LoginPageState {}

class LoginPageNavigationSuccess extends LoginPageState {
  final String route;

  const LoginPageNavigationSuccess(this.route);

  @override
  List<Object> get props => [route];
}
