import 'package:equatable/equatable.dart';

abstract class UserUpdateState extends Equatable {
  const UserUpdateState();

  @override
  List<Object> get props => [];
}

class UserUpdateInitial extends UserUpdateState {}

class UserUpdateNavigationSuccess extends UserUpdateState {
  final String route;

  const UserUpdateNavigationSuccess(this.route);

  @override
  List<Object> get props => [route];
}
