import 'package:flutter/material.dart';
import '../../data/models/validate_form.dart';
import 'package:equatable/equatable.dart';

class AdminLoginState extends Equatable {
  final ValidateForm username;
  final ValidateForm password;
  final  String? apiError;
  final GlobalKey<FormState>? formKey;
  const AdminLoginState({
    this.username = const ValidateForm(error: null),
    this.password = const ValidateForm(error: null),
    this.apiError,
    this.formKey,
  });

  AdminLoginState copyWith({
    ValidateForm? username,
    ValidateForm? password,
    String? apiError,
    GlobalKey<FormState>? formKey,
  }) {
    return AdminLoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      apiError: apiError ?? this.apiError,
      formKey: formKey ?? this.formKey,
    );
  }

  @override
  List<Object?> get props => [username, password,formKey, apiError];
}

class AdminLoginInitial extends AdminLoginState {}

class AdminLoginSuccess extends AdminLoginState {}

class AdminLoginFailure extends AdminLoginState {
  final String error;
  const AdminLoginFailure({required this.error});
}

class NavigateToAdminHome extends AdminLoginState {}