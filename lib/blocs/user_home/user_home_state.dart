import 'package:equatable/equatable.dart';

abstract class UserHomeState extends Equatable {
  const UserHomeState();

  @override
  List<Object> get props => [];
}

class UserHomeInitial extends UserHomeState {}

class UserHomeLoading extends UserHomeState {}

class UserHomeLoaded extends UserHomeState {
  final String data;

  const UserHomeLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class UserHomeError extends UserHomeState {
  final String error;

  const UserHomeError(this.error);

  @override
  List<Object> get props => [error];
}
