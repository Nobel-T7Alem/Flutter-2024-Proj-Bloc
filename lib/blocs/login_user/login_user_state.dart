import 'package:equatable/equatable.dart';

abstract class LoginUserState extends Equatable {
  const LoginUserState();

  @override
  List<Object> get props => [];
}

class LoginUserInitial extends LoginUserState {}

class LoginUserLoading extends LoginUserState {}

class LoginUserSuccess extends LoginUserState {
  final String message;

  const LoginUserSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class LoginUserFailure extends LoginUserState {
  final String error;

  const LoginUserFailure(this.error);

  @override
  List<Object> get props => [error];
}
