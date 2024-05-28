import 'dart:convert';

import 'package:Sebawi/data/models/volunteer_signup_form.dart';
import 'package:Sebawi/utils/extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'volunteer_signup_event.dart';
import 'volunteer_signup_state.dart';
import 'package:http/http.dart' as http;

class VolunteerSignupBloc
    extends Bloc<VolunteerSignupEvent, VolunteerSignupState> {
  VolunteerSignupBloc() : super(const VolunteerSignupState()) {
    on<VolunteerSignupInitialEvent>(_initState);
    on<NameChangedEvent>(_onNameChanged);
    on<EmailChangedEvent>(_onEmailChanged);
    on<UsernameChangedEvent>(_onUsernameChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<ConfirmPasswordChangedEvent>(_onConfirmPasswordChanged);
    on<SignupButtonPressed>(_onSignupButtonPressed);
    on<LoginButtonPressed>((event, emit) {
      emit(NavigateToUserLogin());
    });
  }
  final _formKey = GlobalKey<FormState>();
  Future<void> _initState(VolunteerSignupInitialEvent event,
      Emitter<VolunteerSignupState> emit) async {
    emit(state.copyWith(formKey: _formKey));
  }

  Future<void> _onNameChanged(
      NameChangedEvent event, Emitter<VolunteerSignupState> emit) async {
    emit(state.copyWith(
        formKey: _formKey,
        name: VolunteerSignupForm(
            error: event.name.value.isValidName ? null : "Enter name")));
  }

  Future<void> _onEmailChanged(
      EmailChangedEvent event, Emitter<VolunteerSignupState> emit) async {
    emit(state.copyWith(
        formKey: _formKey,
        name: VolunteerSignupForm(
            error: event.email.value.isValidEmail ? null : "Enter email")));
  }

  Future<void> _onUsernameChanged(
      UsernameChangedEvent event, Emitter<VolunteerSignupState> emit) async {
    emit(state.copyWith(
        formKey: _formKey,
        name: VolunteerSignupForm(
            error: event.username.value.isValidUsername ? null : "Enter Username")));
  }

  Future<void> _onPasswordChanged(
      PasswordChangedEvent event, Emitter<VolunteerSignupState> emit) async {
    emit(state.copyWith(
        formKey: _formKey,
        name: VolunteerSignupForm(
            error: event.password.value.isValidPassword ? null : "Enter Password")));
  }

  Future<void> _onConfirmPasswordChanged(
      ConfirmPasswordChangedEvent event, Emitter<VolunteerSignupState> emit) async {
    emit(state.copyWith(
        formKey: _formKey,
        name: VolunteerSignupForm(
            error: event.confirmPassword.value  ? null : "Re-enter password")));
  }

  Future<void> _onSignupButtonPressed(
      SignupButtonPressed event, Emitter<VolunteerSignupState> emit) async {
    if (_formKey.currentState!.validate()) {
      signup( event.name, event.email, event.password, event.username);
    }
    try {
      emit(SignupLoading());

      // Call the signup function with the provided user details
      final success =
          await signup(event.name, event.email, event.password, event.username);

      if (success) {
        emit(SignupSuccess());
        emit(NavigateToUserHome());
      } else {
        emit(const SignupFailure(error: "Signup failed"));
      }
    } catch (error) {
      emit(SignupFailure(error: error.toString()));
    }
  }
}

Future<bool> signup(
    String name, String email, String password, String username) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.7:3000/auth/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      "username": username,
      'email': email,
      'password': password,
      'role': "user"
    }),
  );
  if (response.statusCode == 201) {
    print("success");
    return jsonDecode(response.body);
  } else {
    print("status code:");
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to sign up');
  }
}
