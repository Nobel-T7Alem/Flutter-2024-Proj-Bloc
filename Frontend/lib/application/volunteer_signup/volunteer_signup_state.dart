import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/validate_form.dart';

 class VolunteerSignupState extends Equatable {
  final ValidateForm name;
  final ValidateForm email;
  final ValidateForm username;
  final ValidateForm password;
  final ValidateForm confirmPassword;
  final GlobalKey<FormState>? formKey;
  final String? apiError;

  const VolunteerSignupState({
    this.name = const ValidateForm(error:null),
    this.email = const ValidateForm(error:null),
    this.username =const ValidateForm(error:null),
    this.password = const ValidateForm(error:null),
    this.confirmPassword = const ValidateForm(error:null),
    this.formKey,
    this.apiError,
});

  VolunteerSignupState copyWith({
    ValidateForm? name,
    ValidateForm? email,
    ValidateForm? username,
    ValidateForm? password,
    ValidateForm? confirmPassword,
    GlobalKey<FormState>? formKey,
    String? apiError,
  }) {
    return VolunteerSignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      formKey: formKey ?? this.formKey,
      apiError: apiError ?? this.apiError,
    );
  }
  @override
  List<Object?> get props => [name, email, username, password, confirmPassword, formKey, apiError];
}

class VolunteerSignupInitial extends VolunteerSignupState {}

class NavigateToUserHome extends VolunteerSignupState {}

class NavigateToUserLogin extends VolunteerSignupState {}

class SignupLoading extends VolunteerSignupState {}

class SignupSuccess extends VolunteerSignupState {}

class SignupFailure extends VolunteerSignupState {
  final String error;
  const SignupFailure({required this.error});
}
