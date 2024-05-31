import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/validate_form.dart';

class UserUpdateState extends Equatable {
  final ValidateForm name;
  final ValidateForm email;
  final ValidateForm username;
  final ValidateForm password;
  final GlobalKey<FormState>? formKey;
  final String? apiError;
  final String? apiMessage;


  const UserUpdateState({
    this.name = const ValidateForm(error: null),
    this.email = const ValidateForm(error: null),
    this.username = const ValidateForm(error: null),
    this.password = const ValidateForm(error: null),
    this.formKey,
    this.apiError,
    this.apiMessage,

  });

  UserUpdateState copyWith({
    ValidateForm? username,
    ValidateForm? password,
    GlobalKey<FormState>? formKey,
    String? apiError,
    String? apiMessage,
  }) {
    return UserUpdateState(
      username: username ?? this.username,
      password: password ?? this.password,
      formKey: formKey ?? this.formKey,
      apiError: apiError ?? this.apiError,
      apiMessage: apiMessage ?? this.apiMessage,

    );
  }
  @override
  List<Object?> get props => [username, password, formKey, apiError, apiMessage];
}

class UserUpdateInitial extends UserUpdateState {}

class UserUpdateNavigationSuccess extends UserUpdateState {
  final String route;

  const UserUpdateNavigationSuccess(this.route);

  @override
  List<Object> get props => [route];
}

class UserUpdateLoading extends UserUpdateState {}

class UserUpdateSuccess extends UserUpdateState {
  final String message;

  const UserUpdateSuccess({required this.message});
}

class UserUpdateFailure extends UserUpdateState {
  final String error;

  const UserUpdateFailure({required this.error});
}