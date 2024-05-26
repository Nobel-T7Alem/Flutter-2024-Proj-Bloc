import 'package:equatable/equatable.dart';

abstract class UserUpdateState extends Equatable {
  const UserUpdateState();

  @override
  List<Object> get props => [];
}

class UserUpdateInitial extends UserUpdateState {}

class UserUpdateLoading extends UserUpdateState {}

class UserUpdateSuccess extends UserUpdateState {
  final String message;

  const UserUpdateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class UserUpdateFailure extends UserUpdateState {
  final String error;

  const UserUpdateFailure(this.error);

  @override
  List<Object> get props => [error];
}
