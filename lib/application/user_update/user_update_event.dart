import 'package:equatable/equatable.dart';

abstract class UserUpdateEvent extends Equatable {
  const UserUpdateEvent();

  @override
  List<Object> get props => [];
}

class SubmitUserUpdate extends UserUpdateEvent {
  final Map<String, dynamic> userData;

  const SubmitUserUpdate(this.userData);

  @override
  List<Object> get props => [userData];
}
