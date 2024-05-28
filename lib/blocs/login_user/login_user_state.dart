import 'package:equatable/equatable.dart';

abstract class LoginUserState extends Equatable {
  const LoginUserState();

  @override
  List<Object> get props => [];
}

class LoginUserInitial extends LoginUserState {}

class LoginUserNavigationSuccess extends LoginUserState {
  final String route;

  const LoginUserNavigationSuccess(this.route);

  @override
  List<Object> get props => [route];
}
