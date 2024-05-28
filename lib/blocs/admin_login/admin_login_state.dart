import 'package:equatable/equatable.dart';

abstract class AdminLoginState extends Equatable {
  const AdminLoginState();

  @override
  List<Object> get props => [];
}

class AdminLoginInitial extends AdminLoginState {}

class AdminLoginSuccess extends AdminLoginState {}

class AdminLoginFailure extends AdminLoginState {}
