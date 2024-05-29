import 'package:Sebawi/utils/extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../data/models/validate_form.dart';
import '../../data/services/api_path.dart';
import 'volunteer_signup_event.dart';
import 'volunteer_signup_state.dart';

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


  Future<void> _onNameChanged(NameChangedEvent event,
      Emitter<VolunteerSignupState> emit) async {
    emit(state.copyWith(name: ValidateForm(value: event.name.value)));
  }

  Future<void> _onEmailChanged(EmailChangedEvent event,
      Emitter<VolunteerSignupState> emit) async {
    emit(state.copyWith(email: ValidateForm(value: event.email.value)));
  }

  Future<void> _onUsernameChanged(UsernameChangedEvent event,
      Emitter<VolunteerSignupState> emit) async {
    emit(state.copyWith(
        username: ValidateForm(value: event.username.value)));
  }

  Future<void> _onPasswordChanged(PasswordChangedEvent event,
      Emitter<VolunteerSignupState> emit) async {
    emit(state.copyWith(
        password: ValidateForm(value: event.password.value)));
  }

  Future<void> _onConfirmPasswordChanged(ConfirmPasswordChangedEvent event,
      Emitter<VolunteerSignupState> emit) async {
    emit(state.copyWith(confirmPassword: ValidateForm(
        value: event.confirmPassword.value)));
  }


  Future<void> _onSignupButtonPressed(SignupButtonPressed event,
      Emitter<VolunteerSignupState> emit) async {
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
    } else if (state.password.value.length < 8){
      passwordError = "Password has to include at least 8 characters,";
    }
    else if (!state.password.value
        .isValidPassword) { // Assuming you have an extension for password validation
      passwordError = "Password Should include an uppercase letter and a special character";
    }

    if (state.confirmPassword.value.isEmpty) {
      confirmPasswordError = "Confirm Password cannot be empty";
    } else if (state.confirmPassword.value != state.password.value) {
      confirmPasswordError = "Passwords do not match";
    }

    if (nameError == null && emailError == null && usernameError == null &&
        passwordError == null && confirmPasswordError == null) {
      final errorMessage =  await signUp(state.name.value, state.email.value,  state.username.value, state.password.value, "user"
         );
      if (errorMessage == null){
        emit(NavigateToUserHome());
      } else {
        emit(state.copyWith(apiError: errorMessage));
      }
    } else {
      emit(state.copyWith(
        name: ValidateForm(value: state.name.value, error: nameError),
        email: ValidateForm(value: state.email.value, error: emailError),
        username: ValidateForm(
            value: state.username.value, error: usernameError),
        password: ValidateForm(
            value: state.password.value, error: passwordError),
        confirmPassword: ValidateForm(
            value: state.confirmPassword.value, error: confirmPasswordError),
      ));
    }
  }
}




