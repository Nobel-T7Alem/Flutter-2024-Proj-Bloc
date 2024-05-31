import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/validate_form.dart';

class LoginUserState extends Equatable {
  final ValidateForm username;
  final ValidateForm password;
  final String? apiError;
  final GlobalKey<FormState>? formKey;
  const LoginUserState({
    this.username = const ValidateForm(error: null),
    this.password = const ValidateForm(error: null),
    this.apiError,
    this.formKey,
  });

  LoginUserState copyWith({
    ValidateForm? username,
    ValidateForm? password,
    String? apiError,
    GlobalKey<FormState>? formKey,
  }) {
    return LoginUserState(
      username: username ?? this.username,
      password: password ?? this.password,
      apiError: apiError ?? this.apiError,
      formKey: formKey ?? this.formKey,
    );
  }

  @override
  List<Object?> get props => [username, password,formKey, apiError];

}

class LoginUserInitial extends LoginUserState {}

class NavigateToUserHome extends LoginUserState {}

class NavigateToAgencyHome extends LoginUserState {}

class LoginUserNavigationSuccess extends LoginUserState {
  final String route;

  const LoginUserNavigationSuccess(this.route);

  @override
  List<Object> get props => [route];
}

class LoginUserFailure extends LoginUserState {
  final String error;
  const LoginUserFailure({required this.error});
}