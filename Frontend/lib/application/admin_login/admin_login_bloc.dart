import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../data/models/validate_form.dart';
import '../../data/services/api_path.dart';
import 'admin_login_event.dart';
import 'admin_login_state.dart';

class AdminLoginBloc extends Bloc<AdminLoginEvent, AdminLoginState> {
  AdminLoginBloc() : super(AdminLoginInitial()) {
    on<AdminLoginInitialEvent>(_initState);
    on<AdminLoginSubmitted>(_onAdminLoginSubmitted);
    on<NavigateToAdminHomeEvent>(_onNavigateToAdminHome);
    on<UsernameChangedEvent>(_onUsernameChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _initState(AdminLoginInitialEvent event, Emitter<AdminLoginState> emit) async {
    emit(AdminLoginState(formKey: _formKey));
  }

  Future<void> _onUsernameChanged(UsernameChangedEvent event, Emitter<AdminLoginState> emit) async {
    emit(state.copyWith(username: ValidateForm(value: event.username.value)));
  }

  Future<void> _onPasswordChanged(PasswordChangedEvent event, Emitter<AdminLoginState> emit) async {
    emit(state.copyWith(password: ValidateForm(value: event.password.value)));
  }

  Future _onAdminLoginSubmitted(AdminLoginSubmitted event, Emitter<AdminLoginState> emit) async {
    String? usernameError;
    String? passwordError;

    if (state.username.value.isEmpty) {
      usernameError = 'Admin Username is required';
    }
    if (state.password.value.isEmpty) {
      passwordError = 'Admin Password is required';
    }
    if(usernameError == null && passwordError == null) {
      final response = await RemoteService().logIn(
        state.username.value,
        state.password.value,
      );
      if(response == "admin") {
        emit(AdminLoginSuccess());
        return;
      } else {
        emit(state.copyWith(apiError: response));
        return;
      }
    } else{
      emit(state.copyWith(username: ValidateForm(error: usernameError), password: ValidateForm(error: passwordError)));
    }
  }

  void _onNavigateToAdminHome(event, emit) {
    emit(NavigateToAdminHome());
  }
}
