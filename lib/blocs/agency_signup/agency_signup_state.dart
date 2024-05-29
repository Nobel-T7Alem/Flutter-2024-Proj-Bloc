import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../data/models/agency_signup_form.dart';

class AgencySignupState extends Equatable {
  final AgencySignupForm name;
  final AgencySignupForm email;
  final AgencySignupForm username;
  final AgencySignupForm password;
  final AgencySignupForm confirmPassword;
  final GlobalKey<FormState>? formKey;
  final String? apiError;

  const AgencySignupState({
    this.name = const AgencySignupForm(error:null),
    this.email = const AgencySignupForm(error:null),
    this.username =const AgencySignupForm(error:null),
    this.password = const AgencySignupForm(error:null),
    this.confirmPassword = const AgencySignupForm(error:null),
    this.formKey,
    this.apiError,
});
  AgencySignupState copyWith({
    AgencySignupForm? name,
    AgencySignupForm? email,
    AgencySignupForm? username,
    AgencySignupForm? password,
    AgencySignupForm? confirmPassword,
    GlobalKey<FormState>? formKey,
    String? apiError,
  }) {
    return AgencySignupState(
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

class AgencySignupInitial extends AgencySignupState {}

class NavigateToAdminHome extends AgencySignupState {}

class NavigateToAdminLogin extends AgencySignupState {}

class SignupLoading extends AgencySignupState {}

class SignupSuccess extends AgencySignupState {}

class SignupFailure extends AgencySignupState {
  final String error;
  const SignupFailure({required this.error});
}


