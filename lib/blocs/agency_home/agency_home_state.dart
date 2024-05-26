import 'package:equatable/equatable.dart';

abstract class AgencyHomeState extends Equatable {
  const AgencyHomeState();

  @override
  List<Object> get props => [];
}

class AgencyHomeInitial extends AgencyHomeState {}

class AgencyHomeLoading extends AgencyHomeState {}

class AgencyHomeLoaded extends AgencyHomeState {
  final String data;

  const AgencyHomeLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class AgencyHomeError extends AgencyHomeState {
  final String error;

  const AgencyHomeError(this.error);

  @override
  List<Object> get props => [error];
}
