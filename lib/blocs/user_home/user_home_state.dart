import 'package:equatable/equatable.dart';
import '../../data/models/posts.dart';

abstract class UserHomeState extends Equatable {
  const UserHomeState();

  @override
  List<Object> get props => [];
}

class UserHomeInitial extends UserHomeState {}

class UserHomeLoading extends UserHomeState {}

class UserHomeLoaded extends UserHomeState {
  final List<Post> posts;

  const UserHomeLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class UserHomeError extends UserHomeState {}

class UserHomeNavigationSuccess extends UserHomeState {
  final String route;

  const UserHomeNavigationSuccess(this.route);

  @override
  List<Object> get props => [route];
}

class CalendarLoading extends UserHomeState {}

class CalendarLoaded extends UserHomeState {
  final List<Object> calendars;

  const CalendarLoaded(this.calendars);

  @override
  List<Object> get props => [calendars];
}

class CalendarError extends UserHomeState {}
