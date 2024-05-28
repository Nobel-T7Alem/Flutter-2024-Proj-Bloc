import 'package:equatable/equatable.dart';

abstract class UserHomeEvent extends Equatable {
  const UserHomeEvent();

  @override
  List<Object> get props => [];
}

class LoadPostsEvent extends UserHomeEvent {}

class NavigateToUserUpdateEvent extends UserHomeEvent {}
