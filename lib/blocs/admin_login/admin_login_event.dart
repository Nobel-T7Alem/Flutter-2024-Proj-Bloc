import 'package:equatable/equatable.dart';

abstract class AdminLoginEvent extends Equatable {
  const AdminLoginEvent();

  @override
  List<Object> get props => [];
}

class AdminLoginRequested extends AdminLoginEvent {
  final String username;
  final String password;

  const AdminLoginRequested(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}
