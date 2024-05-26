import 'package:equatable/equatable.dart';

abstract class UserUpdateEvent extends Equatable {
  const UserUpdateEvent();

  @override
  List<Object> get props => [];
}

class SubmitUserUpdate extends UserUpdateEvent {
  final String name;
  final String email;
  final String address;

  const SubmitUserUpdate(this.name, this.email, this.address);

  @override
  List<Object> get props => [name, email, address];
}
