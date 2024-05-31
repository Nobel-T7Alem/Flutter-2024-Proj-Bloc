import 'package:Sebawi/utils/extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../data/models/validate_form.dart';
import 'agency_signup_event.dart';
import 'agency_signup_state.dart';

class AgencySignupBloc extends Bloc<AgencySignupEvent, AgencySignupState> {
  AgencySignupBloc() : super(const AgencySignupState()) {
    on<AgencySignupInitialEvent>(_initState);
    on<NameChangedEvent>(_onNameChanged);
    on<EmailChangedEvent>(_onEmailChanged);
    on<UsernameChangedEvent>(_onUsernameChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<ConfirmPasswordChangedEvent>(_onConfirmPasswordChanged);
    on<AgencySignupButtonPressed>(_onAgencySignupSubmitted);
    on<LoginButtonPressed>((event, emit) {
      emit(NavigateToAdminLogin());
    });
    on<NavigateToLogin>((event, emit) {
      emit(NavigateToAdminHome());
    });
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _initState(AgencySignupInitialEvent event, Emitter<AgencySignupState> emit) async {
    emit(state.copyWith(formKey: _formKey));
  }

  Future<void> _onNameChanged(NameChangedEvent event, Emitter<AgencySignupState> emit) async {
    emit(state.copyWith(name: ValidateForm(value: event.name.value)));
  }

  Future<void> _onEmailChanged(EmailChangedEvent event, Emitter<AgencySignupState> emit) async {
    emit(state.copyWith(email: ValidateForm(value: event.email.value)));
  }

  Future<void> _onUsernameChanged(UsernameChangedEvent event, Emitter<AgencySignupState> emit) async {
    emit(state.copyWith(username: ValidateForm(value: event.username.value)));
  }

  Future<void> _onPasswordChanged(PasswordChangedEvent event, Emitter<AgencySignupState> emit) async {
    emit(state.copyWith(password: ValidateForm(value: event.password.value)));
  }

  Future<void> _onConfirmPasswordChanged(ConfirmPasswordChangedEvent event, Emitter<AgencySignupState> emit) async {
    emit(state.copyWith(confirmPassword: ValidateForm(value: event.confirmPassword.value)));
  }

  Future<void> _onAgencySignupSubmitted(AgencySignupButtonPressed event, Emitter<AgencySignupState> emit) async {
    String? nameError;
    String? emailError;
    String? usernameError;
    String? passwordError;
    String? confirmPasswordError;

    if (state.name.value.isEmpty) {
      nameError = "Please enter your name";
    }

    if (state.email.value.isEmpty) {
      emailError = "Email cannot be empty";
    } else if (!state.email.value.isValidEmail) {
      emailError = "Invalid email";
    }

    if (state.username.value.isEmpty) {
      usernameError = "Username cannot be empty";
    } else if (!state.username.value.isValidUsername) {
      usernameError = "Invalid username";
    }

    if (state.password.value.isEmpty) {
      passwordError = "Password cannot be empty";
    } else if (state.password.value.length < 8) {
      passwordError = "Password has to include at least 8 characters,";
    } else if (!state.password.value.isValidPassword) {
      passwordError = "Password Should include an uppercase letter and a special character";
    }

    if (state.confirmPassword.value.isEmpty) {
      confirmPasswordError = "Confirm Password cannot be empty";
    } else if (state.confirmPassword.value != state.password.value) {
      confirmPasswordError = "Passwords do not match";
    }

    if (nameError == null && emailError == null && usernameError == null &&
        passwordError == null && confirmPasswordError == null) {
      // Simulate a successful signup for testing purposes
      emit(NavigateToAdminHome());
    } else {
      emit(state.copyWith(
        name: ValidateForm(value: state.name.value, error: nameError),
        email: ValidateForm(value: state.email.value, error: emailError),
        username: ValidateForm(value: state.username.value, error: usernameError),
        password: ValidateForm(value: state.password.value, error: passwordError),
        confirmPassword: ValidateForm(value: state.confirmPassword.value, error: confirmPasswordError),
      ));
    }
  }
}
