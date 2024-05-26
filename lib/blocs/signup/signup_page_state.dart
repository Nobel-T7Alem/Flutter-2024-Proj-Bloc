import 'package:equatable/equatable.dart';

abstract class SignupPageState extends Equatable {
  const SignupPageState();

  @override
  List<Object> get props => [];
}

class SignupPageInitial extends SignupPageState {}

class SignupPageLoading extends SignupPageState {}

class SignupPageSuccess extends SignupPageState {
  final String message;

  const SignupPageSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class SignupPageFailure extends SignupPageState {
  final String error;

  const SignupPageFailure(this.error);

  @override
  List<Object> get props => [error];
}
