import 'package:equatable/equatable.dart';

abstract class AdminLoginEvent extends Equatable {
  const AdminLoginEvent();

  @override
  List<Object> get props => [];
}

class AdminLoginSubmitted extends AdminLoginEvent {
  final String username;
  final String password;

  const AdminLoginSubmitted({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}
