import 'package:equatable/equatable.dart';

import '../../data/models/posts.dart';

abstract class UserHomeEvent extends Equatable {
  const UserHomeEvent();

  @override
  List<Object> get props => [];
}

class LoadPostsEvent extends UserHomeEvent {}

class NavigateToUserUpdateEvent extends UserHomeEvent {}

class AddToCalendarEvent extends UserHomeEvent {
  final String date;
  final String id;
   const AddToCalendarEvent(this.date, this.id);

  @override
  List<Object> get props => [date, id];
}

class LoadCalendarEvent extends UserHomeEvent {}

