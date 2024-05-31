import 'package:Sebawi/data/models/validate_form.dart';
import 'package:equatable/equatable.dart';

abstract class UserUpdateEvent extends Equatable {
  const UserUpdateEvent();

  @override
  List<Object> get props => [];
}

class SubmitUserUpdateEvent extends UserUpdateEvent {
  const SubmitUserUpdateEvent();
}

class UserUpdateInitialEvent extends UserUpdateEvent {
  const UserUpdateInitialEvent();
}

class NameChangedEvent extends UserUpdateEvent {
  const NameChangedEvent({required this.name});
  final ValidateForm name;
}

class EmailChangedEvent extends UserUpdateEvent {
  const EmailChangedEvent({required this.email});
  final ValidateForm email;
}

class UsernameChangedEvent extends UserUpdateEvent {
  const UsernameChangedEvent({required this.username});
  final ValidateForm username;
}

class PasswordChangedEvent extends UserUpdateEvent {
  const PasswordChangedEvent({required this.password});
  final ValidateForm password;
}

class DeleteAccountEvent extends UserUpdateEvent {
  const DeleteAccountEvent();
}