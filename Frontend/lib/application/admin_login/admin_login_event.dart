import 'package:equatable/equatable.dart';
import '../../data/models/validate_form.dart';

abstract class AdminLoginEvent extends Equatable {
  const AdminLoginEvent();

  @override
  List<Object> get props => [];
}

class AdminLoginSubmitted extends AdminLoginEvent {
  const AdminLoginSubmitted({required String username, required String password});
}

class AdminLoginInitialEvent extends AdminLoginEvent{
  const AdminLoginInitialEvent();
}

class NavigateToAdminHomeEvent extends AdminLoginEvent{}

class UsernameChangedEvent extends AdminLoginEvent {
  const UsernameChangedEvent({required this.username});
  final ValidateForm username;
}

class PasswordChangedEvent extends AdminLoginEvent {
  const PasswordChangedEvent({required this.password});
  final ValidateForm password;
}
