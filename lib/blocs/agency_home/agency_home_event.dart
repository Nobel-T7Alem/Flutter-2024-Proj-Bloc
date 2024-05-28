import 'package:equatable/equatable.dart';

abstract class AgencyHomeEvent extends Equatable {
  const AgencyHomeEvent();

  @override
  List<Object> get props => [];
}

class LoadAgencyHomePage extends AgencyHomeEvent {}

class NavigateToAgencyUpdateEvent extends AgencyHomeEvent {}
