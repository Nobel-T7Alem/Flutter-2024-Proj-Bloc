import 'package:Sebawi/data/models/volunteer_signup_form.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

 class VolunteerSignupState extends Equatable {
  final VolunteerSignupForm name;
  final VolunteerSignupForm email;
  final VolunteerSignupForm username;
  final VolunteerSignupForm password;
  final VolunteerSignupForm confirmPassword;
  final GlobalKey<FormState>? formKey;
  final String? apiError;

  const VolunteerSignupState({
    this.name = const VolunteerSignupForm(error:null),
    this.email = const VolunteerSignupForm(error:null),
    this.username =const VolunteerSignupForm(error:null),
    this.password = const VolunteerSignupForm(error:null),
    this.confirmPassword = const VolunteerSignupForm(error:null),
    this.formKey,
    this.apiError,
});

  VolunteerSignupState copyWith({
    VolunteerSignupForm? name,
    VolunteerSignupForm? email,
    VolunteerSignupForm? username,
    VolunteerSignupForm? password,
    VolunteerSignupForm? confirmPassword,
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
