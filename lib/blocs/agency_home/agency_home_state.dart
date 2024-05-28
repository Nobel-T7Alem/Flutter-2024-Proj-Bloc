import 'package:equatable/equatable.dart';

import '../../presentation/screens/agency_home.dart'; 

abstract class AgencyHomeState extends Equatable {
  const AgencyHomeState();

  @override
  List<Object> get props => [];
}

class AgencyHomeInitial extends AgencyHomeState {}

class AgencyHomeLoading extends AgencyHomeState {}

class AgencyHomeLoaded extends AgencyHomeState {
  final List<Post> posts;

  const AgencyHomeLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class AgencyHomeError extends AgencyHomeState {
  final String error;

  const AgencyHomeError(this.error);

  @override
  List<Object> get props => [error];
}

class AgencyHomeNavigationSuccess extends AgencyHomeState {
  final String route;

  const AgencyHomeNavigationSuccess(this.route);

  @override
  List<Object> get props => [route];
}
