import 'package:Sebawi/utils/extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../data/models/validate_form.dart';
import '../../data/services/api_path.dart';
import 'user_update_event.dart';
import 'user_update_state.dart';

class UserUpdateBloc extends Bloc<UserUpdateEvent, UserUpdateState> {
  UserUpdateBloc() : super(const UserUpdateState()) {
    on<UserUpdateInitialEvent>(_initState);
    on<SubmitUserUpdateEvent>(_onSubmitUserUpdate);
    on<UsernameChangedEvent>(_onUsernameChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<DeleteAccountEvent>(_onDeleteAccount);
  }

  final _formKey =  GlobalKey<FormState>();

  Future<void> _initState(UserUpdateInitialEvent event,
      Emitter<UserUpdateState> emit) async {
    emit(state.copyWith(formKey: _formKey));
  }

  Future<void> _onUsernameChanged(UsernameChangedEvent event,
      Emitter<UserUpdateState> emit) async {
    emit(state.copyWith(
        username: ValidateForm(value: event.username.value)));
  }

  Future<void> _onPasswordChanged(PasswordChangedEvent event,
      Emitter<UserUpdateState> emit) async {
    emit(state.copyWith(
        password: ValidateForm(value: event.password.value)));
  }

  void _onSubmitUserUpdate(SubmitUserUpdateEvent event, Emitter<UserUpdateState> emit) async {
    Map<String, String?> updateData = {
      'username': state.username.value,
      'password': state.password.value,
    };
    updateData.removeWhere((key, value) => value == null || value.isEmpty);
  print(updateData);
    final statusCode = await RemoteService().updateProfile(updateData);

    if (statusCode == 200) {
      emit(state.copyWith(apiMessage: 'Profile updated successfully.'));
    } else {
      String errorMessage;
      switch (statusCode) {
        case 401:
          errorMessage = 'Unauthorized access. Please log in again.';
          break;
        case 400:
          errorMessage = 'Bad request. Please check the submitted data.';
          break;
        default:
          errorMessage = 'Failed to update profile. Please try again later.';
          break;
      }
      emit(state.copyWith(apiError: errorMessage));
    }
  }

  Future<void> _onDeleteAccount(DeleteAccountEvent event, Emitter<UserUpdateState> emit) async {
    final statusCode = await RemoteService().deleteProfile();
    if (statusCode == 200) {
      emit(state.copyWith(apiMessage: 'Account deleted successfully.'));
    } else {
      String errorMessage;
      switch (statusCode) {
        case 401:
          errorMessage = 'Unauthorized access. Please log in again.';
          break;
        case 400:
          errorMessage = 'Bad request. Please check the submitted data.';
          break;
        default:
          errorMessage = 'Failed to delete account. Please try again later.';
          break;
      }
      emit(state.copyWith(apiError: errorMessage));
    }
  }


}
