import 'package:equatable/equatable.dart';

abstract class AdminLoginState extends Equatable {
  const AdminLoginState();

  @override
  List<Object> get props => [];
}

class AdminLoginInitial extends AdminLoginState {}

class AdminLoginLoading extends AdminLoginState {}

class AdminLoginSuccess extends AdminLoginState {
  final String message;

  const AdminLoginSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AdminLoginFailure extends AdminLoginState {
  final String error;

  const AdminLoginFailure(this.error);

  @override
  List<Object> get props => [error];
}
